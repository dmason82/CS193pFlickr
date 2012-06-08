//
//  PictureViewController.h
//  CS193PHW5
//
//  Created by Doug Mason on 6/6/12.
//  Copyright (c) 2012 Two Ducks Development, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureViewController : UIViewController <UIScrollViewDelegate>
@property(nonatomic,retain) NSDictionary* place;
@property(nonatomic,retain) IBOutlet UIImageView* imageView;
@property(nonatomic,retain) IBOutlet UIScrollView* toScroll;
@end
