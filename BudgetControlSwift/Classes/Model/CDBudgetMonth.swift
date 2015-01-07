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
        
        if  budget == nil {
            let entityDescription: NSEntityDescription = NSEntityDescription.entityForName(className, inManagedObjectContext: context)!
            budget = CDBudgetMonth(entity: entityDescription, insertIntoManagedObjectContext: context)
            budget?.monthDate = monthDate!
            
            if  (!context.save(&error)) {
                println("Error save CDBudgetMonth -> \(error?.description)")
            }
        }
        
        return budget!
    }
}
