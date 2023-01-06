//
//  Player+CoreDataProperties.h
//  demo_coredata
//
//  Created by Xun Wang on 30/04/2016.
//  Copyright © 2016 UTS. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Player.h"

NS_ASSUME_NONNULL_BEGIN

@interface Player (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *difficultyLevel;
@property (nullable, nonatomic, retain) NSNumber *score;
@property (nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSDate *dateOfCompletion;

@end

@interface Player (CoreDataGeneratedAccessors)


@end

NS_ASSUME_NONNULL_END
