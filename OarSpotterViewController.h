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

- (IBAction)spmButton:(id)sender;
- (IBAction)startAll:(id)sender;

@end
