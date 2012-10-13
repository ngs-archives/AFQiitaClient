//
//  IQItemViewController.h
//  AFQiitaClient iOS Example
//
//  Created by Atsushi Nagase on 10/13/12.
//  Copyright (c) 2012 LittleApps Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AFQiitaItem;

@interface IQItemViewController : UIViewController


@property (nonatomic) BOOL isLoading;
@property (nonatomic) BOOL isDeleted;
@property (nonatomic,readonly) NSString *htmlTemplate;
@property (nonatomic,strong) IBOutlet UIBarButtonItem *actionButtonItem;
@property (nonatomic,strong) IBOutlet UIBarButtonItem *stockButtonItem;
@property (nonatomic,strong) IBOutlet UIBarButtonItem *trashButtonItem;
@property (nonatomic,strong) IBOutlet UIBarButtonItem *unstockButtonItem;
@property (nonatomic,strong) IBOutlet UIBarButtonItem *userButtonItem;
@property (nonatomic,strong) IBOutlet UIWebView *webView;
@property (nonatomic,strong) AFQiitaItem *item;
@property (nonatomic,strong) UIActivityIndicatorView *webActivityIndicatorView;
@property (nonatomic,strong) UIBarButtonItem *stockActivityItem;

- (IBAction)confirmDeleting:(id)sender;
- (IBAction)showAction:(id)sender;
- (IBAction)toggleStocked:(id)sender;
- (void)deleteItem;
- (void)updateToolbar;

@end
