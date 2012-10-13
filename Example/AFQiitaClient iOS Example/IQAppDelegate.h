//
//  IQAppDelegate.h
//  AFQiitaClient iOS Example
//
//  Created by Atsushi Nagase on 10/13/12.
//  Copyright (c) 2012 LittleApps Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFQiita.h"

@interface IQAppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, readonly) AFQiitaClient *qiitaClient;

+ (IQAppDelegate *)current;

- (void)authenticateWithCompletionHandler:(AFQiitaAuthenticationHandler)completionHandler;

@end


@interface AFQiitaClient (sharedClient)

+ (AFQiitaClient *)sharedClient;

@end