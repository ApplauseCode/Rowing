//
//  OarSpotterViewController.h
//  Rowing
//
//  Created by Jeffrey Rosenbluth on 4/10/12.
//  Copyright (c) 2012 Applause Code. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OarSpotterViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *spmLabel_1;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel_1;
@property (weak, nonatomic) IBOutlet UITextField *LaneName;

- (IBAction)spmButton_1:(id)sender;
- (IBAction)startAll:(id)sender;

@end
