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
@property (strong, nonatomic) NSArray *photos;
@property (strong, nonatomic) NSMutableArray *uniqueTags;
@end

@implementation FlickrImagesTableViewController

- (NSMutableArray *)uniqueTags {
    if (!_uniqueTags) {
        _uniqueTags = [[NSMutableArray alloc] init];
        for (NSDictionary *dictionary in self.photos) {
            NSArray *tagArray = [self getTagArrayForDictionary:dictionary];
            for (NSString *tag in tagArray) {
                if (![_uniqueTags containsObject:tag] && ![[FlickrImagesTableViewController invalidTags] containsObject:tag]) {
                    [_uniqueTags addObject:tag];
                }
            }
        }
    }
    return _uniqueTags;
}

- (NSArray *)getTagArrayForDictionary:(NSDictionary *)dictionary {
    return [[dictionary objectForKey:FLICKR_TAGS] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
}

- (NSArray *)photos {
    if (!_photos) {
        _photos = [FlickrFetcher stanfordPhotos];
    }
    return _photos;
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
    
    cell.textLabel.text = [self.uniqueTags[indexPath.row] capitalizedString];
    NSUInteger count = [self getNumberOfPhotosWithTag:self.uniqueTags[indexPath.row]];
    cell.detailTextLabel.text = (count > 1) ? [NSString stringWithFormat:@"%d photos", count] : [NSString stringWithFormat:@"%d photo", count];
    
    return cell;
}

- (NSUInteger) getNumberOfPhotosWithTag:(NSString *)tag {
    NSUInteger count = 0;
    for (NSDictionary *photo in self.photos) {
        NSArray *tagArray = [self getTagArrayForDictionary:photo];
        if ([tagArray containsObject:tag]) {
            count++;
        }
    }
    return count;
}

@end
