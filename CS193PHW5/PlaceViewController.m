//
//  PlaceViewController.m
//  CS193PHW5
//
//  Created by Doug Mason on 6/6/12.
//  Copyright (c) 2012 Two Ducks Development, LLC. All rights reserved.
//

#import "PlaceViewController.h"
#import "FlickrFetcher.h"
#import "PictureViewController.h"
#import "AppDelegate.h"
@interface PlaceViewController ()

@end

@implementation PlaceViewController
@synthesize place;
@synthesize pictures;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return pictures.count;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.pictures = [FlickrFetcher photosInPlace:self.place maxResults:50];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    [self performSegueWithIdentifier:@"viewPicture" sender:[self.pictures objectAtIndex: indexPath.row ]];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"picCell"];
    cell.textLabel.text = [[pictures objectAtIndex:indexPath.row] valueForKey:@"title"];
    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[FlickrFetcher urlForPhoto:[pictures objectAtIndex:indexPath.row] format:FlickrPhotoFormatThumbnail]]];
    return cell;
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"viewPicture"])
    {
        [((PictureViewController*)segue.destinationViewController) setPlace:sender];
        [[segue.destinationViewController navigationItem] setTitle:[sender valueForKey:FLICKR_PHOTO_TITLE]];
    }
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray* array = [[defaults arrayForKey:@"recents"] mutableCopy];
    if(array.count == 0){
        array = [NSMutableArray array];
    }
    [array addObject:sender];
    [defaults setObject:array forKey:@"recents"];
    [defaults synchronize];
}
@end
