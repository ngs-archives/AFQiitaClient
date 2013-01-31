//
// AFQiitaResponseTests.m
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

#import "AFQiitaResponseTests.h"
#import "AFQiita.h"
#import "FoundationNamedAdditions.h"
#import "MockNSHTTPURLResponse.h"
#import "AFJSONRequestOperation.h"

static NSString *const kTestBundleIdentifier = @"io.ngs.AFQiitaClient-Unit-Tests";

@implementation AFQiitaResponseTests

- (id)JSONWithFilename:(NSString *)filename {
  NSData *data = [NSData dataNamed:filename bundleIdentifier:kTestBundleIdentifier];
  NSError *error = nil;
  id JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
  if(error) STFail(@"%@", error);
  return JSON;
}

- (void)testProcessTagsResponse {
  NSHTTPURLResponse *httpRes = [[MockNSHTTPURLResponse alloc] initWithStatusCode:200];
  id json = [self JSONWithFilename:@"tags.json"];
  AFQiitaResponse *res = [[AFQiitaResponse alloc] initWithResponse:httpRes
                                                         itemClass:[AFQiitaTag class]
                                                              JSON:json];
  AFQiitaTag * tag = nil;
  tag = res.next;
  STAssertEqualObjects(tag.name, @"Qiita", nil);
  STAssertEqualObjects(tag.iconURL, [NSURL URLWithString:@"http://qiita.com/system/tags/icons/000/000/001/thumb/favicon.png?1320171109"], nil);
  STAssertEqualObjects(tag.urlName, @"Qiita", nil);
  STAssertEquals(tag.followerCount, (NSInteger)1953, nil);
  STAssertEquals(tag.itemCount, (NSInteger)165, nil);
  
  tag = res.next;
  STAssertEqualObjects(tag.name, @"Java", nil);
  STAssertEqualObjects(tag.iconURL, [NSURL URLWithString:@"http://qiita.com/system/tags/icons/000/000/002/thumb/Java-Runtime-Environment-V6.0.260.png?1316130938"], nil);
  STAssertEqualObjects(tag.urlName, @"Java", nil);
  STAssertEquals(tag.followerCount, (NSInteger)1977, nil);
  STAssertEquals(tag.itemCount, (NSInteger)156, nil);
  
  tag = res.next;
  STAssertEqualObjects(tag.name, @"Ruby", nil);
  STAssertEqualObjects(tag.iconURL, [NSURL URLWithString:@"http://qiita.com/system/tags/icons/000/000/003/thumb/ruby.jpeg?1316130908"], nil);
  STAssertEqualObjects(tag.urlName, @"Ruby", nil);
  STAssertEquals(tag.followerCount, (NSInteger)2709, nil);
  STAssertEquals(tag.itemCount, (NSInteger)778, nil);
  
  tag = res.next;
  STAssertEqualObjects(tag.name, @"Python", nil);
  STAssertEqualObjects(tag.iconURL, [NSURL URLWithString:@"http://qiita.com/system/tags/icons/000/000/004/thumb/search.gif?1316130880"], nil);
  STAssertEqualObjects(tag.urlName, @"Python", nil);
  STAssertEquals(tag.followerCount, (NSInteger)1544, nil);
  STAssertEquals(tag.itemCount, (NSInteger)211, nil);
  
  tag = res.next;
  STAssertEqualObjects(tag.name, @"Perl", nil);
  STAssertEqualObjects(tag.iconURL, [NSURL URLWithString:@"http://qiita.com/system/tags/icons/000/000/005/thumb/imgres.jpeg?1316130753"], nil);
  STAssertEqualObjects(tag.urlName, @"Perl", nil);
  STAssertEquals(tag.followerCount, (NSInteger)918, nil);
  STAssertEquals(tag.itemCount, (NSInteger)86, nil);
  
  tag = res.next;
  STAssertEqualObjects(tag.name, @"PHP", nil);
  STAssertEqualObjects(tag.iconURL, [NSURL URLWithString:@"http://qiita.com/system/tags/icons/000/000/006/thumb/PHP.png?1338128905"], nil);
  STAssertEqualObjects(tag.urlName, @"PHP", nil);
  STAssertEquals(tag.followerCount, (NSInteger)2514, nil);
  STAssertEquals(tag.itemCount, (NSInteger)454, nil);
  
  tag = res.next;
  STAssertEqualObjects(tag.name, @"Emacs", nil);
  STAssertEqualObjects(tag.iconURL, [NSURL URLWithString:@"http://qiita.com/system/tags/icons/000/000/007/thumb/emacs.jpeg?1316130821"], nil);
  STAssertEqualObjects(tag.urlName, @"Emacs", nil);
  STAssertEquals(tag.followerCount, (NSInteger)1165, nil);
  STAssertEquals(tag.itemCount, (NSInteger)181, nil);
  
  tag = res.next;
  STAssertEqualObjects(tag.name, @"Vim", nil);
  STAssertEqualObjects(tag.iconURL, [NSURL URLWithString:@"http://qiita.com/system/tags/icons/000/000/008/thumb/vim-editor_logo.png?1316130850"], nil);
  STAssertEqualObjects(tag.urlName, @"Vim", nil);
  STAssertEquals(tag.followerCount, (NSInteger)2258, nil);
  STAssertEquals(tag.itemCount, (NSInteger)191, nil);
  
  tag = res.next;
  STAssertEqualObjects(tag.name, @"ShellScript", nil);
  STAssertEqualObjects(tag.iconURL, [NSURL URLWithString:@"http://qiita.com/system/tags/icons/000/000/009/thumb/shellscript.png?1316130734"], nil);
  STAssertEqualObjects(tag.urlName, @"ShellScript", nil);
  STAssertEquals(tag.followerCount, (NSInteger)1253, nil);
  STAssertEquals(tag.itemCount, (NSInteger)110, nil);
  
  tag = res.next;
  STAssertEqualObjects(tag.name, @"C", nil);
  STAssertEqualObjects(tag.iconURL, [NSURL URLWithString:@"http://qiita.com/system/tags/icons/000/000/010/thumb/C.png?1318001428"], nil);
  STAssertEqualObjects(tag.urlName, @"C", nil);
  STAssertEquals(tag.followerCount, (NSInteger)1098, nil);
  STAssertEquals(tag.itemCount, (NSInteger)54, nil);
  
  tag = res.next;
  STAssertEqualObjects(tag.name, @"C++", nil);
  STAssertEqualObjects(tag.iconURL, [NSURL URLWithString:@"http://qiita.com/system/tags/icons/000/000/011/thumb/203px-Gccegg.png?1328941397"], nil);
  STAssertEqualObjects(tag.urlName, @"C%2B%2B", nil);
  STAssertEquals(tag.followerCount, (NSInteger)1112, nil);
  STAssertEquals(tag.itemCount, (NSInteger)76, nil);
  
  tag = res.next;
  STAssertEqualObjects(tag.name, @"Objective-C", nil);
  STAssertEqualObjects(tag.iconURL, [NSURL URLWithString:@"http://qiita.com/system/tags/icons/000/000/012/thumb/objc.png?1316167122"], nil);
  STAssertEqualObjects(tag.urlName, @"Objective-C", nil);
  STAssertEquals(tag.followerCount, (NSInteger)1980, nil);
  STAssertEquals(tag.itemCount, (NSInteger)283, nil);
  
  tag = res.next;
  STAssertEqualObjects(tag.name, @"HTML", nil);
  STAssertEqualObjects(tag.iconURL, [NSURL URLWithString:@"http://qiita.com/system/tags/icons/000/000/013/thumb/110126-HTML5_Logo.png?1316130376"], nil);
  STAssertEqualObjects(tag.urlName, @"HTML", nil);
  STAssertEquals(tag.followerCount, (NSInteger)3410, nil);
  STAssertEquals(tag.itemCount, (NSInteger)91, nil);
  
  tag = res.next;
  STAssertEqualObjects(tag.name, @"CSS", nil);
  STAssertEqualObjects(tag.iconURL, [NSURL URLWithString:@"http://qiita.com/system/tags/icons/000/000/014/thumb/%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB:Nuvola_mimetypes_source_css.png?1316130407"], nil);
  STAssertEqualObjects(tag.urlName, @"CSS", nil);
  STAssertEquals(tag.followerCount, (NSInteger)3031, nil);
  STAssertEquals(tag.itemCount, (NSInteger)111, nil);
  
  tag = res.next;
  STAssertEqualObjects(tag.name, @"JavaScript", nil);
  STAssertEqualObjects(tag.iconURL, [NSURL URLWithString:@"http://qiita.com/system/tags/icons/000/000/015/thumb/images.jpeg?1316130454"], nil);
  STAssertEqualObjects(tag.urlName, @"JavaScript", nil);
  STAssertEquals(tag.followerCount, (NSInteger)4184, nil);
  STAssertEquals(tag.itemCount, (NSInteger)577, nil);
  
  tag = res.next;
  STAssertEqualObjects(tag.name, @"CoffeeScript", nil);
  STAssertEqualObjects(tag.iconURL, [NSURL URLWithString:@"http://qiita.com/system/tags/icons/000/000/016/thumb/coffeescript_logo.png?1316130584"], nil);
  STAssertEqualObjects(tag.urlName, @"CoffeeScript", nil);
  STAssertEquals(tag.followerCount, (NSInteger)1346, nil);
  STAssertEquals(tag.itemCount, (NSInteger)65, nil);
  
  tag = res.next;
  STAssertEqualObjects(tag.name, @"Haskell", nil);
  STAssertEqualObjects(tag.iconURL, [NSURL URLWithString:@"http://qiita.com/system/tags/icons/000/000/017/thumb/%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB:Haskell-Logo.png?1316130328"], nil);
  STAssertEqualObjects(tag.urlName, @"Haskell", nil);
  STAssertEquals(tag.followerCount, (NSInteger)638, nil);
  STAssertEquals(tag.itemCount, (NSInteger)115, nil);
  
  tag = res.next;
  STAssertEqualObjects(tag.name, @"Scheme", nil);
  STAssertEqualObjects(tag.iconURL, [NSURL URLWithString:@"http://qiita.com/system/tags/icons/000/000/018/thumb/%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB:Lambda_lc.png?1316130303"], nil);
  STAssertEqualObjects(tag.urlName, @"Scheme", nil);
  STAssertEquals(tag.followerCount, (NSInteger)416, nil);
  STAssertEquals(tag.itemCount, (NSInteger)42, nil);
  
  tag = res.next;
  STAssertEqualObjects(tag.name, @"iPhone", nil);
  STAssertEqualObjects(tag.iconURL, [NSURL URLWithString:@"http://qiita.com/system/tags/icons/000/000/019/thumb/k1014925770.jpeg?1316130246"], nil);
  STAssertEqualObjects(tag.urlName, @"iPhone", nil);
  STAssertEquals(tag.followerCount, (NSInteger)2660, nil);
  STAssertEquals(tag.itemCount, (NSInteger)157, nil);
  
  tag = res.next;
  STAssertEqualObjects(tag.name, @"Android", nil);
  STAssertEqualObjects(tag.iconURL, [NSURL URLWithString:@"http://qiita.com/system/tags/icons/000/000/020/thumb/android_logo.gif?1316130200"], nil);
  STAssertEqualObjects(tag.urlName, @"Android", nil);
  STAssertEquals(tag.followerCount, (NSInteger)2105, nil);
  STAssertEquals(tag.itemCount, (NSInteger)201, nil);
  
  STAssertNil(res.next, nil);
}



- (void)testProcessItemsResponse {
  NSHTTPURLResponse *httpRes = [[MockNSHTTPURLResponse alloc] initWithStatusCode:200];
  id json = [self JSONWithFilename:@"items.json"];
  AFQiitaResponse *res = [[AFQiitaResponse alloc] initWithResponse:httpRes
                                                         itemClass:[AFQiitaItem class]
                                                              JSON:json];
  AFQiitaItem * item = nil;
  while ((item = res.next)) {
    STAssertNotNil(item.createdAt, nil);
    STAssertNotNil(item.updatedAt, nil);
  }
}

@end
