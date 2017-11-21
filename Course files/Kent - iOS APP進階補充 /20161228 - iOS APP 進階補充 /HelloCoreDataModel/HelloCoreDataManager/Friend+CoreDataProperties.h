//
//  Friend+CoreDataProperties.h
//  HelloCoreDataManager
//
//  Created by Kent Liu on 2016/10/5.
//  Copyright © 2016年 Kent Liu. All rights reserved.
//

#import "Friend+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Friend (CoreDataProperties)

+ (NSFetchRequest<Friend *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *creationDate;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *telephone;

@end

NS_ASSUME_NONNULL_END
