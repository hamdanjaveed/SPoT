//
//  ImageViewController.m
//  Image Scroller
//
//  Created by Hamdan Javeed on 2013-05-18.
//  Copyright (c) 2013 Glass Cube. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController () <UIScrollViewDelegate>
// the scroll view in which the image is displayed
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
// the image view that holds the image
@property (strong, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end

@implementation ImageViewController

// ---------- Instance Methods ---------- //

// resets the image and scroll views
- (void)resetImage {
    if (self.scrollView) {
        // reset the scroll and image views
        self.scrollView.contentSize = CGSizeZero;
        self.imageView.image = nil;
        
        [self.activityIndicator startAnimating];
        
        // get the image and initialize the image view
        dispatch_queue_t getImageQ = dispatch_queue_create("load image", NULL);
        dispatch_async(getImageQ, ^{
            NSURL *url = self.imageURL;
            NSData *imageData = [NSData dataWithContentsOfURL:self.imageURL];
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage *image = [UIImage imageWithData:imageData];
                if (image && self.imageURL == url) {
                    // setup the image view
                    self.imageView.image = image;
                    self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
                    
                    // set the scroll view's content size to match the image
                    self.scrollView.contentSize = image.size;
                    
                    [self.activityIndicator stopAnimating];
                }
            });
        });
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    double horizontalRatio = self.scrollView.bounds.size.width / self.imageView.image.size.width;
    double verticalRatio = self.scrollView.bounds.size.height / self.imageView.image.size.height;
    self.scrollView.zoomScale = MAX(horizontalRatio, verticalRatio);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // add the image view to the scroll view
    [self.scrollView addSubview:self.imageView];
    
    // when the view loads, reset the image
    [self resetImage];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    // we want to zoom into the image view
    return self.imageView;
}

// ---------- Getters and Setters ---------- //

- (UIImageView *)imageView {
    // if the _imageView has not been initialized
    if (!_imageView) {
        // initialize it with a frame of CGRectZero, since we do not know
        // how big the image that it will hold is yet
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _imageView;
}

- (void)setImageURL:(NSURL *)imageURL {
    _imageURL = imageURL;
    
    // whenever the image URL is changed, reset the image
    [self resetImage];
}

- (void)setScrollView:(UIScrollView *)scrollView {
    _scrollView = scrollView;
    
    // set the minumum and maximum zoom scale
    _scrollView.minimumZoomScale = 0.5;
    _scrollView.maximumZoomScale = 2.0;
    
    // set ourselves as the delegate
    _scrollView.delegate = self;
}

@end
