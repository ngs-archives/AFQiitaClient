//
//  IQItemCell.h
//  AFQiitaClient iOS Example
//
//  Created by Atsushi Nagase on 10/13/12.
//  Copyright (c) 2012 LittleApps Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AFQiitaItem;
@interface IQItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;

@property (nonatomic, copy) AFQiitaItem *item;

@end
