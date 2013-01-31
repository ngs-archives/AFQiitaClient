//
// FoundationNamedAdditions.h
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

@interface NSArray (NamedAddition)
+ (NSArray *)arrayNamed:(NSString *)name;
+ (NSArray *)arrayNamed:(NSString *)name bundleIdentifier:(NSString *)bundleIdentifier;
@end

@interface NSDictionary (NamedAddition)
+ (NSDictionary *)dictionaryNamed:(NSString *)name;
+ (NSDictionary *)dictionaryNamed:(NSString *)name bundleIdentifier:(NSString *)bundleIdentifier;
@end

@interface NSData (NamedAddition)
+ (NSData *)dataNamed:(NSString *)name;
+ (NSData *)dataNamed:(NSString *)name bundleIdentifier:(NSString *)bundleIdentifier;
@end

@interface NSBundle (NamedAddition)
- (NSString *)pathForNamedAsset:(NSString *)name;
@end
