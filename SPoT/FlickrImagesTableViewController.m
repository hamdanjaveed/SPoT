//
//  FlickrImagesTableViewController.m
//  SPoT
//
//  Created by Hamdan Javeed on 2013-05-19.
//  Copyright (c) 2013 Glass Cube. All rights reserved.
//

#import "FlickrImagesTableViewController.h"
#import "FlickrFetcher.h"

@interface FlickrImagesTableViewController ()
@property (strong, nonatomic) NSMutableArray *uniqueTags;
@end

@implementation FlickrImagesTableViewController

- (NSMutableArray *)uniqueTags {
    if (!_uniqueTags) {
        _uniqueTags = [[NSMutableArray alloc] init];
        for (NSDictionary *dictionary in [FlickrFetcher stanfordPhotos]) {
            NSArray *tagArray = [[dictionary objectForKey:FLICKR_TAGS] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
            for (NSString *tag in tagArray) {
                if (![_uniqueTags containsObject:tag] && ![[FlickrImagesTableViewController invalidTags] containsObject:tag]) {
                    [_uniqueTags addObject:tag];
                }
            }
        }
    }
    return _uniqueTags;
}


+ (NSArray *)invalidTags {
    return @[@"cs193pspot", @"portrait", @"landscape"];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.uniqueTags count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Image Browse Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // TODO
}

@end
