//
// AFQiitaResponse.m
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

#import "AFQiitaResponse.h"
#import "AFQiitaObject.h"
#import "AFQiitaLinkHeader.h"

@interface AFQiitaResponse ()

@property (strong) NSMutableArray *items;
@property (nonatomic) NSInteger cursor;

@end

@implementation AFQiitaResponse
@synthesize items = _items
, itemClass = _itemClass
, cursor = _cursor
, nextURL = _nextURL
, prevURL = _prevURL
, firstURL = _firstURL
, lastURL = _lastURL
;

- (id)initWithResponse:(NSHTTPURLResponse *)response
             itemClass:(Class)itemClass
                  JSON:(id)JSON {
  if(self = [self init]) {
    self.itemClass = itemClass;
    [self processResponse:response JSON:JSON];
  }
  return self;
}

#pragma mark - Accessors

- (id)first {
  if([self.all count]>0) {
    id ret = [self.all objectAtIndex:0];
    return [ret isKindOfClass:[NSNull class]] ? nil : ret;
  }
  return nil;
}

- (id)next {
  if([self.all count]>_cursor) {
    id ret = [self.all objectAtIndex:_cursor++];
    return [ret isKindOfClass:[NSNull class]] ? nil : ret;
  }
  return nil;
}

- (NSArray *)all {
  return _items;
}

- (void)reset {
  _cursor = 0;
}

- (void)setItemClass:(Class)itemClass {
  if(itemClass)
    NSAssert([itemClass conformsToProtocol:@protocol(AFQiitaObject)], @"%@ does not confirm to AFQiitaObject protocol", NSStringFromClass(itemClass));
  _itemClass = itemClass;
}

#pragma mark -

- (void)processResponse:(NSHTTPURLResponse *)response JSON:(id)JSON {
  if(self.itemClass) {
    if(!JSON) {
      self.success = NO;
      return;
    } else {
      self.items = @[].mutableCopy;
      self.success = YES;
    }
    id<AFQiitaObject> object = nil;
    if([JSON isKindOfClass:[NSDictionary class]]) {
      object = [[self.itemClass alloc] initWithDictionary:JSON];
      [self.items addObject:object];
    } else if([JSON isKindOfClass:[NSArray class]]) {
      for (NSDictionary *item in JSON) {
        object = [[self.itemClass alloc] initWithDictionary:item];
        [self.items addObject:object];
      }
    }
  }
  NSDictionary *headers = response.allHeaderFields;
  NSString *link = [headers valueForKey:@"Link"];
  AFQiitaLinkHeader *h = [[AFQiitaLinkHeader alloc] initWithHeaderField:link];
  self.nextURL = [h URLForKey:@"rel" value:@"next"];
  self.prevURL = [h URLForKey:@"rel" value:@"prev"];
  self.firstURL = [h URLForKey:@"rel" value:@"first"];
  self.lastURL = [h URLForKey:@"rel" value:@"last"];
  [self reset];
}


@end
