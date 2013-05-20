//
//  ImageWithTagTableViewController.m
//  SPoT
//
//  Created by Hamdan Javeed on 2013-05-20.
//  Copyright (c) 2013 Glass Cube. All rights reserved.
//

#import "ImageWithTagTableViewController.h"
#import "FlickrFetcher.h"

@interface ImageWithTagTableViewController ()

@end

@implementation ImageWithTagTableViewController

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.photos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Image With Tag Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [[self.photos[indexPath.row] objectForKey:FLICKR_PHOTO_TITLE] capitalizedString];
    cell.detailTextLabel.text = [[self.photos[indexPath.row] valueForKeyPath:FLICKR_PHOTO_DESCRIPTION] capitalizedString];
    
    return cell;
}

@end
