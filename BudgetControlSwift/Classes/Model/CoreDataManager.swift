//
//  CoreDataManager.swift
//  BudgetControlSwift
//
//  Created by Roman Rybachenko on 12/31/14.
//  Copyright (c) 2014 Roman Rybachenko. All rights reserved.
//

import Foundation

class CoreDataManager {
    class var sharedInstance: CoreDataManager {
        struct Static {
            static var instance: CoreDataManager?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = CoreDataManager()
        }
        return Static.instance!
    }
}