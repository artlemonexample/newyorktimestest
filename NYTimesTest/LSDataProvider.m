//
//  LSDataProvider.m
//  NewYorkTimesReader
//
//  Created by Artem Kravchenko on 5/17/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import "LSDataProvider.h"

#import <AFNetworking/AFImageDownloader.h>
#import <AFNetworking/AFNetworking.h>
#import <Ono/Ono.h>

#import "LSNewsItem.h"

NSString * const kBaseURL   = @"http://rss.nytimes.com/services/xml/rss/nyt/";

@implementation LSDataProvider

+ (instancetype)sharedInstance {
    static LSDataProvider *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [LSDataProvider new];
    });
    return instance;
}

- (NSURL*)urlFromLink:(NSString*)link {
    NSURL *result = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kBaseURL, link]];
    return result;
}

- (void)loadListOfNews:(NSString*)link completion:(void (^)(NSArray*))completion {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[self urlFromLink:link]];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (completion) {
            completion([self newsArrayFromNYT:filePath]);
        }
    }];
    [downloadTask resume];
}


- (NSArray*)newsArrayFromNYT:(NSURL*)filePath {
    NSError *error = nil;
    NSMutableArray *result = [NSMutableArray array];
    ONOXMLDocument *document = [ONOXMLDocument XMLDocumentWithData:[NSData dataWithContentsOfURL:filePath] error:&error];
    ONOXMLElement *channel = [document.rootElement firstChildWithTag:@"channel"];
    for (ONOXMLElement *element in channel.children) {
        if ([element.tag isEqualToString:@"item"]) {
            LSNewsItem *newsItem = [LSNewsItem new];
            newsItem.title =  [element firstChildWithTag:@"title"].stringValue;
            newsItem.descr = [element firstChildWithTag:@"description"].stringValue;
            newsItem.creator = [element firstChildWithTag:@"creator"].stringValue;
            newsItem.link = [element firstChildWithTag:@"link"].stringValue;
            ONOXMLElement *url = [element firstChildWithTag:@"content"];
            newsItem.imageLink = url.attributes[@"url"];
            [result addObject:newsItem];
        }
    }
    return [result copy];
}

- (void)loadImage:(NSString*)link completion:(void(^)(UIImage*))completion {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:link]];
    [[AFImageDownloader defaultInstance] downloadImageForURLRequest:request success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull responseObject) {
        if (completion) {
            completion(responseObject);
        }
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        
    }];
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:link]];
//    
//    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
//        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
//        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
//    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
//        if (completion) {
//            completion([UIImage imageWithData:[NSData dataWithContentsOfURL:filePath]]);
//        }
//    }];
//    [downloadTask resume];
}

@end
