//
//  SBudgetMonth.swift
//  BudgetControlSwift
//
//  Created by Roman Rybachenko on 1/5/15.
//  Copyright (c) 2015 Roman Rybachenko. All rights reserved.
//

import UIKit
import CoreData

@objc(CDBudgetMonth)
class CDBudgetMonth: NSManagedObject {
    
    //MARK: Variables
    @NSManaged var currency: String
    @NSManaged var monthDate: NSDate
    @NSManaged var entries: NSSet
    
    
    //MARK: Class Methods
    class func getBudget(date:NSDate, context:NSManagedObjectContext) -> CDBudgetMonth {
        var budget: CDBudgetMonth?
        
        var monthDate = DateFormatterManager.sharedInstance.monthDateFromDate(NSDate())
        var predicate = NSPredicate(format: "monthDate == %@", monthDate!)
        
        var className: String = CDBudgetMonth.description()
        var fetchRequest = NSFetchRequest(entityName: className)
        fetchRequest.predicate = predicate
        var error: NSError?
        
        
        budget = context.executeFetchRequest(fetchRequest, error: &error)!.first as? CDBudgetMonth
        
        if  budget === nil {
            let entityDescription: NSEntityDescription = NSEntityDescription.entityForName(className, inManagedObjectContext: context)!
            budget = CDBudgetMonth(entity: entityDescription, insertIntoManagedObjectContext: context)
            budget?.monthDate = monthDate!
            budget?.currency = "UAH"
            
            if  (!context.save(&error)) {
                println("Error save CDBudgetMonth -> \(error?.description)")
            } else {
                println("New budget created")
            }
        }
        
        return budget!
    }
    
    
    func calculationAllEntriesWithType(type:NSNumber) -> NSDecimalNumber {
        var predicate: NSPredicate = NSPredicate(format: "eType == %@", type)!
        
        var allEntries: NSArray = entries.allObjects
        allEntries = allEntries.filteredArrayUsingPredicate(predicate)
        
        var sum: NSDecimalNumber = NSDecimalNumber(double: 0.0)
        
        
        for var i = 0; i < allEntries.count; i++ {
            let currIncome: CDEntry = allEntries[i] as CDEntry
            sum = sum.decimalNumberByAdding(currIncome.ePrice)
        }
        
        
        return sum;
    }
    
    func isAvailableExpense(expensePrise:Double) -> Bool {
        var available: Bool = false
        
        let incomeSum: Double = self.calculationAllEntriesWithType(NSNumber(integer: EntryType.EntryTypeIncome.rawValue)).doubleValue;
        let expensesSum: Double = self.calculationAllEntriesWithType(NSNumber(integer: EntryType.EntryTypeExpense.rawValue)).doubleValue
        
        if  (incomeSum - expensesSum) - expensePrise > 0.0 {
            available = true
        }
        
        return available;
    }
}
