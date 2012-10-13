//
//  IQItemsViewController.m
//  AFQiitaClient iOS Example
//
//  Created by Atsushi Nagase on 10/13/12.
//  Copyright (c) 2012 LittleApps Inc. All rights reserved.
//

#import "IQItemsViewController.h"
#import "IQItemViewController.h"
#import "AFQiita.h"
#import "IQAppDelegate.h"
#import "SVProgressHUD.h"
#import "IQMoreCell.h"
#import "IQItemCell.h"

@interface IQItemsViewController ()

@end

@implementation IQItemsViewController

#pragma mark -

- (IBAction)handleSegmentChange:(id)sender {
  [self load:NO];
}

- (IBAction)reload:(id)sender {
  [self load:NO];
}

- (IBAction)openComposeModal:(id)sender {
  // TODO
}

- (void)load:(BOOL)more {
  if(self.isLoading) return;
  NSInteger idx = self.segmentControl.selectedSegmentIndex;
  AFQiitaClient *client = [AFQiitaClient sharedClient];
  if(!client.isLoggedIn && idx > 0) {
    [[IQAppDelegate current] authenticateWithCompletionHandler:^{
      [self load:NO];
    }];
    return;
  }
  self.isLoading = YES;
  BOOL initial = !self.items || self.items.count == 0;
  if(!more) {
    self.items = @[].mutableCopy;
    [self.refreshControl beginRefreshing];
  }
  if(more && self.nextURL) {
    [client getURL:self.nextURL
           success:^(AFQiitaResponse *response) {
             [self handleAPIResponse:response];
           } failure:^(NSError *error) {
             [self handleAPIError:error];
           }];
  } else {
    switch (idx) {
      case 0:{
        [client
         recentItemsWithSuccess:^(AFQiitaResponse *response) {
           [self handleAPIResponse:response];
         }
         failure:^(NSError *error) {
           [self handleAPIError:error];
         }];
      }
        break;
      case 1: {
        [client
         stockedItemsWithSuccess:^(AFQiitaResponse *response) {
           [self handleAPIResponse:response];
         }
         failure:^(NSError *error) {
           [self handleAPIError:error];
         }];
      }
        break;
      case 2: {
        [client
         myItemsWithSuccess:^(AFQiitaResponse *response) {
           [self handleAPIResponse:response];
         }
         failure:^(NSError *error) {
           [self handleAPIError:error];
         }];
      }
        break;
    }
  }
  if(initial)
    [self.tableView reloadData];
  [self updateToolbar];
}

#pragma mark - Handling requests

- (void)handleAPIError:(NSError *)error {
  [SVProgressHUD showErrorWithStatus:error.localizedDescription];
  self.isLoading = NO;
  int64_t delayInSeconds = 0.5;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    [self.refreshControl endRefreshing];
  });
  [self.tableView reloadData];
  [self updateToolbar];
}

- (void)handleAPIResponse:(AFQiitaResponse *)response {
  self.nextURL = response.nextURL;
  self.isLoading = NO;
  AFQiitaItem *item = nil;
  while ((item = response.next))
    [self.items addObject:item];
  [self.tableView reloadData];
  int64_t delayInSeconds = 0.5;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    [self.refreshControl endRefreshing];
  });
  [self updateToolbar];
}

#pragma mark - Item management

- (void)removeItem:(AFQiitaItem *)item {
  if([self.items containsObject:item]) {
    NSUInteger index = [self.items indexOfObject:item];
    [self.items removeObject:item];
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:index inSection:0]]
                          withRowAnimation:UITableViewRowAnimationLeft];
    [self.tableView endUpdates];
  }
}

- (void)prependItem:(AFQiitaItem *)item {
  if([self.items containsObject:item])
    [self.items removeObject:item];
  [self.items insertObject:item atIndex:0];
  [self.tableView beginUpdates];
  [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]]
                        withRowAnimation:UITableViewRowAnimationRight];
  [self.tableView endUpdates];
}

- (void)replaceItem:(AFQiitaItem *)item {
  if([self.items containsObject:item]) {
    NSUInteger index = [self.items indexOfObject:item];
    [self.items replaceObjectAtIndex:index withObject:item];
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:index inSection:0]]
                          withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
  }
}

- (void)updateToolbar {
  NSInteger idx = self.segmentControl.selectedSegmentIndex;
  [self.navigationItem
   setRightBarButtonItem:idx==0?nil:self.editButtonItem
   animated:YES];
  self.segmentControl.enabled = !self.isLoading;
  self.editButtonItem.enabled = !self.isLoading;
  NSMutableArray *ar = [self.toolbarItems mutableCopy];
  if(self.isLoading) {
    [ar replaceObjectAtIndex:0 withObject:self.activityItem];
  } else {
    [ar replaceObjectAtIndex:0 withObject:self.reloadButtonItem];
  }
  if(self.composeButtonItem) {
    if(![AFQiitaClient sharedClient].accessToken)
      [ar removeObject:self.composeButtonItem];
    else if(![ar containsObject:self.composeButtonItem])
      [ar addObject:self.composeButtonItem];
  }
  [self setToolbarItems:ar animated:YES];
}

- (void)loginCanceled:(NSNotification *)n {
  
}

#pragma mark - UIViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  if(!self.refreshControl) {
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(reload:)
                  forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
  }
  if(!self.activityItem) {
    UIActivityIndicatorView *iv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.activityItem = [[UIBarButtonItem alloc] initWithCustomView:iv];
    [iv startAnimating];
  }
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  if(!self.items)
    [self load:NO];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if([sender isKindOfClass:[IQItemCell class]] &&
     [segue.destinationViewController isKindOfClass:[IQItemViewController class]]) {
    [(IQItemViewController *)segue.destinationViewController setItem:((IQItemCell *)sender).item];
  }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  NSInteger n = self.items.count;
  if(self.nextURL) n++;
  return n;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSString *identifier = nil;
  Class cellClass = nil;
  if(indexPath.row == self.items.count) {
    identifier = @"IQMoreCell";
    cellClass = [IQMoreCell class];
  } else {
    identifier = @"IQItemCell";
    cellClass = [IQItemCell class];
  }
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
  if([cell isKindOfClass:[IQMoreCell class]]) {
    [[(IQMoreCell *)cell activityIndicatorView] startAnimating];
  } else {
    AFQiitaItem *item = [self.items objectAtIndex:indexPath.row];
    [(IQItemCell *)cell setItem:item];
  }
  return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if(!self.isLoading&&self.nextURL) {
    CGFloat y = scrollView.contentOffset.y + scrollView.frame.size.height + scrollView.frame.origin.y;
    CGFloat h = scrollView.contentSize.height - 60;
    if(y>=h) [self load:YES];
  }
}

@end
