//
//  LSNewsListViewController.h
//  NYTimesTest
//
//  Created by Alex on 5/17/17.
//  Copyright © 2017 Sasha Haidar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSNewsCategory.h"

@interface LSNewsListViewController : UITableViewController

@property (nonatomic, strong) LSNewsCategory* chosenCategory;


@end
