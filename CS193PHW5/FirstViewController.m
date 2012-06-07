//
//  FirstViewController.m
//  CS193PHW5
//
//  Created by Doug Mason on 6/5/12.
//  Copyright (c) 2012 Two Ducks Development, LLC. All rights reserved.
//

#import "FirstViewController.h"
#import "FlickrFetcher.h"
#import "PlaceViewController.h"
@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize placesArray;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.placesArray = [FlickrFetcher topPlaces];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    int position = indexPath.row;
    NSString* toSplit = (NSString*)([(NSDictionary*)[placesArray objectAtIndex:position] objectForKey:@"_content"]);
    NSScanner* scan = [[NSScanner alloc] initWithString:toSplit];
//    [scan setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@","]];
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    @try {
        NSString* str;
        [scan scanUpToString:@", " intoString:&str];
        cell.textLabel.text = str;
        str = [toSplit substringFromIndex:[scan scanLocation]+2];
        cell.detailTextLabel.text =str ;
        NSLog(@"%@",[[placesArray objectAtIndex:indexPath.row] description]);
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[exception description]);
    }
    @finally {
        return cell;
    }
    NSLog(@"%@",[[placesArray objectAtIndex:position] description]);
    
    return cell;
}
-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return placesArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**Sweet, sweet hackery. 
    */
    [self performSegueWithIdentifier:@"viewPlace" sender: [[placesArray objectAtIndex:indexPath.row] valueForKey:@"place_id"]];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    /**Configuring our segue to our place view controller.
     */
    if([segue.identifier isEqual:@"viewPlace"])
    {
        [((PlaceViewController*)segue.destinationViewController) setPlace:sender];
        NSLog(@"%@",sender);
        
    }
}
@end
