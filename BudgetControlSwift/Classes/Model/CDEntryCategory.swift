//
//  SEntryCategory.swift
//  BudgetControlSwift
//
//  Created by Roman Rybachenko on 1/5/15.
//  Copyright (c) 2015 Roman Rybachenko. All rights reserved.
//

import UIKit
import CoreData

@objc(CDEntryCategory)
class CDEntryCategory: NSManagedObject {
    
    //MARK: variables
    @NSManaged var cName: String
    @NSManaged var cIconName: String
    @NSManaged var cType: NSNumber
    @NSManaged var entries: NSSet
    
    //MARK: Class methods
    class func getCategory(name:String, iconName:String?, type:NSNumber, context:NSManagedObjectContext) -> CDEntryCategory {
        var category: CDEntryCategory?
        
        var predicate = NSPredicate(format: "cName == %@ && cType == %@", name, type)
        var className = CDEntryCategory.description()
        var fetchRequest = NSFetchRequest(entityName: className)
        fetchRequest.predicate = predicate
        var error: NSError?
        
        category = context.executeFetchRequest(fetchRequest, error: &error)!.first as? CDEntryCategory
        
        if  category == nil {
            let entityDescription: NSEntityDescription = NSEntityDescription.entityForName(className, inManagedObjectContext: context)!
            category = CDEntryCategory(entity: entityDescription, insertIntoManagedObjectContext: context)
            category?.cName = name
            category?.cType = type
            
            if iconName != nil {
                category?.cIconName = iconName!
            } else {
                category?.cIconName = "general_icon"
            }
            
            
            if !context.save(&error) {
                println("Error save CDEntryCategory -> \(error?.description)")
            } else {
                println("category with name: \(name) successfully created")
            }
        }
        
        return category!
    }
    
    class func getAllCategries(entryType:NSNumber, context:NSManagedObjectContext) -> [AnyObject] {
        
        var predicate = NSPredicate(format: "cType == %@", entryType)
        var className = CDEntryCategory.description()
        var fetchRequest = NSFetchRequest(entityName: className)
        
        fetchRequest.predicate = predicate
        var error: NSError?
        
        var categories = context.executeFetchRequest(fetchRequest, error: &error) as [AnyObject]?
        
        return categories!
    }
    
//    //MARK: Override functions
//    override func awakeFromInsert() {
//        self.cName = "General"
//        self.cType = NSNumber(integer: EntryCategory.EntryCategortUndefined.rawValue)
//        
//        println("--> New entryCategory: \n name:\(self.cName) \n type:\(self.cType)")
//    }
}
