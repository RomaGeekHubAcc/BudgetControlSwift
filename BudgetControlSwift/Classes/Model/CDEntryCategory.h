//
//  CDEntryCategory.h
//  BudgetControlSwift
//
//  Created by Roman Rybachenko on 12/31/14.
//  Copyright (c) 2014 Roman Rybachenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CDEntryCategory : NSManagedObject

@property (nonatomic, retain) NSString * cName;
@property (nonatomic, retain) NSNumber * cType;
@property (nonatomic, retain) NSSet *entries;
@end

@interface CDEntryCategory (CoreDataGeneratedAccessors)

- (void)addEntriesObject:(NSManagedObject *)value;
- (void)removeEntriesObject:(NSManagedObject *)value;
- (void)addEntries:(NSSet *)values;
- (void)removeEntries:(NSSet *)values;

@end
