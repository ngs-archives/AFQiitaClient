//
//  IQItemViewController.m
//  AFQiitaClient iOS Example
//
//  Created by Atsushi Nagase on 10/13/12.
//  Copyright (c) 2012 LittleApps Inc. All rights reserved.
//

#import "IQItemViewController.h"
#import "AFQiita.h"

@interface IQItemViewController ()

@end

NSString *const kIQItemHTMLTemplate = @"<html>\
<head>\
<style>\
body {font-size:9pt;color:#333;font-familiy:sans-serif;}\
.c,.cm,.c1,.cs {color:#408080;font-style:italic;}\
.k,.kc,.kd,.kn,.kr,.nt {color:green;font-weight:700;}\
.o,.m,.mf,.mh,.mi,.mo,.il {color:#666;}\
.gh,.gp {color:navy;font-weight:700;}\
.kp,.nb,.sx,.bp {color:green;}\
.s,.sb,.sc,.s2,.sh,.s1 {color:#BA2121;}\
.nc,.nn {color:#00F;font-weight:700;}\
.nv,.ss,.vc,.vg,.vi {color:#19177C;}\
</style>\
<meta name='viewport' content='width=320, initial-scale=1.0, user-scalable=yes, maximum-scale=2.0, minimum-scale=0.2'>\
</head>\
<body>%@</body>\
</html>";

@implementation IQItemViewController
@synthesize item = _item;

- (void)setItem:(AFQiitaItem *)item {
  _item = item;
  [self renderHTML];
}

- (void)viewDidLoad {
  [self renderHTML];
}

- (void)renderHTML {
  NSString *html = @"";
  if(self.item)
    html = [NSString stringWithFormat:kIQItemHTMLTemplate, self.item.body];
  [self.webView
   loadHTMLString:html
   baseURL:[NSURL URLWithString:@"http://qiita.jp/"]];
}


- (IBAction)confirmDeleting:(id)sender {}
- (IBAction)showAction:(id)sender {}
- (IBAction)toggleStocked:(id)sender {}
- (void)deleteItem {}
- (void)updateToolbar {}

@end
