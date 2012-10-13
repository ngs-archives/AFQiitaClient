//
// AFQiitaUser.m
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

#import "AFQiitaUser.h"

@implementation AFQiitaUser

#pragma mark - Dictionary

- (id)initWithDictionary:(NSDictionary *)dictionary {
  if(self=[super init]) {
    if(dictionary[@"name"]&&
       [dictionary[@"name"] isKindOfClass:[NSString class]])
      self.name = dictionary[@"name"];
    if(dictionary[@"url_name"]&&
       [dictionary[@"url_name"] isKindOfClass:[NSString class]])
      self.urlName = dictionary[@"url_name"];
    if(dictionary[@"description"]&&
       [dictionary[@"description"] isKindOfClass:[NSString class]])
      self.description = dictionary[@"description"];
    if(dictionary[@"organization"]&&
       [dictionary[@"organization"] isKindOfClass:[NSString class]])
      self.organization = dictionary[@"organization"];
    if(dictionary[@"location"]&&
       [dictionary[@"location"] isKindOfClass:[NSString class]])
      self.location = dictionary[@"location"];
    if(dictionary[@"facebook"]&&
       [dictionary[@"facebook"] isKindOfClass:[NSString class]])
      self.facebook = dictionary[@"facebook"];
    if(dictionary[@"twitter"]&&
       [dictionary[@"twitter"] isKindOfClass:[NSString class]])
      self.twitter = dictionary[@"twitter"];
    if(dictionary[@"linkedin"]&&
       [dictionary[@"linkedin"] isKindOfClass:[NSString class]])
      self.linkedin = dictionary[@"linkedin"];
    if(dictionary[@"profile_image_url"]&&
       [dictionary[@"profile_image_url"] isKindOfClass:[NSString class]])
      self.profileImageURL = [NSURL URLWithString:dictionary[@"profile_image_url"]];
    if(dictionary[@"url"]&&
       [dictionary[@"url"] isKindOfClass:[NSString class]])
      self.url = [NSURL URLWithString:dictionary[@"url"]];
    if(dictionary[@"website_url"]&&
       [dictionary[@"website_url"] isKindOfClass:[NSString class]])
      self.websiteUrl = [NSURL URLWithString:dictionary[@"website_url"]];
    if(dictionary[@"followers"]&&
       
       ([dictionary[@"followers"] isKindOfClass:[NSString class]] ||
        [dictionary[@"followers"] isKindOfClass:[NSNumber class]]))
      self.followers = [dictionary[@"followers"] integerValue];
    if(dictionary[@"following_users"]&&
       
       ([dictionary[@"following_users"] isKindOfClass:[NSString class]] ||
        [dictionary[@"following_users"] isKindOfClass:[NSNumber class]]))
      self.followingUsers = [dictionary[@"following_users"] integerValue];
    if(dictionary[@"items"]&&
       
       ([dictionary[@"items"] isKindOfClass:[NSString class]] ||
        [dictionary[@"items"] isKindOfClass:[NSNumber class]]))
      self.items = [dictionary[@"items"] integerValue];
  }
  return self;
}

- (NSDictionary *)dictionary {
  return @{
  @"name" : self.name,
  @"url_name" : self.urlName,
  @"description" : self.description,
  @"organization" : self.organization,
  @"location" : self.location,
  @"facebook" : self.facebook,
  @"twitter" : self.twitter,
  @"linkedin" : self.linkedin,
  @"profile_image_url" : self.profileImageURL.absoluteString,
  @"url" : self.url.absoluteString,
  @"website_url" : self.websiteUrl.absoluteString,
  @"followers" : @(self.followers),
  @"following_users" : @(self.followingUsers),
  @"items" : @(self.items)
  };
}


#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
  if(self=[super init]) {
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.urlName = [aDecoder decodeObjectForKey:@"url_name"];
    self.description = [aDecoder decodeObjectForKey:@"description"];
    self.organization = [aDecoder decodeObjectForKey:@"organization"];
    self.location = [aDecoder decodeObjectForKey:@"location"];
    self.facebook = [aDecoder decodeObjectForKey:@"facebook"];
    self.twitter = [aDecoder decodeObjectForKey:@"twitter"];
    self.linkedin = [aDecoder decodeObjectForKey:@"linkedin"];
    self.profileImageURL = [aDecoder decodeObjectForKey:@"profile_image_url"];
    self.url = [aDecoder decodeObjectForKey:@"url"];
    self.websiteUrl = [aDecoder decodeObjectForKey:@"website_url"];
    self.followers = [aDecoder decodeIntegerForKey:@"followers"];
    self.followingUsers = [aDecoder decodeIntegerForKey:@"following_users"];
    self.items = [aDecoder decodeIntegerForKey:@"items"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  
  [aCoder encodeObject:self.name forKey:@"name"];
  [aCoder encodeObject:self.urlName forKey:@"url_name"];
  [aCoder encodeObject:self.description forKey:@"description"];
  [aCoder encodeObject:self.organization forKey:@"organization"];
  [aCoder encodeObject:self.location forKey:@"location"];
  [aCoder encodeObject:self.facebook forKey:@"facebook"];
  [aCoder encodeObject:self.twitter forKey:@"twitter"];
  [aCoder encodeObject:self.linkedin forKey:@"linkedin"];
  [aCoder encodeObject:self.profileImageURL forKey:@"profile_image_url"];
  [aCoder encodeObject:self.url forKey:@"url"];
  [aCoder encodeObject:self.websiteUrl forKey:@"website_url"];
  [aCoder encodeInteger:self.followers forKey:@"followers"];
  [aCoder encodeInteger:self.followingUsers forKey:@"following_users"];
  [aCoder encodeInteger:self.items forKey:@"items"];
}

#pragma mark - NSCopying


- (id)copyWithZone:(NSZone *)zone {
  AFQiitaUser* newCopy = [[[self class] alloc] init];
  newCopy.name = [self.name copyWithZone:zone];
  newCopy.urlName = [self.urlName copyWithZone:zone];
  newCopy.description = [self.description copyWithZone:zone];
  newCopy.organization = [self.organization copyWithZone:zone];
  newCopy.location = [self.location copyWithZone:zone];
  newCopy.facebook = [self.facebook copyWithZone:zone];
  newCopy.twitter = [self.twitter copyWithZone:zone];
  newCopy.linkedin = [self.linkedin copyWithZone:zone];
  newCopy.profileImageURL = [self.profileImageURL copyWithZone:zone];
  newCopy.url = [self.url copyWithZone:zone];
  newCopy.websiteUrl = [self.websiteUrl copyWithZone:zone];
  newCopy.followers = self.followers;
  newCopy.followingUsers = self.followingUsers;
  newCopy.items = self.items;
  return newCopy;
}

@end

