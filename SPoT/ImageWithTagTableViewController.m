//
//  ImageWithTagTableViewController.m
//  SPoT
//
//  Created by Hamdan Javeed on 2013-05-20.
//  Copyright (c) 2013 Glass Cube. All rights reserved.
//

#import "ImageWithTagTableViewController.h"
#import "FlickrFetcher.h"
#import "ImageViewController.h"

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

#define RECENT_PHOTOS @"recent photos array"
#define MAX_RECENT_PHOTOS 20

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender {
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        UITableViewCell *cell = sender;
        if ([segue.identifier isEqualToString:@"Browse Show Image"]) {
            ImageViewController *destination = segue.destinationViewController;
            NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
            NSDictionary *dictionary = self.photos[indexPath.row];
            destination.imageURL = [FlickrFetcher urlForPhoto:dictionary format:FlickrPhotoFormatLarge];
            destination.title = cell.textLabel.text;
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSMutableArray *recentPhotos = [[defaults objectForKey:RECENT_PHOTOS] mutableCopy];
            if (!recentPhotos) {
                recentPhotos = [[NSMutableArray alloc] init];
            }
            if ([recentPhotos containsObject:dictionary]) {
                [recentPhotos removeObject:dictionary];
            }
            [recentPhotos insertObject:dictionary atIndex:0];
            if ([recentPhotos count] > MAX_RECENT_PHOTOS) {
                [recentPhotos removeLastObject];
            }
            [defaults setObject:[recentPhotos copy] forKey:RECENT_PHOTOS];
            [defaults synchronize];
        }
    }
}

@end
