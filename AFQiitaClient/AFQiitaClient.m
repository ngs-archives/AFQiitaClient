//
// AFQiitaClient.m
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

#import "AFQiitaClient.h"
#import "AFQiitaResponse.h"
#import "AFQiitaRequestOperation.h"
#import "AFQiitaUser.h"
#import "AFQiitaItem.h"
#import "AFQiitaTag.h"
#import "AFQiitaComment.h"

static NSString *const kAFQiitaClientBaseURLPath = @"https://qiita.com/api/v1";

@implementation AFQiitaClient

- (id)init {
  if(self = [super initWithBaseURL:[NSURL URLWithString:kAFQiitaClientBaseURLPath]]) {
    [self registerHTTPOperationClass:[AFQiitaRequestOperation class]];
    [self setParameterEncoding:AFJSONParameterEncoding];
    [AFQiitaRequestOperation addAcceptableStatusCodes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(400, 4)]];
  }
  return self;
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                      path:(NSString *)path
                                parameters:(NSDictionary *)parameters {
  if(![path isEqualToString:@"auth"] && self.accessToken && self.accessToken.length)
    path = [path stringByAppendingFormat:@"?token=%@", self.accessToken];
  return [super requestWithMethod:method path:path parameters:parameters];
}

#pragma mark - Authentication

- (void)authenticateWithUsername:(NSString *)username
                        password:(NSString *)password
                         success:(AFQiitaAuthenticationHandler)success
                         failure:(AFQiitaErrorHandler)failure {
  [self postPath:@"auth"
      parameters:@{ @"url_name": username, @"password": password }
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
           id json = [(AFQiitaRequestOperation *)operation responseJSON];
           if(
              [json isKindOfClass:[NSDictionary class]] &&
              [json[@"token"] isKindOfClass:[NSString class]]) {
             if(success) success();
           } else if(failure) {
             failure([NSError errorWithDomain:AFQiitaErrorDomain
                                         code:NSURLErrorBadServerResponse
                                     userInfo:nil]);
           }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           if(failure) failure(error);
         }];
}

#pragma mark - Rate Limit

- (void)rateLimitWithSuccess:(AFQiitaRateLimitHandler)success
                     failure:(AFQiitaErrorHandler)failure {
  [self getPath:@"rate_limit"
     parameters:@{}
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
          id json = [(AFQiitaRequestOperation *)operation responseJSON];
          if(
             [json isKindOfClass:[NSDictionary class]] &&
             json[@"remaining"] && json[@"limit"]) {
            if(success)
              success([json[@"remaining"] integerValue],
                      [json[@"limit"] integerValue]);
          } else if(failure) {
            failure([NSError errorWithDomain:AFQiitaErrorDomain
                                        code:NSURLErrorBadServerResponse
                                    userInfo:nil]);
          }
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if(failure) failure(error);
        }];
  
}

#pragma mark - User

- (void)currentUserWithSuccess:(AFQiitaResponseHandler)success
                       failure:(AFQiitaErrorHandler)failure {
  [self getPath:@"user"
     parameters:@{}
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
          if(success)
            success([(AFQiitaRequestOperation *)operation qiitaResponse]);
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if(failure)
            failure(error);
        }];
}

- (void)userWithUsername:(NSString *)username
                 success:(AFQiitaResponseHandler)success
                 failure:(AFQiitaErrorHandler)failure {
  [self getPath:[NSString stringWithFormat:@"users/%@", username]
     parameters:@{}
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
          if(success)
            success([(AFQiitaRequestOperation *)operation qiitaResponse]);
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if(failure)
            failure(error);
        }];
}

- (void)itemsWithUsername:(NSString *)username
                  success:(AFQiitaResponseHandler)success
                  failure:(AFQiitaErrorHandler)failure {
  [self getPath:[NSString stringWithFormat:@"users/%@/items", username]
     parameters:@{}
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
          if(success)
            success([(AFQiitaRequestOperation *)operation qiitaResponse]);
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if(failure)
            failure(error);
        }];
}

- (void)stockedItemsWithUsername:(NSString *)username
                         success:(AFQiitaResponseHandler)success
                         failure:(AFQiitaErrorHandler)failure {
  [self getPath:[NSString stringWithFormat:@"users/%@/stocks", username]
     parameters:@{}
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
          if(success)
            success([(AFQiitaRequestOperation *)operation qiitaResponse]);
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if(failure)
            failure(error);
        }];
}

#pragma mark - Tag

- (void)itemsWithTag:(NSString *)tag
             success:(AFQiitaResponseHandler)success
             failure:(AFQiitaErrorHandler)failure {
  [self getPath:[NSString stringWithFormat:@"tags/%@/items", tag]
     parameters:@{}
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
          if(success)
            success([(AFQiitaRequestOperation *)operation qiitaResponse]);
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if(failure)
            failure(error);
        }];
}

- (void)tagsWithSuccess:(AFQiitaResponseHandler)success
                failure:(AFQiitaErrorHandler)failure {
  [self getPath:@"tags"
     parameters:@{}
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
          if(success)
            success([(AFQiitaRequestOperation *)operation qiitaResponse]);
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if(failure)
            failure(error);
        }];
}

