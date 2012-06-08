//
//  PictureViewController.m
//  CS193PHW5
//
//  Created by Doug Mason on 6/6/12.
//  Copyright (c) 2012 Two Ducks Development, LLC. All rights reserved.
//

#import "PictureViewController.h"
#import "FlickrFetcher.h"
@interface PictureViewController ()

@end

@implementation PictureViewController
@synthesize  imageView;
@synthesize place;
@synthesize toScroll;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%@",self.place);
    [self.imageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[FlickrFetcher urlForPhoto:self.place format:FlickrPhotoFormatLarge]]]];
    [imageView sizeToFit];
    [toScroll setContentSize:imageView.image.size];
    [toScroll setDelegate:self];
    [toScroll setMaximumZoomScale:1];
    [toScroll setMinimumZoomScale:.025];
    toScroll.clipsToBounds = YES;
    [toScroll setScrollEnabled:YES];
    [toScroll addSubview:imageView];
    [toScroll setZoomScale:1];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imageView;
}

@end
