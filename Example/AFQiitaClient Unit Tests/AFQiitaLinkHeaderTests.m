//
// AFQiitaLinkHeaderTests.m
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

#import "AFQiitaLinkHeaderTests.h"
#import "AFQiitaLinkHeader.h"

@implementation AFQiitaLinkHeaderTests

- (void)testParsing {
  AFQiitaLinkHeader *h = [[AFQiitaLinkHeader alloc] init];
  h.baseURL = [NSURL URLWithString:@"http://www.mydomain.tld/path/to/html/doc.html"];
  [h parseHeaderField:@"Link: <../media/contrast.css>; rel=\"stylesheet alternate\";\
   title=\"High Contrast Styles\"; type=\"text/css\"; media=\"screen\"  , \
   <../media/print.css>; rel=\"stylesheet\"; type=\"text/css\";\
   media=\"print\""];
  
  NSArray *res = nil;
  NSURL *URL = nil;
  
  res = [h URLsForKey:@"type" value:@"text/css"];
  
  STAssertEquals(res.count, (NSUInteger)2, nil);
  
  URL = [res objectAtIndex:0];
  STAssertEqualObjects(URL.absoluteString, @"http://www.mydomain.tld/path/to/media/contrast.css" ,nil);
  
  URL = [res objectAtIndex:1];
  STAssertEqualObjects(URL.absoluteString, @"http://www.mydomain.tld/path/to/media/print.css" ,nil);
  
  
  URL = [h URLForKey:@"rel" value:@"stylesheet alternate"];
  STAssertEqualObjects(URL.absoluteString, @"http://www.mydomain.tld/path/to/media/contrast.css" ,nil);
  
  URL = [h URLForKey:@"rel" value:@"stylesheet"];
  STAssertEqualObjects(URL.absoluteString, @"http://www.mydomain.tld/path/to/media/print.css" ,nil);
}

@end