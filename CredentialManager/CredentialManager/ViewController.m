//
//  ViewController.m
//  CredentialManager
//
//  Created by Bharath Nagaraj Rao on 11/02/14.
//  Copyright (c) 2014 Bharath Nagaraj Rao. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "UserCredentials.h"
#import "BNRCredentialDepot.h"



#define REGISTRATION_SUCCESS    @"User registered successfully"
#define REGISTRATION_FAILURE    @"Oops! Registration Failed!"
#define LOGIN_SUCCESS           @"User logged in successfully"
#define LOGIN_FAILURE           @"Oops! Username & Password don not match!"
#define EMPTY_FORM_FIELD        @"Username and Password cannot be blank"
#define USERNAME                @"username"
#define PASSWORD                @"password"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *launchFlag = [userDefaults objectForKey:@"LaunchFlag"];
    self.isFirstTimeLaunch = (launchFlag.length) >0 ? NO:YES;
    
    [self showLaunchScreen];
    
}

-(void)showLaunchScreen
{
    if (self.isFirstTimeLaunch) {

        self.registrationView.hidden = NO;
        self.loginView.hidden = YES;
        
    }else{
        
        self.registrationView.hidden = YES;
        self.loginView.hidden = NO;
    }
}

#pragma mark - Registration/Login methods

- (IBAction)registerUser:(id)sender
{
    if (self.usernameTextFieldForRegistration.text.length && self.passwordTextFieldForRegistration.text.length) {
        
        BOOL isSuccess = [self isRegistrationSuccess];
        if (isSuccess) {
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:@"1" forKey:@"LaunchFlag"];
            [userDefaults synchronize];
            
            [self showAlertWithMessage:REGISTRATION_SUCCESS];
            
            self.isFirstTimeLaunch = NO;
            [self showLaunchScreen];
            
           
        }
        else{
            
            [self showAlertWithMessage:REGISTRATION_FAILURE];
    
        }
    }
    else{
        
        [self showAlertWithMessage:EMPTY_FORM_FIELD];
    }
}


-(void)showAlertWithMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (IBAction)cancelRegistration:(id)sender
{
    //Clear the text fields when user taps on Cancel
    self.usernameTextFieldForRegistration.text = @"";
    self.passwordTextFieldForRegistration.text = @"";
    self.usernameTextFieldForLogin.text = @"";
    self.passwordTextFieldForLogin.text = @"";
}

- (IBAction)loginUser:(id)sender
{
    if (self.usernameTextFieldForLogin.text.length && self.passwordTextFieldForLogin.text.length) {
        
        BOOL isSuccess = [self isLoginSuccess];
        if (isSuccess) {
            
            [self showAlertWithMessage:LOGIN_SUCCESS];
        }
        else{
            
             [self showAlertWithMessage:LOGIN_FAILURE];
        }
    }
    else{
        
        [self showAlertWithMessage:EMPTY_FORM_FIELD];
    }

}


-(BOOL)isRegistrationSuccess
{
    
    NSMutableDictionary *userDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.usernameTextFieldForRegistration.text,USERNAME,self.passwordTextFieldForRegistration.text,PASSWORD, nil];
    BOOL isSuccess=  [BNRCredentialDepot storeUserCredentials:userDict];
    
    return isSuccess;
}


-(BOOL)isLoginSuccess
{
    BOOL isSuccess = NO;
    NSMutableDictionary *userDict = [BNRCredentialDepot getUserCredentials];
    if ([[userDict objectForKey:USERNAME] isEqualToString:self.usernameTextFieldForLogin.text] && [[userDict objectForKey:PASSWORD] isEqualToString:self.passwordTextFieldForLogin.text]) {
        isSuccess = YES;
        return isSuccess;
    }
    
    return isSuccess;
}

#pragma mark - Core Data methods


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
