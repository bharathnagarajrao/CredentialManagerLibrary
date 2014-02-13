//
//  BNRCredentialManager.h
//  BNRCredentialDepot
//
//  Created by Bharath Nagaraj Rao on 12/02/14.
//  Copyright (c) 2014 Bharath Nagaraj Rao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface BNRCredentialManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

-(NSPersistentStoreCoordinator *)persistentStoreCoordinator;
-(NSManagedObjectModel *)managedObjectModel;
-(NSManagedObjectContext *)managedObjectContext;

-(NSMutableDictionary *)getUserCredentialsFromDB;
-(BOOL)storeUserCredentialsFromDB:(NSMutableDictionary *)userCredentialsDict;

@end
