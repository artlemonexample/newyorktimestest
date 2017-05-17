//
//  LSCategoriesViewController.m
//  NYTimesTest
//
//  Created by Retina on 17.05.17.
//  Copyright © 2017 Sasha Haidar. All rights reserved.
//

#import "LSCategoriesViewController.h"
#import "LSNewsCategory.h"
#import "LSNewsListViewController.h"

@interface LSCategoriesViewController ()

@property (nonatomic, strong) NSArray *categories;

@end

@implementation LSCategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categories.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Category_Cell" forIndexPath:indexPath];
    
    LSNewsCategory *category = self.categories[indexPath.row];
    cell.textLabel.text = category.title;
    cell.imageView.image = [UIImage imageNamed:category.imageName];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    LSNewsListViewController *destination = [segue destinationViewController];
    destination.chosenCategory = self.categories[[self.tableView indexPathForCell:sender].row];
}

- (NSArray *)categories {
    if (!_categories) {
        NSMutableArray *array = [NSMutableArray array];
        LSNewsCategory *category = [LSNewsCategory new];
        category.imageName = @"world.png";
        category.title = @"World";
        category.link = @"World.xml";
        [array addObject:category];
        category = [LSNewsCategory new];
        category.imageName = @"business.jpg";
        category.title = @"Business";
        category.link = @"Business.xml";
        [array addObject:category];
        category = [LSNewsCategory new];
        category.imageName = @"technology.png";
        category.title = @"Technology";
        category.link = @"Technology.xml";
        [array addObject:category];
        category = [LSNewsCategory new];
        category.imageName = @"jobmarket.jpeg";
        category.title = @"Job Market";
        category.link = @"JobMarket.xml";
        [array addObject:category];
        category = [LSNewsCategory new];
        category.imageName = @"travel.jpg";
        category.title = @"Travel";
        category.link = @"Travel.xml";
        [array addObject:category];
        _categories = [array copy];
    }
    return _categories;
}

@end
