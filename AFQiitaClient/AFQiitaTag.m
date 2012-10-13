//
// AFQiitaTag.m
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

#import "AFQiitaTag.h"

@implementation AFQiitaTag

+ (AFQiitaTag *)tagWithName:(NSString *)name {
  return [[self class] tagWithName:name versions:nil];
}
+ (AFQiitaTag *)tagWithName:(NSString *)name versions:(NSString *)versions, ... {
  AFQiitaTag *tag = [[[self class] alloc] init];
  NSMutableArray *buf = @[].mutableCopy;
  NSString *version = nil;
  va_list args;
  va_start(args, versions);
  while ((version = va_arg(args, NSString *)))
    [buf addObject:version];
  va_end(args);
  tag.versions = buf.copy;
  tag.name = name;
  return tag;
}

#pragma mark - Dictionary

- (id)initWithDictionary:(NSDictionary *)dictionary {
  if(self=[super init]) {
    if(dictionary[@"name"]&&
       [dictionary[@"name"] isKindOfClass:[NSString class]])
      self.name = dictionary[@"name"];
    if(dictionary[@"url_name"]&&
       [dictionary[@"url_name"] isKindOfClass:[NSString class]])
      self.urlName = dictionary[@"url_name"];
    if(dictionary[@"icon_url"]&&
       [dictionary[@"icon_url"] isKindOfClass:[NSString class]])
      self.iconURL = [NSURL URLWithString:dictionary[@"icon_url"]];
    if(dictionary[@"versions"]&&
       [dictionary[@"versions"] isKindOfClass:[NSString class]])
      self.versions = dictionary[@"versions"];
    if(dictionary[@"item_count"]&&
       ([dictionary[@"item_count"] isKindOfClass:[NSString class]] ||
        [dictionary[@"item_count"] isKindOfClass:[NSNumber class]]))
      self.itemCount = [dictionary[@"item_count"] integerValue];
    if(dictionary[@"follower_count"]&&
       ([dictionary[@"follower_count"] isKindOfClass:[NSString class]] ||
        [dictionary[@"follower_count"] isKindOfClass:[NSNumber class]]))
      self.followerCount = [dictionary[@"follower_count"] integerValue];
  }
  return self;
}

- (NSDictionary *)dictionary {
  return @{
  @"name" : self.name,
  @"url_name" : self.urlName,
  @"icon_url" : self.iconURL.absoluteString,
  @"versions" : self.versions,
  @"item_count" : @(self.itemCount),
  @"follower_count" : @(self.followerCount)
  };
}


#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
  if(self=[super init]) {
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.urlName = [aDecoder decodeObjectForKey:@"url_name"];
    self.iconURL = [aDecoder decodeObjectForKey:@"icon_url"];
    self.versions = [aDecoder decodeObjectForKey:@"versions"];
    self.itemCount = [aDecoder decodeIntegerForKey:@"item_count"];
    self.followerCount = [aDecoder decodeIntegerForKey:@"follower_count"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.name forKey:@"name"];
  [aCoder encodeObject:self.urlName forKey:@"url_name"];
  [aCoder encodeObject:self.iconURL forKey:@"icon_url"];
  [aCoder encodeObject:self.versions forKey:@"versions"];
  [aCoder encodeInteger:self.itemCount forKey:@"item_count"];
  [aCoder encodeInteger:self.followerCount forKey:@"follower_count"];
}

#pragma mark - NSCopying


- (id)copyWithZone:(NSZone *)zone {
  AFQiitaTag* newCopy = [[[self class] alloc] init];
  newCopy.name = [self.name copyWithZone:zone];
  newCopy.urlName = [self.urlName copyWithZone:zone];
  newCopy.iconURL = [self.iconURL copyWithZone:zone];
  newCopy.versions = [self.versions copyWithZone:zone];
  newCopy.itemCount = self.itemCount;
  newCopy.followerCount = self.followerCount;
  return newCopy;
}

@end