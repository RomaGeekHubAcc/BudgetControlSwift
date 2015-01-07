//
//  DateFormatterManager.swift
//  BudgetControlSwift
//
//  Created by Roman Rybachenko on 1/5/15.
//  Copyright (c) 2015 Roman Rybachenko. All rights reserved.
//


import UIKit

class DateFormatterManager: NSDateFormatter {
    
    class var sharedInstance: DateFormatterManager {
        struct Static {
            static var instance: DateFormatterManager?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = DateFormatterManager()
            Static.instance?.locale = NSLocale.currentLocale()
        }
        
        
        return Static.instance!
    }
    
    func monthDateFromDate(date:NSDate) -> NSDate? {
        var gregorianCal = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        var dateComponent = gregorianCal?.components(.CalendarUnitYear | .CalendarUnitMonth, fromDate: date)
        var todayMonth = dateComponent?.month
        var todayYear = dateComponent?.year
        
        var anotherComponents = NSDateComponents()
        anotherComponents.year = todayYear!
        anotherComponents.month = todayMonth!

        var monthDate = gregorianCal?.dateFromComponents(anotherComponents)
        
        return monthDate
    }
}
