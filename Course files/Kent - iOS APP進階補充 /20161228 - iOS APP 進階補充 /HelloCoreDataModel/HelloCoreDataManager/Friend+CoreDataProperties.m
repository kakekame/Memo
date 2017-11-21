//
//  Friend+CoreDataProperties.m
//  HelloCoreDataManager
//
//  Created by Kent Liu on 2016/10/5.
//  Copyright © 2016年 Kent Liu. All rights reserved.
//

#import "Friend+CoreDataProperties.h"

@implementation Friend (CoreDataProperties)

+ (NSFetchRequest<Friend *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Friend"];
}

@dynamic creationDate;
@dynamic name;
@dynamic telephone;

@end
