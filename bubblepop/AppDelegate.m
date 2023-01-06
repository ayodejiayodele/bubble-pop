//
//  AppDelegate.m
//  bubblepop
//
//  Created by Ayodeji Ayodele on 27/04/2017.
//  Copyright © 2017 Ayodeji Ayodele. All rights reserved.
//

#import "AppDelegate.h"
#import "Player+CoreDataProperties.h"

@interface AppDelegate ()

- (void) loadPlayerData;

@end

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self loadPlayerData];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "au.edu.uts.demo_coredata" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"playerdb" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"demo_coredata.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"FAILED_DATA_MANAGEMENT" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSLog( @"Save context" );
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void) loadPlayerData
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName: @"Player"
                                              inManagedObjectContext: self.managedObjectContext];
    [request setEntity:entity];
    
    NSError *error = nil;
    NSArray * loadedPlayer = [self.managedObjectContext executeFetchRequest:request error:&error];
    NSSortDescriptor * sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"score" ascending:NO];
    sortDescriptors_ = [NSArray arrayWithObject:sortDescriptor];
    knownPlayers_ = [[loadedPlayer sortedArrayUsingDescriptors:sortDescriptors_] mutableCopy];
}

- (NSMutableArray *) playerList
{
    return knownPlayers_;
}

- (NSMutableArray *) addNewPlayer: (NSString *) name withScore: (NSNumber *) score andLevel: (NSNumber *) difficulty
{
    Player * newPlayer = (Player *)[NSEntityDescription insertNewObjectForEntityForName: @"Player"
                                                                 inManagedObjectContext: self.managedObjectContext];
    newPlayer.name = name;
    newPlayer.score = score;
    newPlayer.difficultyLevel = difficulty;
    newPlayer.dateOfCompletion = [NSDate date];
    [knownPlayers_ addObject: newPlayer];
    knownPlayers_ = [[knownPlayers_ sortedArrayUsingDescriptors:sortDescriptors_] mutableCopy];
    [self saveContext];
    return knownPlayers_;
}

- (NSNumber*) getHighestScore{
    if(!knownPlayers_ || knownPlayers_.count < 1)
        return [NSNumber numberWithInteger:0];
    else
        return [knownPlayers_[0] score];
}

- (void) deletePlayerAtIndex: (NSUInteger) index
{
    if (!knownPlayers_)
        return;
    
    if (index >= [knownPlayers_ count])
        return;
    
    [self.managedObjectContext deleteObject: knownPlayers_[index]];
    [knownPlayers_ removeObjectAtIndex: index];
    [self saveContext];
}


@end
