//
//  BNRCredentialDepot.h
//  BNRCredentialDepot
//
//  Created by Bharath Nagaraj Rao on 12/02/14.
//  Copyright (c) 2014 Bharath Nagaraj Rao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRCredentialDepot : NSObject


/*
 Call this method to get the user credentials, ie, username & password
 Arguments   - None
 Return Type - NSMutableDictionary containing username & password as keyvalue pairs
 */
+(NSMutableDictionary *)getUserCredentials;


/*
 Call this method to store the user credentials, ie, username & password
 Arguments   - NSMutableDictionary containing username & password as keyvalue pairs
 Return Type - BOOL value YES indicating credentials saved & NO otherwise
 */

+(BOOL)storeUserCredentials:(NSMutableDictionary *)userCredentialsDict;



@end
