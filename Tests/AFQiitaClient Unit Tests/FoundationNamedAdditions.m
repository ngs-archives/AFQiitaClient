//
// FoundationNamedAdditions.m
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

#import "FoundationNamedAdditions.h"

@implementation NSArray (NamedAddition)

+ (NSArray *)arrayNamed:(NSString *)name {
  return [NSArray arrayNamed:name bundleIdentifier:nil];
}

+ (NSArray *)arrayNamed:(NSString *)name bundleIdentifier:(NSString *)bundleIdentifier {
  NSBundle *bundle = bundleIdentifier && [bundleIdentifier isKindOfClass:[NSString class]] ?
  [NSBundle bundleWithIdentifier:bundleIdentifier] : [NSBundle mainBundle];
  return [NSArray arrayWithContentsOfFile:[bundle pathForNamedAsset:name]];
}

@end

@implementation NSDictionary (NamedAddition)

+ (NSDictionary *)dictionaryNamed:(NSString *)name {
  return [NSDictionary dictionaryNamed:name bundleIdentifier:nil];
}

+ (NSDictionary *)dictionaryNamed:(NSString *)name bundleIdentifier:(NSString *)bundleIdentifier {
  NSBundle *bundle = bundleIdentifier && [bundleIdentifier isKindOfClass:[NSString class]] ?
  [NSBundle bundleWithIdentifier:bundleIdentifier] : [NSBundle mainBundle];
  return [NSDictionary dictionaryWithContentsOfFile:[bundle pathForNamedAsset:name]];
}

@end

@implementation NSData (NamedAddition)

+ (NSData *)dataNamed:(NSString *)name {
  return [NSData dataNamed:name bundleIdentifier:nil];
}

+ (NSData *)dataNamed:(NSString *)name bundleIdentifier:(NSString *)bundleIdentifier {
  NSBundle *bundle = bundleIdentifier && [bundleIdentifier isKindOfClass:[NSString class]] ?
  [NSBundle bundleWithIdentifier:bundleIdentifier] : [NSBundle mainBundle];
  return [NSData dataWithContentsOfFile:[bundle pathForNamedAsset:name]];
}

@end

@implementation NSBundle (NamedAddition)

- (NSString *)pathForNamedAsset:(NSString *)name {
  NSMutableArray *ar = [[name componentsSeparatedByString:@"."] mutableCopy];
  NSString *ext = @"plist";
  if([ar count]>=2) {
    ext = [ar lastObject];
    [ar removeLastObject];
  }
  name = [ar componentsJoinedByString:@"."];
  NSString *ret = [self pathForResource:name ofType:ext];
  return ret;
}

@end
