//
//  ViewController.h
//  CredentialManager
//
//  Created by Bharath Nagaraj Rao on 11/02/14.
//  Copyright (c) 2014 Bharath Nagaraj Rao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *registrationView;
@property (weak, nonatomic) IBOutlet UIView *loginView;


@property (weak, nonatomic) IBOutlet UITextField *usernameTextFieldForLogin;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextFieldForLogin;

@property (weak, nonatomic) IBOutlet UITextField *usernameTextFieldForRegistration;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextFieldForRegistration;

@property (assign, nonatomic) BOOL isFirstTimeLaunch;

- (IBAction)registerUser:(id)sender;
- (IBAction)cancelRegistration:(id)sender;
- (IBAction)loginUser:(id)sender;

-(BOOL)isRegistrationSuccess;
-(BOOL)isLoginSuccess;

@end
