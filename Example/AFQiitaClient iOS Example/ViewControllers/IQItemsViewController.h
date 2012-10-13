//
//  IQItemsViewController.h
//  AFQiitaClient iOS Example
//
//  Created by Atsushi Nagase on 10/13/12.
//  Copyright (c) 2012 LittleApps Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AFQiitaItem, AFQiitaUser;
@interface IQItemsViewController : UITableViewController


@property (nonatomic,strong) NSURL *nextURL;
@property (nonatomic) NSInteger page;
@property (nonatomic) BOOL isLoading;
@property (nonatomic,strong) IBOutlet UIBarButtonItem *aboutButtonItem;
@property (nonatomic,strong) IBOutlet UIBarButtonItem *composeButtonItem;
@property (nonatomic,strong) IBOutlet UIBarButtonItem *reloadButtonItem;
@property (nonatomic,strong) IBOutlet UISegmentedControl *segmentControl;
@property (nonatomic,strong) AFQiitaUser *user;
@property (nonatomic,strong) NSMutableArray *items;
@property (nonatomic,strong) UIBarButtonItem *activityItem;
@property (nonatomic,strong) UIRefreshControl *refreshControl;

- (IBAction)handleSegmentChange:(id)sender;
- (IBAction)reload:(id)sender;
- (IBAction)openComposeModal:(id)sender;
- (void)load:(BOOL)more;
- (void)prependItem:(AFQiitaItem *)item;
- (void)removeItem:(AFQiitaItem *)item;
- (void)replaceItem:(AFQiitaItem *)item;
- (void)updateToolbar;
- (void)loginCanceled:(NSNotification *)n;


@end
