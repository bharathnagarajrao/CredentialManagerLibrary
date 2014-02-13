//
//  UserCredentials.h
//  BNRCredentialDepot
//
//  Created by Bharath Nagaraj Rao on 12/02/14.
//  Copyright (c) 2014 Bharath Nagaraj Rao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserCredentials : NSManagedObject

@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * password;

@end
