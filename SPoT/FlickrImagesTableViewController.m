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
    }
    return _uniqueTags;
}

- (void)viewDidLoad {
    NSArray *pics = [[NSArray alloc] initWithArray:[FlickrFetcher stanfordPhotos]];
    for (NSDictionary *dictionary in pics) {
        NSString *tags = [dictionary objectForKey:FLICKR_TAGS];
        NSArray *tagArray = [tags componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
        for (NSString *tag in tagArray) {
            if (![self.uniqueTags containsObject:tag] && ![[FlickrImagesTableViewController invalidTags] containsObject:tag]) {
                [self.uniqueTags addObject:tag];
            }
        }
    }
    NSLog(@"%@", self.uniqueTags);
}

+ (NSArray *)invalidTags {
    return @[@"cs193pspot", @"portrait", @"landscape"];
}

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // TODO
}

@end
