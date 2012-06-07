//
//  SecondViewController.m
//  CS193PHW5
//
//  Created by Doug Mason on 6/5/12.
//  Copyright (c) 2012 Two Ducks Development, LLC. All rights reserved.
//

#import "SecondViewController.h"
#import "PictureViewController.h"
#import "FlickrFetcher.h"
#import "AppDelegate.h"
@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize table;
@synthesize recents;
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    self.recents = [defaults arrayForKey:@"recents"];
//    self.table = (UITableView*)self.view;
    
    [table reloadData];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"recentCell"];
    cell.imageView.image = [UIImage imageWithData:[FlickrFetcher imageDataForPhotoWithFlickrInfo:[recents objectAtIndex:indexPath.row] format:FlickrFetcherPhotoFormatThumbnail]];
    return cell;
    cell.textLabel.text = [[recents objectAtIndex:indexPath.row] valueForKey:@"title"];
}
-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return recents.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"recentPicture" sender:[recents objectAtIndex:indexPath.row]];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"recentPicture"]) {
        [segue.destinationViewController setPlace:sender];
    }
}
@end
