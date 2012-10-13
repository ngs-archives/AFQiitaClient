//
// AFQiitaRequestOperation.m
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

#import "AFQiitaRequestOperation.h"
#import "AFQiitaResponse.h"
#import "AFQiitaItem.h"
#import "AFQiitaUser.h"
#import "AFQiitaTag.h"
#import "AFQiitaComment.h"

NSString * const AFQiitaErrorDomain = @"AFQiitaErrorDomain";

@interface AFQiitaRequestOperation ()

@property (nonatomic, strong) NSError *apiError;

@end

@implementation AFQiitaRequestOperation
@synthesize qiitaResponse = _qiitaResponse;

- (id)responseJSON {
  id json = [super responseJSON];
  if([json isKindOfClass:[NSDictionary class]]) {
    if([json containsValueForKey:@"error"]) {
      NSDictionary *userInfo = nil;
      if([json[@"error"] isKindOfClass:[NSString class]])
        userInfo = [NSDictionary dictionaryWithObject:json[@"error"] forKey:NSLocalizedDescriptionKey];
      self.apiError = [NSError errorWithDomain:AFQiitaErrorDomain
                                          code:NSURLErrorBadServerResponse
                                      userInfo:userInfo];
    } else {
      
    }
  }
  return json;
}

- (AFQiitaResponse *)qiitaResponse {
  return _qiitaResponse;
}

- (Class)itemClass {
  NSString *method = [self.request.HTTPMethod uppercaseString];
  NSMutableArray *comps = [[self.request.URL pathComponents] mutableCopy];
  [comps removeObjectAtIndex:0];
  [comps removeObjectAtIndex:0];
  NSInteger len = [comps count];
  NSString *comp0 = len > 0 ? [comps objectAtIndex:0] : nil;
  // NSString *comp1 = len > 1 ? [comps objectAtIndex:1] : nil;
  NSString *comp2 = len > 2 ? [comps objectAtIndex:2] : nil;
  if(
     [method isEqualToString:@"DELETE"] ||
     [comp0 isEqualToString:@"auth"] ||
     [comp0 isEqualToString:@"rate_limit"] ||
     ([method isEqualToString:@"PUT"] && [comp2 isEqualToString:@"stock"]))
    return nil;
  if(len == 1 && [comp0 isEqualToString:@"tags"])
    return [AFQiitaTag class];
  if([comp0 isEqualToString:@"users"] && (len == 1 || len == 2))
    return [AFQiitaUser class];
  return [AFQiitaItem class];
}

@end
