//
//  LSNewsCategory.h
//  NewYorkTimesReader
//
//  Created by Artem Kravchenko on 5/16/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSNewsCategory : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSString *imageName;

@end
