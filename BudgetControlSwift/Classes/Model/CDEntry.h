//
//  CDEntry.h
//  BudgetControlSwift
//
//  Created by Roman Rybachenko on 12/31/14.
//  Copyright (c) 2014 Roman Rybachenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CDBudgetMonth, CDEntryCategory;

@interface CDEntry : NSManagedObject

@property (nonatomic, retain) NSString * eCheckAddress;
@property (nonatomic, retain) NSDate * eDate;
@property (nonatomic, retain) NSString * eDescription;
@property (nonatomic, retain) NSDecimalNumber * ePrice;
@property (nonatomic, retain) NSNumber * eType;
@property (nonatomic, retain) CDBudgetMonth *budget;
@property (nonatomic, retain) CDEntryCategory *category;

@end
