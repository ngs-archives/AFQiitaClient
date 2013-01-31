//
// AFQiitaItem.m
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

#import "AFQiitaItem.h"
#import "AFQiitaUser.h"

@implementation AFQiitaItem

#pragma mark - Dictionary

- (id)initWithDictionary:(NSDictionary *)dictionary {
  if(self=[super init]) {

    static NSDateFormatter *DateFormatter;
    if(!DateFormatter) {
      // "2012-10-13 13:30:19 +0900",
      DateFormatter = [[NSDateFormatter alloc] init];
      [DateFormatter setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss ZZZ"];
    }
    if(dictionary[@"is_private"]&&
       ([dictionary[@"is_private"] isKindOfClass:[NSString class]] ||
        [dictionary[@"is_private"] isKindOfClass:[NSNumber class]]))
      self.isPrivate = [dictionary[@"is_private"] boolValue];

    if(dictionary[@"is_stocked"]&&
       ([dictionary[@"is_stocked"] isKindOfClass:[NSString class]] ||
        [dictionary[@"is_stocked"] isKindOfClass:[NSNumber class]]))
      self.isStocked = [dictionary[@"is_stocked"] boolValue];

    if(dictionary[@"comment_count"]&&
       ([dictionary[@"comment_count"] isKindOfClass:[NSString class]] ||
        [dictionary[@"comment_count"] isKindOfClass:[NSNumber class]]))
      self.commentCount = [dictionary[@"comment_count"] integerValue];

    if(dictionary[@"id"]&&
       ([dictionary[@"id"] isKindOfClass:[NSString class]] ||
        [dictionary[@"id"] isKindOfClass:[NSNumber class]]))
      self.recordId = [dictionary[@"id"] integerValue];

    if(dictionary[@"stock_count"]&&
       ([dictionary[@"stock_count"] isKindOfClass:[NSString class]] ||
        [dictionary[@"stock_count"] isKindOfClass:[NSNumber class]]))
      self.stockCount = [dictionary[@"stock_count"] integerValue];

    if(dictionary[@"user"]&&
       [dictionary[@"user"] isKindOfClass:[NSDictionary class]])
      self.user = [[AFQiitaUser alloc] initWithDictionary:dictionary[@"user"]];

    if(dictionary[@"comments"]&&
       [dictionary[@"comments"] isKindOfClass:[NSString class]])
      self.comments = dictionary[@"comments"];

    if(dictionary[@"stock_users"]&&
       [dictionary[@"stock_users"] isKindOfClass:[NSString class]])
      self.stockUsers = dictionary[@"stock_users"];

    if(dictionary[@"tags"]&&
       [dictionary[@"tags"] isKindOfClass:[NSString class]])
      self.tags = dictionary[@"tags"];

    if(dictionary[@"created_at"]&&
       [dictionary[@"created_at"] isKindOfClass:[NSString class]])
      self.createdAt = [DateFormatter dateFromString:dictionary[@"created_at"]];

    if(dictionary[@"updated_at"]&&
       [dictionary[@"updated_at"] isKindOfClass:[NSString class]])
      self.updatedAt = [DateFormatter dateFromString:dictionary[@"updated_at"]];

    if(dictionary[@"body"]&&
       [dictionary[@"body"] isKindOfClass:[NSString class]])
      self.body = dictionary[@"body"];

    if(dictionary[@"created_at_in_words"]&&
       [dictionary[@"created_at_in_words"] isKindOfClass:[NSString class]])
      self.createdAtInWords = dictionary[@"created_at_in_words"];

    if(dictionary[@"title"]&&
       [dictionary[@"title"] isKindOfClass:[NSString class]])
      self.title = dictionary[@"title"];

    if(dictionary[@"updated_at_in_words"]&&
       [dictionary[@"updated_at_in_words"] isKindOfClass:[NSString class]])
      self.updatedAtInWords = dictionary[@"updated_at_in_words"];

    if(dictionary[@"uuid"]&&
       [dictionary[@"uuid"] isKindOfClass:[NSString class]])
      self.uuid = dictionary[@"uuid"];

    if(dictionary[@"gist_url"]&&
       [dictionary[@"gist_url"] isKindOfClass:[NSString class]])
      self.gistUrl = [NSURL URLWithString:dictionary[@"gist_url"]];

    if(dictionary[@"url"]&&
       [dictionary[@"url"] isKindOfClass:[NSString class]])
      self.url = [NSURL URLWithString:dictionary[@"url"]];
  }
  return self;
}

- (NSDictionary *)dictionary {
  return @{
  @"is_private" :     @(self.isPrivate),
  @"is_stocked" :     @(self.isStocked),
  @"comment_count" :     @(self.commentCount),
  @"id" :     @(self.recordId),
  @"stock_count" :     @(self.stockCount),
  @"user" : [self.user dictionary],
  @"comments" : self.comments,
  @"stock_users" : self.stockUsers,
  @"tags" : self.tags,
  @"created_at" : self.createdAt,
  @"updated_at" : self.updatedAt,
  @"body" : self.body,
  @"created_at_in_words" : self.createdAtInWords,
  @"title" : self.title,
  @"updated_at_in_words" : self.updatedAtInWords,
  @"uuid" : self.uuid,
  @"gist_url" : self.gistUrl.absoluteString,
  @"url" : self.url.absoluteString
  };
}

#pragma mark - Parameter Dictionaries

- (NSDictionary *)parameterDictionaryForUpdate {
  return @{
  @"title" : self.title,
  @"tags" : self.tags,
  @"body" : self.body,
  @"private" : @(self.isPrivate)
  };
}

- (NSDictionary *)parameterDictionaryForCreate {
  return @{
  @"title" : self.title,
  @"tags" : self.tags,
  @"body" : self.body,
  @"private" : @(self.isPrivate)
  };
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
  if(self=[super init]) {
    self.isPrivate = [aDecoder decodeBoolForKey:@"is_private"];
    self.isStocked = [aDecoder decodeBoolForKey:@"is_stocked"];
    self.commentCount = [aDecoder decodeIntegerForKey:@"comment_count"];
    self.recordId = [aDecoder decodeIntegerForKey:@"id"];
    self.stockCount = [aDecoder decodeIntegerForKey:@"stock_count"];
    self.user = [aDecoder decodeObjectForKey:@"user"];
    self.comments = [aDecoder decodeObjectForKey:@"comments"];
    self.stockUsers = [aDecoder decodeObjectForKey:@"stock_users"];
    self.tags = [aDecoder decodeObjectForKey:@"tags"];
    self.createdAt = [aDecoder decodeObjectForKey:@"created_at"];
    self.updatedAt = [aDecoder decodeObjectForKey:@"updated_at"];
    self.body = [aDecoder decodeObjectForKey:@"body"];
    self.createdAtInWords = [aDecoder decodeObjectForKey:@"created_at_in_words"];
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.updatedAtInWords = [aDecoder decodeObjectForKey:@"updated_at_in_words"];
    self.uuid = [aDecoder decodeObjectForKey:@"uuid"];
    self.gistUrl = [aDecoder decodeObjectForKey:@"gist_url"];
    self.url = [aDecoder decodeObjectForKey:@"url"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {

  [aCoder encodeBool:self.isPrivate forKey:@"is_private"];
  [aCoder encodeBool:self.isStocked forKey:@"is_stocked"];
  [aCoder encodeInteger:self.commentCount forKey:@"comment_count"];
  [aCoder encodeInteger:self.recordId forKey:@"id"];
  [aCoder encodeInteger:self.stockCount forKey:@"stock_count"];
  [aCoder encodeObject:self.user forKey:@"user"];
  [aCoder encodeObject:self.comments forKey:@"comments"];
  [aCoder encodeObject:self.stockUsers forKey:@"stock_users"];
  [aCoder encodeObject:self.tags forKey:@"tags"];
  [aCoder encodeObject:self.createdAt forKey:@"created_at"];
  [aCoder encodeObject:self.updatedAt forKey:@"updated_at"];
  [aCoder encodeObject:self.body forKey:@"body"];
  [aCoder encodeObject:self.createdAtInWords forKey:@"created_at_in_words"];
  [aCoder encodeObject:self.title forKey:@"title"];
  [aCoder encodeObject:self.updatedAtInWords forKey:@"updated_at_in_words"];
  [aCoder encodeObject:self.uuid forKey:@"uuid"];
  [aCoder encodeObject:self.gistUrl forKey:@"gist_url"];
  [aCoder encodeObject:self.url forKey:@"url"];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
  AFQiitaItem* newCopy = [[[self class] alloc] init];
  newCopy.isPrivate = self.isPrivate;
  newCopy.isStocked = self.isStocked;
  newCopy.commentCount = self.commentCount;
  newCopy.recordId = self.recordId;
  newCopy.stockCount = self.stockCount;
  newCopy.user = [self.user copyWithZone:zone];
  newCopy.comments = [self.comments copyWithZone:zone];
  newCopy.stockUsers = [self.stockUsers copyWithZone:zone];
  newCopy.tags = [self.tags copyWithZone:zone];
  newCopy.createdAt = [self.createdAt copyWithZone:zone];
  newCopy.updatedAt = [self.updatedAt copyWithZone:zone];
  newCopy.body = [self.body copyWithZone:zone];
  newCopy.createdAtInWords = [self.createdAtInWords copyWithZone:zone];
  newCopy.title = [self.title copyWithZone:zone];
  newCopy.updatedAtInWords = [self.updatedAtInWords copyWithZone:zone];
  newCopy.uuid = [self.uuid copyWithZone:zone];
  newCopy.gistUrl = [self.gistUrl copyWithZone:zone];
  newCopy.url = [self.url copyWithZone:zone];
  return newCopy;
}

- (BOOL)isEqual:(id)object {
  if([object isKindOfClass:[self class]])
    return [(AFQiitaItem *)object recordId] == self.recordId;
  return NO;
}

- (NSString *)description {
  return [NSString stringWithFormat:@"<%@: id=%ld, title=%@>", NSStringFromClass(self.class), self.recordId, self.title];
}

@end

