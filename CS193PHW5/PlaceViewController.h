//
//  PlaceViewController.h
//  CS193PHW5
//
//  Created by Doug Mason on 6/6/12.
//  Copyright (c) 2012 Two Ducks Development, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceViewController : UITableViewController <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)NSString* place;
@property(nonatomic,retain)NSArray* pictures;
@end
