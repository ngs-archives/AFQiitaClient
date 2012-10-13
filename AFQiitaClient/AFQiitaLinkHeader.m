//
// AFQiitaLinkHeader.m
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

#import "AFQiitaLinkHeader.h"

// https://gist.github.com/2845620
#define LINK_SPLIT @"<[^>]*>\\s*(?:;\\s*(?:(?:[^\\(\\)<>@,;:\\\\\"/\\[\\]\\?={} \\t]+?)(?:=(?:(?:[^\\(\\)<>@,;:\\\\\"/\\[\\]\\?={} \\t]+?)|(?:\"(?:\\\\\"|[^\"])*\")))?)?\\s*)*(?=(?:\\s*(?:,\\s*)+)|\\s*$)"

@interface AFQiitaLinkHeader ()

@property (readonly) NSRegularExpression *linkSplitter;

@end

@implementation AFQiitaLinkHeader
@synthesize linkSplitter = _linkSplitter;


- (id)initWithHeaderField:(NSString *)headerField {
  return self = [self initWithHeaderField:headerField baseURL:nil];
}

- (id)initWithHeaderField:(NSString *)headerField baseURL:(NSURL *)baseURL {
  if(self= [super init]) {
    self.baseURL = baseURL;
    [self parseHeaderField:headerField];
  }
  return self;
}

- (void)parseHeaderField:(NSString *)headerField {
  if(!headerField || ![headerField isKindOfClass:[NSString class]] || headerField.length == 1) return;
  NSMutableArray *links = [NSMutableArray array];
  NSArray *matches = [self.linkSplitter matchesInString:headerField options:0 range:NSMakeRange(0, headerField.length)];
  NSCharacterSet *ws = [NSCharacterSet whitespaceAndNewlineCharacterSet];
  for (NSTextCheckingResult *match in matches) {
    NSString *h = [[headerField substringWithRange:match.range] stringByTrimmingCharactersInSet:ws];
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    for (NSString *cur in [h componentsSeparatedByString:@";"]) {
      NSString *kv = [cur stringByTrimmingCharactersInSet:ws];
      if(
         ![mdic objectForKey:@"href"] &&
         [kv rangeOfString:@"<"].location==0
         ) {
        kv = [kv substringWithRange:NSMakeRange(1, kv.length-2)];
        NSURL *URL = [NSURL URLWithString:kv relativeToURL:self.baseURL];
        [mdic setObject:URL forKey:@"href"];
        continue;
      }
      NSArray *kva = [kv componentsSeparatedByString:@"="];
      if(kva.count<2) continue;
      NSString *k = [[kva objectAtIndex:0] stringByTrimmingCharactersInSet:ws];
      NSString *v = [[kva objectAtIndex:1] stringByTrimmingCharactersInSet:ws];
      if([v rangeOfString:@"\""].location==0) {
        v = [v substringWithRange:NSMakeRange(1, v.length-2)];
      }
      [mdic setValue:v forKey:k];
    }
    [links addObject:mdic.copy];
  }
  self.links = links.copy;
}

- (NSURL *)URLForKey:(NSString *)key value:(NSString *)value {
  NSArray *ar = [self URLsForKey:key value:value];
  if(ar && [ar isKindOfClass:[NSArray class]] && ar.count > 0)
    return [ar objectAtIndex:0];
  return nil;
}

- (NSArray *)URLsForKey:(NSString *)key value:(NSString *)value {
  NSMutableArray *buf = [NSMutableArray array];
  for (NSDictionary *link in self.links) {
    if([value isEqualToString:[link valueForKey:key]]) {
      [buf addObject:[link objectForKey:@"href"]];
    }
  }
  return buf.copy;
}

#pragma mark - Private Accessors

- (NSRegularExpression *)linkSplitter {
  if(nil==_linkSplitter) {
    NSError *error = nil;
    _linkSplitter = [[NSRegularExpression alloc] initWithPattern:LINK_SPLIT options:0 error:&error];
    NSAssert(nil==error, @"Error should be nil %@", error);
  }
  return _linkSplitter;
}


@end