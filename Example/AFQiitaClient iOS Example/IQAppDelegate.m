//
//  IQAppDelegate.m
//  AFQiitaClient iOS Example
//
//  Created by Atsushi Nagase on 10/13/12.
//  Copyright (c) 2012 LittleApps Inc. All rights reserved.
//

#import "IQAppDelegate.h"
#import "SVProgressHUD.h"

@interface IQAppDelegate ()

@property (nonatomic, copy) AFQiitaAuthenticationHandler pendingAuthenticationHandler;

@end

@implementation IQAppDelegate
@synthesize qiitaClient = _qiitaClient;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  return YES;
}

- (AFQiitaClient *)qiitaClient {
  if(nil==_qiitaClient) {
    _qiitaClient = [[AFQiitaClient alloc] init];
  }
  return _qiitaClient;
}

- (void)authenticateWithCompletionHandler:(AFQiitaAuthenticationHandler)completionHandler {
  self.pendingAuthenticationHandler = completionHandler;
  UIAlertView *av = [[UIAlertView alloc]
                     initWithTitle:@"Login required"
                     message:@"Input username and password"
                     delegate:self
                     cancelButtonTitle:@"Cancel" otherButtonTitles:@"Submit", nil];
  [av setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
  [av show];
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
  if(buttonIndex == 0) {
    self.pendingAuthenticationHandler = nil;
    return;
  }
  UITextField *usernameField = [alertView textFieldAtIndex:0];
  UITextField *passwordField = [alertView textFieldAtIndex:1];
  NSString *username = usernameField.text;
  NSString *password = passwordField.text;
  if(!username || !password) return;
  [SVProgressHUD showWithStatus:@"Logging in" maskType:SVProgressHUDMaskTypeGradient];
  [self.qiitaClient
   authenticateWithUsername:username
   password:password
   success:^{
     [SVProgressHUD showSuccessWithStatus:@"Logged in!"];
     if(self.pendingAuthenticationHandler)
       self.pendingAuthenticationHandler();
     self.pendingAuthenticationHandler = nil;
   }
   failure:^(NSError *error) {
     [SVProgressHUD showErrorWithStatus:error.localizedDescription];
   }];
  
}

+ (IQAppDelegate *)current {
  return (IQAppDelegate *)[[UIApplication sharedApplication] delegate];
}

@end


@implementation AFQiitaClient (sharedClient)

+ (AFQiitaClient *)sharedClient {
  return [IQAppDelegate current].qiitaClient;
}

@end