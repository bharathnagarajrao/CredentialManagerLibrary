//
//  BNRCredentialDepot.m
//  BNRCredentialDepot
//
//  Created by Bharath Nagaraj Rao on 12/02/14.
//  Copyright (c) 2014 Bharath Nagaraj Rao. All rights reserved.
//

#import "BNRCredentialDepot.h"
#import "BNRCredentialManager.h"

@implementation BNRCredentialDepot


+(NSMutableDictionary *)getUserCredentials
{
    BNRCredentialManager *credentialManager = [[BNRCredentialManager alloc] init];
    return [credentialManager getUserCredentialsFromDB];
}

+(BOOL)storeUserCredentials:(NSMutableDictionary *)userCredentialsDict
{
    BNRCredentialManager *credentialManager = [[BNRCredentialManager alloc] init];
    return [credentialManager storeUserCredentialsFromDB:userCredentialsDict];
}


@end
