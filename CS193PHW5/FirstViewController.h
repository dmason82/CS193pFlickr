///Users/bastardx/Dropbox/CS193PHW5/CS193PHW5/FirstViewController.m
//  FirstViewController.h
//  CS193PHW5
//
//  Created by Doug Mason on 6/5/12.
//  Copyright (c) 2012 Two Ducks Development, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain) NSArray* placesArray;
@end
