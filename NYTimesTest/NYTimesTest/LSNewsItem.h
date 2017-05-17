//
//  LSNewsItem.h
//  NewYorkTimesReader
//
//  Created by Artem Kravchenko on 5/16/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LSNewsItem : NSObject

@property (nonatomic, strong) NSString *itemID;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *descr;
@property (nonatomic, strong) NSString *creator;
@property (nonatomic, strong) NSString *pubDate;
@property (nonatomic, strong) NSString *imageLink;

@property (nonatomic, strong) UIImage *image;

@end
