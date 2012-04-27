//
//  NationalRowingViewController.h
//  Rowing
//
//  Created by Jeffrey Rosenbluth on 4/12/12.
//  Copyright (c) 2012 Applause Code. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NationalRowingViewController : UIViewController <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *photoScroll;
@property (weak, nonatomic) IBOutlet UIPageControl *photoPageControl;

- (IBAction)pageControlValueChanged:(id)sender;

@end
