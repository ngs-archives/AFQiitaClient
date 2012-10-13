# AFQiitaClient

**[Qiita API](http://qiita.com/docs) を Cocoa で操るクライアント**

[Qiita](http://qiita.com) は、プログラミングに関する Tips、ノウハウ、メモを簡単に記録 & 公開できるプログラマのための技術情報共有サービスです。

`AFQiitaClient` は `AFHTTPClient` サブクラスで、[AFNetworking](https://github.com/afnetworking/afnetworking) のソースコードと共に、プロジェクトに追加して使用します。

## 使い方

### 初期化
```objective-c
AFQiitaClient *client = [[AFQiitaClient alloc] init];
```

### 認証
```objective-c
[client authenticateWithUsername:@"ngs"
                        password:@"qwerty1234!?"
                        success:success:^ {
                          NSLog(@"Success");
                        }
                        failure:^(NSError *error) {
                          NSLog(@"Error: %@", error);
                        }];
```

### ページング
`AFQiitaResponse` には `firstURL`, `prevURL`, `nextURL`, `prevURL` という NSURL を返却するインスタンスメソッドがある。

```objective-c
[client tagsWithSuccess:^(AFQiitaResponse *response) {
                  if(response.nextURL) {
                    [client getURL:response.nextURL
                           success:^(AFQiitaResponse *response) { ... }
                           failure:^(NSError *error) { ... }];
                  } else {
                    NSLog(@"No more tags");
                  }
                }
                failure:^(NSError *error) {
                  NSLog(@"Error: %@", error);
                }];
```


### 残りリクエスト可能数とRate Limit取得
```objective-c
[client rateLimitWithSuccess:^(NSInteger remaining, NSInteger limit){
                        NSLog(@"Success: Limted to %d, %d remaining", limit, remaining);
                      }
                      failure:^(NSError *error) {
                        NSLog(@"Error: %@", error);
                      }];
```

### リクエストユーザーの情報取得
```objective-c
[client currentUserWithSuccess:^(AFQiitaResponse *response) {
                         AFQiitaUser *me = [response first];
                         NSLog(@"Success: Hello, my name is %@", me.name);
                       }
                       failure:^(NSError *error) {
                         NSLog(@"Error: %@", error);
                       }];
```

### 特定ユーザーの情報取得
```objective-c
[client userWithUsername:@"yaotti@github"
                 success:^(AFQiitaResponse *response) {
                   AFQiitaUser *user = [response first];
                   NSLog(@"Success: %@ has %d followers", user.name, user.followers);
                 }
                 failure:^(NSError *error) {
                   NSLog(@"Error: %@", error);
                 }];
```

### 特定ユーザーの投稿取得
```objective-c
[client itemsWithUsername:@"yaotti@github"
                  success:^(AFQiitaResponse *response) {
                    AFQiitaItem *item = nil;
                    while(item = response.next)
                      NSLog(@"Post: %@", item.title);
                  }
                  failure:^(NSError *error) {
                    NSLog(@"Error: %@", error);
                  }];
```

### 特定ユーザーのストックした投稿取得
```objective-c
[client stockedItemsWithUsername:@"yaotti@github"
                         success:^(AFQiitaResponse *response) {
                           AFQiitaItem *item = nil;
                           while(item = response.next)
                             NSLog(@"Post: %@", item.title);
                         }
                         failure:^(NSError *error) {
                           NSLog(@"Error: %@", error);
                         }];
```

### 特定タグの投稿取得
```objective-c
[client itemsWithTag:@"Rails"
             success:^(AFQiitaResponse *response) {
               AFQiitaItem *item = nil;
               while(item = response.next)
                 NSLog(@"Post: %@", item.title);
             }
             failure:^(NSError *error) {
               NSLog(@"Error: %@", error);
             }];
```

### タグ一覧取得
```objective-c
[client tagsWithSuccess:^(AFQiitaResponse *response) {
                  AFQiitaTag *tag = nil;
                  while(tag = response.next)
                    NSLog(@"Tag: %@", tag.name);
                }
                failure:^(NSError *error) {
                  NSLog(@"Error: %@", error);
                }];
```

### 検索結果取得
```objective-c
[client itemsWithSearchString:@"Hackathon"
                      stocked:NO
                      success:^(AFQiitaResponse *response) {
                        AFQiitaItem *item = nil;
                        while(item = response.next)
                          NSLog(@"Post: %@", item.title);
                      }
                      failure:^(NSError *error) {
                        NSLog(@"Error: %@", error);
                      }];
```

### 新着投稿の取得
```objective-c
[client recentItemsWithSuccess:^(AFQiitaResponse *response) {
                         AFQiitaItem *item = nil;
                         while(item = response.next)
                           NSLog(@"Post: %@", item.title);
                       }
                       failure:^(NSError *error) {
                         NSLog(@"Error: %@", error);
                       }];
```

### 自分のストックした投稿の取得
```objective-c
[client stockedItemsWithSuccess:^(AFQiitaResponse *response) {
                          AFQiitaItem *item = nil;
                          while(item = response.next)
                            NSLog(@"Post: %@", item.title);
                        }
                        failure:^(NSError *error) {
                          NSLog(@"Error: %@", error);
                        }];
```


### 投稿の実行
```objective-c
AFQiitaItem *item = [[AFQiitaItem alloc]
                      initWithTitle:@"テスト！"
                      body:@"[AFQiitaClient](http://github.com/ngs/AFQiitaClient) から投稿テスト"];

[item addTag:[AFQiitaTag tagWithName:@"iOS"
                            versions:@"5.1.1", @"6.0", nil]];

[item setTweet:YES]; // Posts URL to Twitter
[item setGist:YES];  // Share code blocks on Gist

[client createItem:item
           success:success:^(AFQiitaResponse *response) {
             AFQiitaItem *createdItem = [response first];
             NSLog(@"Success! UUID is %@", createdItem.uuid);
           }
           failure:^(NSError *error) {
             NSLog(@"Error: %@", error);
           }];
```

### 投稿の更新
```objective-c
AFQiitaItem *item = ...; // Received from API

[item setTitle:@"テスト！(追記アリ)"];
[item setBody:@"[AFQiitaClient](http://github.com/ngs/AFQiitaClient) から投稿テスト\n\n##追記 (2012/10/13)\n\n* 非公開にしてみた"];

[item removeTag:[item.tags objectAtIndex:2]];
[item addTag:[AFQiitaTag tagWithName:@"Rails"]];

[item publicize]; // 限定公開のものを public に変更のみ可能

[client updateItem:item
           success:success:^(AFQiitaResponse *response) {
             AFQiitaItem *updatedItem = [response first];
             NSLog(@"Success! Updated at %@", updatedItem.updatedAt);
           }
           failure:^(NSError *error) {
             NSLog(@"Error: %@", error);
           }];
```

### 投稿の削除
```objective-c
[client deleteItem:item // Alias for deleteItemWithUUID:(NSString *)uuid
           success:success:^(AFQiitaResponse *response) {
             NSLog(@"Successfully deleted");
           }
           failure:^(NSError *error) {
             NSLog(@"Error: %@", error);
           }];
```

### 特定の投稿取得
```objective-c
[client itemWithUUID:@"1a43e55e7209c8f3c565"
             success:success:^ {
             AFQiitaItem *item = [response first];
               NSLog(@"Success: Title is %@, posted by %@ at %@",
                 item.title, item.user.name, item.createdAt);
             }
             failure:^(NSError *error) {
               NSLog(@"Error: %@", error);
             }];
```

### 投稿のストック
```objective-c
[client stockItem:item // Alias for stockItemWithUUID:(NSString *)uuid
          success:success:^ {
            NSLog(@"Successfully stocked");
          }
          failure:^(NSError *error) {
            NSLog(@"Error: %@", error);
          }];
```

### 投稿のストック解除
```objective-c
[client unstockItem:item // Alias for unstockItemWithUUID:(NSString *)uuid
            success:success:^ {
              NSLog(@"Successfully unstocked");
            }
            failure:^(NSError *error) {
              NSLog(@"Error: %@", error);
            }];
```

----

## 連絡先

[Atsushi Nagase](http://ngs.io/about)

[@ngs](https://twitter.com/ngs)

## ライセンス
AFQiitaClient は MIT ライセンスで配布しています。 詳しくは LICENSE ファイルをご覧ください。


