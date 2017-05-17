//
//  LSDataProvider.h
//  NewYorkTimesReader
//
//  Created by Artem Kravchenko on 5/17/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LSDataProvider : NSObject

+ (instancetype)sharedInstance;

- (NSURL*)urlFromLink:(NSString*)link;

- (void)loadImage:(NSString*)link completion:(void(^)(UIImage*))completion;
- (void)loadListOfNews:(NSString*)link completion:(void (^)(NSArray*))completion;

@end
