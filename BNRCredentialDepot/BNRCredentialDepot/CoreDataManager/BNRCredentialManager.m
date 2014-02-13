//
//  BNRCredentialManager.m
//  BNRCredentialDepot
//
//  Created by Bharath Nagaraj Rao on 12/02/14.
//  Copyright (c) 2014 Bharath Nagaraj Rao. All rights reserved.
//

#import "BNRCredentialManager.h"
#import "BNRConstants.h"
#import "UserCredentials.h"

@implementation BNRCredentialManager
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;


- (id)init
{
    self = [super init];
    if (self) {
        
        //Initialise
    }
    return self;
}



-(NSMutableDictionary *)getUserCredentialsFromDB
{
    NSMutableDictionary *userCredentialDict = nil;
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error;
    
    // Fetch all the available username/password stored in the database
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserCredentials"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if ([fetchedObjects count]) {
        
        UserCredentials *userCredentials = [fetchedObjects objectAtIndex:0];
        userCredentialDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                        userCredentials.username,USERNAME,
                                        userCredentials.password,PASSWORD, nil];
        
        NSLog(LIBRARY_LOGS_BEGIN);
        NSLog(@"Retried From Database : Username - %@ , Password - %@",userCredentials.username,userCredentials.password);
        NSLog(LIBRARY_LOGS_END);
    }
    return userCredentialDict;
}

-(BOOL)storeUserCredentialsFromDB:(NSMutableDictionary *)userCredentialsDict
{
    BOOL isSuccess = NO;
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error;
    // Fetch all the available username/password stored in the database
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserCredentials"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if ([fetchedObjects count]) {
        
        UserCredentials *userCredentials = [fetchedObjects objectAtIndex:0];
        @try
        {
            //Store Username & Password in the DB
            userCredentials.username = [userCredentialsDict objectForKey:USERNAME];
            userCredentials.password = [userCredentialsDict objectForKey:PASSWORD];
            NSLog(LIBRARY_LOGS_BEGIN);
            if (![context save:&error]) {
                NSLog(@"Error in saving User Credentials: %@", [error localizedDescription]);
            }else{
                
                //If the credentials are already preset, update the record
                isSuccess =YES;
                NSLog(@"Update User Credentials in DB : Username - %@ ,  Password - %@",userCredentials.username,userCredentials.password);
            }
            NSLog(LIBRARY_LOGS_END);
            
        }@catch (NSException *exception) {
            
            //Log exception
            NSLog(LIBRARY_LOGS_BEGIN);
            NSLog(@"Exception - %@",exception.description);
            NSLog(LIBRARY_LOGS_END);
        }
   
    }else{
        
        UserCredentials *userCredentials = [NSEntityDescription insertNewObjectForEntityForName:@"UserCredentials" inManagedObjectContext:context];
        @try
        {
            //Store Username & Password in the DB
            userCredentials.username = [userCredentialsDict objectForKey:USERNAME];
            userCredentials.password = [userCredentialsDict objectForKey:PASSWORD];
            NSLog(LIBRARY_LOGS_BEGIN);
            if (![context save:&error]) {
                NSLog(@"Error in saving User Credentials: %@", [error localizedDescription]);
            }else{
                
                //If the credentials are not preset, insert the record
                isSuccess =YES;
                NSLog(@"Insert User Credentials in DB : Username - %@ ,  Password - %@",userCredentials.username,userCredentials.password);
            }
            NSLog(LIBRARY_LOGS_END);
            
        }@catch (NSException *exception) {
            
            //Log exception
            NSLog(LIBRARY_LOGS_BEGIN);
            NSLog(@"Exception - %@",exception.description);
            NSLog(LIBRARY_LOGS_END);
        }
        
    }
 
    return isSuccess;
}

#pragma mark - Core Data Methods

-(NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil) {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}


-(NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil) {
        return __managedObjectModel;
    }
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"CredentialsDepot"
                                                 ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    NSString *modelPath = [bundle pathForResource:@"Credentials"
                                 ofType:@"momd"];
    NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}


-(NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil) {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"UserCredentials.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {

        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return __persistentStoreCoordinator;
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}



@end
