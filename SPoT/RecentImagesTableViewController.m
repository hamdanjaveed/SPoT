//
//  RecentImagesTableViewController.m
//  SPoT
//
//  Created by Hamdan Javeed on 2013-05-19.
//  Copyright (c) 2013 Glass Cube. All rights reserved.
//

#import "RecentImagesTableViewController.h"
#import "FlickrFetcher.h"
#import "ImageViewController.h"

@interface RecentImagesTableViewController ()
@property (strong, nonatomic) NSArray *photos;
@end

@implementation RecentImagesTableViewController

#define RECENT_PHOTOS @"recent photos array"

- (NSArray *)photos {
    if (!_photos) {
        _photos = [[NSUserDefaults standardUserDefaults] objectForKey:RECENT_PHOTOS];
    }
    return _photos;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.photos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Recent Image Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [self.photos[indexPath.row] objectForKey:FLICKR_PHOTO_TITLE];
    cell.detailTextLabel.text = [self.photos[indexPath.row] valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
    
    return cell;
}

- (void)viewWillAppear:(BOOL)animated {
    self.photos = nil;
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        UITableViewCell *cell = sender;
        if ([segue.identifier isEqualToString:@"Recent Show image"]) {
            ImageViewController *destination = segue.destinationViewController;
            NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
            NSDictionary *dictionary = self.photos[indexPath.row];
            destination.imageURL = [FlickrFetcher urlForPhoto:dictionary format:FlickrPhotoFormatLarge];
            destination.title = cell.textLabel.text;
        }
    }
}

@end