#pragma mark - Search


- (void)itemsWithSearchString:(NSString *)searchString
                      stocked:(BOOL)stocked
                      success:(AFQiitaResponseHandler)success
                      failure:(AFQiitaErrorHandler)failure {
  [self getPath:@"search"
     parameters:@{ @"q" : searchString, @"stocked" : @(stocked) }
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
          if(success)
            success([(AFQiitaRequestOperation *)operation qiitaResponse]);
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if(failure)
            failure(error);
        }];
}


- (void)itemsWithSearchString:(NSString *)searchString
                      success:(AFQiitaResponseHandler)success
                      failure:(AFQiitaErrorHandler)failure {
  [self getPath:@"search"
     parameters:@{ @"q" : searchString }
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
          if(success)
            success([(AFQiitaRequestOperation *)operation qiitaResponse]);
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if(failure)
            failure(error);
        }];
}

#pragma mark - Recent

- (void)recentItemsWithSuccess:(AFQiitaResponseHandler)success
                       failure:(AFQiitaErrorHandler)failure {
  [self getPath:@"items"
     parameters:@{}
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
          if(success)
            success([(AFQiitaRequestOperation *)operation qiitaResponse]);
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if(failure)
            failure(error);
        }];
}

#pragma mark - Stocked

- (void)stockedItemsWithSuccess:(AFQiitaResponseHandler)success
                        failure:(AFQiitaErrorHandler)failure {
  [self getPath:@"stocks"
     parameters:@{}
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
          if(success)
            success([(AFQiitaRequestOperation *)operation qiitaResponse]);
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if(failure)
            failure(error);
        }];
}

#pragma mark - CRUD Item

- (void)createItem:(AFQiitaItem *)item
           success:(AFQiitaResponseHandler)success
           failure:(AFQiitaErrorHandler)failure {
  [self postPath:@"items"
      parameters:[item parameterDictionaryForCreate]
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
           if(success)
             success([(AFQiitaRequestOperation *)operation qiitaResponse]);
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           if(failure)
             failure(error);
         }];
}

- (void)updateItem:(AFQiitaItem *)item
           success:(AFQiitaResponseHandler)success
           failure:(AFQiitaErrorHandler)failure {
  [self putPath:[NSString stringWithFormat:@"items/%@", item.uuid]
     parameters:[item parameterDictionaryForUpdate]
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
          if(success)
            success([(AFQiitaRequestOperation *)operation qiitaResponse]);
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if(failure)
            failure(error);
        }];
}

- (void)deleteItem:(AFQiitaItem *)item
           success:(AFQiitaResponseHandler)success
           failure:(AFQiitaErrorHandler)failure {
  [self deleteItemWithUUID:item.uuid success:success failure:failure];
}

- (void)deleteItemWithUUID:(NSString *)uuid
                   success:(AFQiitaResponseHandler)success
                   failure:(AFQiitaErrorHandler)failure {
  [self deletePath:[NSString stringWithFormat:@"items/%@", uuid]
        parameters:@{}
           success:^(AFHTTPRequestOperation *operation, id responseObject) {
             if(success)
               success([(AFQiitaRequestOperation *)operation qiitaResponse]);
           }
           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if(failure)
               failure(error);
           }];
}

- (void)itemWithUUID:(NSString *)uuid
             success:(AFQiitaResponseHandler)success
             failure:(AFQiitaErrorHandler)failure {
  [self getPath:[NSString stringWithFormat:@"items/%@", uuid]
     parameters:@{}
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
          if(success)
            success([(AFQiitaRequestOperation *)operation qiitaResponse]);
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if(failure)
            failure(error);
        }];
}

#pragma mark - Stock / Unstock

- (void)stockItem:(AFQiitaItem *)item
          success:(AFQiitaResponseHandler)success
          failure:(AFQiitaErrorHandler)failure {
  [self stockItemWithUUID:item.uuid success:success failure:failure];
}

- (void)stockItemWithUUID:(NSString *)uuid
                  success:(AFQiitaResponseHandler)success
                  failure:(AFQiitaErrorHandler)failure {
  [self putPath:[NSString stringWithFormat:@"items/%@/stock", uuid]
     parameters:@{}
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
          if(success)
            success([(AFQiitaRequestOperation *)operation qiitaResponse]);
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if(failure)
            failure(error);
        }];
}

- (void)unstockItem:(AFQiitaItem *)item
            success:(AFQiitaResponseHandler)success
            failure:(AFQiitaErrorHandler)failure {
  [self unstockItemWithUUID:item.uuid success:success failure:failure];
}

- (void)unstockItemWithUUID:(NSString *)uuid
                    success:(AFQiitaResponseHandler)success
                    failure:(AFQiitaErrorHandler)failure {
  [self deletePath:[NSString stringWithFormat:@"items/%@/unstock", uuid]
        parameters:@{}
           success:^(AFHTTPRequestOperation *operation, id responseObject) {
             if(success)
               success([(AFQiitaRequestOperation *)operation qiitaResponse]);
           }
           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if(failure)
               failure(error);
           }];
}


@end
