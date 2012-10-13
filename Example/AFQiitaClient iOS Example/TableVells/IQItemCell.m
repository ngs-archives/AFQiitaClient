//
//  IQItemCell.m
//  AFQiitaClient iOS Example
//
//  Created by Atsushi Nagase on 10/13/12.
//  Copyright (c) 2012 LittleApps Inc. All rights reserved.
//

#import "IQItemCell.h"
#import "UIImageView+AFNetworking.h"
#import "AFQiita.h"

@implementation IQItemCell
@synthesize item = _item;

- (void)setItem:(AFQiitaItem *)item {
  if(![item  isEqual:_item]) {
    self.timestampLabel.text = item.updatedAtInWords;
    self.userLabel.text = [NSLocalizedString(@"Posted by ", nil) stringByAppendingString:item.user.name];
    self.titleLabel.text = item.title;
    [self.profileImageView setImageWithURL:item.user.profileImageURL];
    _item = item;
  }
}

@end
