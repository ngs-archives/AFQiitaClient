//
// AFQiitaComment.m
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

#import "AFQiitaComment.h"
#import "AFQiitaUser.h"

@implementation AFQiitaComment

#pragma mark - Dictionary

- (id)initWithDictionary:(NSDictionary *)dictionary {
  if(self=[super init]) {
    if(dictionary[@"record_id"]&&
       ([dictionary[@"record_id"] isKindOfClass:[NSString class]] ||
        [dictionary[@"record_id"] isKindOfClass:[NSNumber class]]))
      self.recordId = [dictionary[@"record_id"] integerValue];
    if(dictionary[@"user"]&&
       [dictionary[@"user"] isKindOfClass:[NSString class]])
      self.user = [[AFQiitaUser alloc] initWithDictionary:dictionary[@"user"]];
    if(dictionary[@"body"]&&
       [dictionary[@"body"] isKindOfClass:[NSString class]])
      self.body = dictionary[@"body"];
    if(dictionary[@"uuid"]&&
       [dictionary[@"uuid"] isKindOfClass:[NSString class]])
      self.uuid = dictionary[@"uuid"];
  }
  return self;
}

- (NSDictionary *)dictionary {
  return @{
  @"record_id" : @(self.recordId),
  @"user" : [self.user dictionary],
  @"body" : self.body,
  @"uuid" : self.uuid
  };
}


#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
  if(self=[super init]) {
    self.recordId = [aDecoder decodeIntegerForKey:@"record_id"];
    self.user = [aDecoder decodeObjectForKey:@"user"];
    self.body = [aDecoder decodeObjectForKey:@"body"];
    self.uuid = [aDecoder decodeObjectForKey:@"uuid"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  
  [aCoder encodeInteger:self.recordId forKey:@"record_id"];
  [aCoder encodeObject:self.user forKey:@"user"];
  [aCoder encodeObject:self.body forKey:@"body"];
  [aCoder encodeObject:self.uuid forKey:@"uuid"];
}

#pragma mark - NSCopying


- (id)copyWithZone:(NSZone *)zone {
  AFQiitaComment* newCopy = [[[self class] alloc] init];
  newCopy.recordId = self.recordId;
  newCopy.user = [self.user copyWithZone:zone];
  newCopy.body = [self.body copyWithZone:zone];
  newCopy.uuid = [self.uuid copyWithZone:zone];
  return newCopy;
}

@end

