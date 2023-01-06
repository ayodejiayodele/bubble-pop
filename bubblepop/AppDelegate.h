//
//  AppDelegate.h
//  bubblepop
//
//  Created by Ayodeji Ayodele on 27/04/2017.
//  Copyright © 2017 Ayodeji Ayodele. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
@private
    NSMutableArray * knownPlayers_;
    NSArray * sortDescriptors_;
}

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void) saveContext;
- (NSURL *) applicationDocumentsDirectory;
- (NSMutableArray *) playerList;
- (NSMutableArray *) addNewPlayer: (NSString *) name withScore: (NSNumber *) score andLevel: (NSNumber *) difficulty;
- (NSNumber*) getHighestScore;
- (void) deletePlayerAtIndex: (NSUInteger) index;


@end

