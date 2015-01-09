//
//  SEntry.swift
//  BudgetControlSwift
//
//  Created by Roman Rybachenko on 1/5/15.
//  Copyright (c) 2015 Roman Rybachenko. All rights reserved.
//

import UIKit
import CoreData

@objc(CDEntry)
class CDEntry: NSManagedObject {
    
    //MARK: variables
    @NSManaged var eCheckAddress: String
    @NSManaged var eDate: NSDate
    @NSManaged var eDescription: String
    @NSManaged var ePrice: NSDecimalNumber
    @NSManaged var eType: NSNumber
    
    @NSManaged var budget: CDBudgetMonth
    @NSManaged var category: CDEntryCategory
    
    //MARK: Class methods
    class func createEntry(date:NSDate, categoryName:String, categoryType:NSNumber, entryDescription:String, money:NSDecimalNumber, checkAddress:String, context:NSManagedObjectContext) -> CDEntry {
        
        var className = CDEntry.description()
        var error: NSError?
        
        let entityDescription: NSEntityDescription = NSEntityDescription.entityForName(className, inManagedObjectContext: context)!
        let newEntry: CDEntry = CDEntry(entity: entityDescription, insertIntoManagedObjectContext: context)
        newEntry.eDate = date
        newEntry.eCheckAddress = checkAddress
        newEntry.eDescription = entryDescription
        newEntry.ePrice = money
        newEntry.budget = CDBudgetMonth.getBudget(date, context: context)
        newEntry.category = CDEntryCategory.getCategory(categoryName, iconName: nil, type: categoryType, context: context)
        newEntry.eType = categoryType
        
        CoreDataManager.sharedInstance.saveContext()
        
        return newEntry
    }
    
}
