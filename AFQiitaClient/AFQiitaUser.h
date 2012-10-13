//
// AFQiitaUser.h
//
// Copyright (c) 2012 LittleApps Inc. (http://littleapps.co.jp/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>
#import "AFQiitaObject.h"

@interface AFQiitaUser : NSObject<AFQiitaObject, NSCopying, NSCoding>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *urlName;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *organization;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *facebook;
@property (nonatomic, strong) NSString *twitter;
@property (nonatomic, strong) NSString *linkedin;
@property (nonatomic, strong) NSURL *profileImageURL;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSURL *websiteUrl;
@property (nonatomic, assign) NSInteger followers;
@property (nonatomic, assign) NSInteger followingUsers;
@property (nonatomic, assign) NSInteger items;

@end
