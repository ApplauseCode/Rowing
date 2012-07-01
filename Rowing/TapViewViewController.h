//
//  TapViewViewController.h
//  Rowing
//
//  Created by Reed Rosenbluth on 4/8/12.
//  Copyright (c) 2012 Applause Code. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TapViewViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *button1;
@property (strong, nonatomic) IBOutlet UIButton *button2;
@property (strong, nonatomic) IBOutlet UIButton *button3;
@property (strong, nonatomic) IBOutlet UIButton *button4;
@property (strong, nonatomic) IBOutlet UIButton *button5;
@property (strong, nonatomic) IBOutlet UIButton *button6;
@property (strong, nonatomic) NSDate *currentDate;
@property (strong, nonatomic) NSDate *previousDate;

- (IBAction)buttonTouched:(id)sender;

@end
