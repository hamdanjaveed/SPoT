//
//  ImageWithTagTableViewController.m
//  SPoT
//
//  Created by Hamdan Javeed on 2013-05-20.
//  Copyright (c) 2013 Glass Cube. All rights reserved.
//

#import "ImageWithTagTableViewController.h"

@interface ImageWithTagTableViewController ()

@end

@implementation ImageWithTagTableViewController

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // TODO
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

@end
