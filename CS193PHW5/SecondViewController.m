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
    if ([[defaults arrayForKey:@"recents"] count] > 0) {
        NSSortDescriptor* descriptor = [NSSortDescriptor sortDescriptorWithKey:FLICKR_PHOTO_ID ascending:NO];
        NSArray* sort = [NSArray arrayWithObject:descriptor];
        self.recents = [[[defaults arrayForKey:@"recents"] copy] sortedArrayUsingDescriptors:sort];
    }
    else{
        self.recents = [[NSArray alloc] init ];
    }
    
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
    UITableViewCell* cell = [table dequeueReusableCellWithIdentifier:@"recentCell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"recentCell"];
    }
    NSDictionary* picInfo = (NSDictionary*)[recents objectAtIndex:indexPath.row];
    NSString* label,*subtitle;
    if([((NSString*)[picInfo valueForKey:FLICKR_PHOTO_TITLE]) length] > 0)
    {
        label =(NSString*)[picInfo valueForKey:FLICKR_PHOTO_TITLE];
        subtitle =(NSString*)[picInfo valueForKey:FLICKR_PHOTO_OWNER];
    }
    else if([((NSString*)[picInfo valueForKey:FLICKR_PHOTO_DESCRIPTION ]) length] > 0)
    {
        label = (NSString*)[picInfo valueForKey:FLICKR_PHOTO_DESCRIPTION];
        subtitle = (NSString*)[picInfo valueForKey:FLICKR_PHOTO_OWNER];
    }
    else {
        label = @"Unknown";
        subtitle = @"";
    }

    [cell.textLabel setText:label];
    [cell.detailTextLabel setText:subtitle];
    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[FlickrFetcher urlForPhoto:picInfo format:FlickrPhotoFormatThumbnail]]];
    return cell;

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
        [[segue.destinationViewController navigationItem] setTitle:[sender valueForKey:FLICKR_PHOTO_TITLE]];
    }
}
@end
