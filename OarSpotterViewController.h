//
//  OarSpotterViewController.h
//  Rowing
//
//  Created by Jeffrey Rosenbluth on 4/10/12.
//  Copyright (c) 2012 Applause Code. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OarSpotterViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *laneNames;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *spmLabels;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *timeLabels;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (strong, nonatomic) UIBarButtonItem *resetButton;
@property (strong, nonatomic) UIBarButtonItem *startButton;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItems;
@property (weak, nonatomic) IBOutlet UINavigationItem *barTitle;

- (IBAction)spmButton:(id)sender;
- (void)startAll:(id)sender;
- (void)resetAll:(id)sender;
@end
