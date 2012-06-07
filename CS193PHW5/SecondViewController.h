//
//  SecondViewController.h
//  CS193PHW5
//
//  Created by Doug Mason on 6/5/12.
//  Copyright (c) 2012 Two Ducks Development, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain) NSArray* recents;
@property(nonatomic,retain) IBOutlet UITableView* table;
@end
