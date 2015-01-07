//
//  AppDelegate.swift
//  BudgetControlSwift
//
//  Created by Roman Rybachenko on 12/30/14.
//  Copyright (c) 2014 Roman Rybachenko. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.createEntryCategories()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        CoreDataManager.sharedInstance.saveContext()
    }

    
    func createEntryCategories() {
        let context = CoreDataManager.sharedInstance.managedObjectContext
        let incomeType: NSNumber = NSNumber(integer: EntryType.EntryTypeIncome.rawValue)
        let expenseType: NSNumber = NSNumber(integer: EntryType.EntryTypeExpense.rawValue)
        
        // Income
        CDEntryCategory.getCategory("Wages", iconName: "wages_icon", type: incomeType, context: context!)
        CDEntryCategory.getCategory("Renting", iconName:"renting_icon", type: incomeType, context: context!)
        CDEntryCategory.getCategory("Gifts", iconName:"gifts_icon", type: incomeType, context: context!)
        
        // Expense
        CDEntryCategory.getCategory("General", iconName:"general_icon", type: expenseType, context: context!)
        CDEntryCategory.getCategory("Clothes", iconName:"clothes_icon", type: expenseType, context: context!)
        CDEntryCategory.getCategory("Food", iconName:"food_icon", type: expenseType, context: context!)
        CDEntryCategory.getCategory("Kids Staff", iconName:"kidsStuff_icon", type: expenseType, context: context!)
        CDEntryCategory.getCategory("Rent", iconName:"rent_icon", type: expenseType, context: context!)
        CDEntryCategory.getCategory("House", iconName:"house_icon", type: expenseType, context: context!)
        CDEntryCategory.getCategory("Insurances", iconName:"insurances_icon", type: expenseType, context: context!)
        CDEntryCategory.getCategory("Health", iconName:"health_icon", type: expenseType, context: context!)
        CDEntryCategory.getCategory("Travel", iconName:"travel_icon", type: expenseType, context: context!)
        CDEntryCategory.getCategory("Leisure", iconName:"leisure_icon", type: expenseType, context: context!)
        CDEntryCategory.getCategory("Pets", iconName:"pets_icon", type: expenseType, context: context!)
        CDEntryCategory.getCategory("Books", iconName:"books_icon", type: expenseType, context: context!)
        CDEntryCategory.getCategory("Trips", iconName:"trips_icon", type: expenseType, context: context!)
        CDEntryCategory.getCategory("Gifts", iconName:"gifts_icon", type: expenseType, context: context!)
        CDEntryCategory.getCategory("Energy/Water", iconName:"energyWater_icon", type: expenseType, context: context!)
        CDEntryCategory.getCategory("Fuel", iconName:"fuel_icon", type: expenseType, context: context!)
        CDEntryCategory.getCategory("Car", iconName:"car_icon", type: expenseType, context: context!)
        CDEntryCategory.getCategory("Education", iconName:"education_icon", type: expenseType, context: context!)
        CDEntryCategory.getCategory("Sport", iconName:"sport_icon", type: expenseType, context: context!)
        CDEntryCategory.getCategory("Music", iconName:"music_icon", type: expenseType, context: context!)
        CDEntryCategory.getCategory("Friends", iconName:"friends_icon", type: expenseType, context: context!)
    }

}

