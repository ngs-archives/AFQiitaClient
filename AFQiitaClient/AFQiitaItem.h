//
// AFQiitaItem.h
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

@class AFQiitaTag, AFQiitaUser;
@interface AFQiitaItem : NSObject<AFQiitaObject, NSCopying, NSCoding>

@property (nonatomic, assign) BOOL isPrivate;
@property (nonatomic, assign) BOOL isStocked;
@property (nonatomic, assign) NSInteger commentCount;
@property (nonatomic, assign) NSInteger recordId;
@property (nonatomic, assign) NSInteger stockCount;
@property (nonatomic, strong) AFQiitaUser *user;
@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, strong) NSArray *stockUsers;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSDate *updatedAt;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSString *createdAtInWords;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *updatedAtInWords;
@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) NSURL *gistUrl;
@property (nonatomic, strong) NSURL *url;

- (NSDictionary *)parameterDictionaryForUpdate;
- (NSDictionary *)parameterDictionaryForCreate;

@end
