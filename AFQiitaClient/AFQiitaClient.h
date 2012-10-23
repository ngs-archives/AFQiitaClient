//
// AFQiitaClient.h
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
#import "AFHTTPClient.h"


@class AFQiitaResponse, AFQiitaItem;

typedef void (^AFQiitaAuthenticationHandler)(void);
typedef void (^AFQiitaErrorHandler)(NSError *error);
typedef void (^AFQiitaRateLimitHandler)(NSInteger remaining, NSInteger limit);
typedef void (^AFQiitaResponseHandler)(AFQiitaResponse *response);


@interface AFQiitaClient : AFHTTPClient

@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, readonly) BOOL isLoggedIn;

#pragma mark - Request alias

- (void)getURL:(NSURL *)URL
       success:(AFQiitaResponseHandler)success
       failure:(AFQiitaErrorHandler)failure;

#pragma mark - Authentication

- (void)authenticateWithUsername:(NSString *)username
                        password:(NSString *)password
                         success:(AFQiitaAuthenticationHandler)success
                         failure:(AFQiitaErrorHandler)failure;

#pragma mark - Rate Limit

- (void)rateLimitWithSuccess:(AFQiitaRateLimitHandler)success
                     failure:(AFQiitaErrorHandler)failure;

#pragma mark - User

- (void)currentUserWithSuccess:(AFQiitaResponseHandler)success
                       failure:(AFQiitaErrorHandler)failure;


- (void)userWithUsername:(NSString *)username
                 success:(AFQiitaResponseHandler)success
                 failure:(AFQiitaErrorHandler)failure;

- (void)myItemsWithSuccess:(AFQiitaResponseHandler)success
                   failure:(AFQiitaErrorHandler)failure;

- (void)itemsWithUsername:(NSString *)username
                  success:(AFQiitaResponseHandler)success
                  failure:(AFQiitaErrorHandler)failure;


- (void)stockedItemsWithUsername:(NSString *)username
                         success:(AFQiitaResponseHandler)success
                         failure:(AFQiitaErrorHandler)failure;


#pragma mark - Tag

- (void)itemsWithTag:(NSString *)tag
             success:(AFQiitaResponseHandler)success
             failure:(AFQiitaErrorHandler)failure;


- (void)tagsWithSuccess:(AFQiitaResponseHandler)success
                failure:(AFQiitaErrorHandler)failure;


#pragma mark - Search


- (void)itemsWithSearchString:(NSString *)searchString
                      stocked:(BOOL)stocked
                      success:(AFQiitaResponseHandler)success
                      failure:(AFQiitaErrorHandler)failure;



- (void)itemsWithSearchString:(NSString *)searchString
                      success:(AFQiitaResponseHandler)success
                      failure:(AFQiitaErrorHandler)failure;


#pragma mark - Recent

- (void)recentItemsWithSuccess:(AFQiitaResponseHandler)success
                       failure:(AFQiitaErrorHandler)failure;


#pragma mark - Stocked

- (void)stockedItemsWithSuccess:(AFQiitaResponseHandler)success
                        failure:(AFQiitaErrorHandler)failure;


#pragma mark - CRUD Item

- (void)createItem:(AFQiitaItem *)item
           success:(AFQiitaResponseHandler)success
           failure:(AFQiitaErrorHandler)failure;

- (void)createItem:(AFQiitaItem *)item
     postToTwitter:(BOOL)postToTwitter
        postToGist:(BOOL)postToGist
           success:(AFQiitaResponseHandler)success
           failure:(AFQiitaErrorHandler)failure;

- (void)updateItem:(AFQiitaItem *)item
           success:(AFQiitaResponseHandler)success
           failure:(AFQiitaErrorHandler)failure;


- (void)deleteItem:(AFQiitaItem *)item
           success:(AFQiitaResponseHandler)success
           failure:(AFQiitaErrorHandler)failure;

- (void)deleteItemWithUUID:(NSString *)uuid
                   success:(AFQiitaResponseHandler)success
                   failure:(AFQiitaErrorHandler)failure;


- (void)itemWithUUID:(NSString *)uuid
             success:(AFQiitaResponseHandler)success
             failure:(AFQiitaErrorHandler)failure;


#pragma mark - Stock / Unstock

- (void)stockItem:(AFQiitaItem *)item
          success:(AFQiitaResponseHandler)success
          failure:(AFQiitaErrorHandler)failure;

- (void)stockItemWithUUID:(NSString *)uuid
                  success:(AFQiitaResponseHandler)success
                  failure:(AFQiitaErrorHandler)failure;


- (void)unstockItem:(AFQiitaItem *)item
            success:(AFQiitaResponseHandler)success
            failure:(AFQiitaErrorHandler)failure;

- (void)unstockItemWithUUID:(NSString *)uuid
                    success:(AFQiitaResponseHandler)success
                    failure:(AFQiitaErrorHandler)failure;


@end
