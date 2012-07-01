//
//  TapViewViewController.m
//  Rowing
//
//  Created by Reed Rosenbluth on 4/8/12.
//  Copyright (c) 2012 Applause Code. All rights reserved.
//

#import "TapViewViewController.h"

@interface TapViewViewController ()

@end

@implementation TapViewViewController
@synthesize button1;
@synthesize button2;
@synthesize button3;
@synthesize button4;
@synthesize button5;
@synthesize button6;
@synthesize currentDate;
@synthesize previousDate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setButton1:nil];
    [self setButton2:nil];
    [self setButton3:nil];
    [self setButton4:nil];
    [self setButton5:nil];
    [self setButton6:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)buttonTouched:(id)sender {
    if (sender == button1) {
        NSDate *now = [NSDate date];
        double dif = -60 / [previousDate timeIntervalSinceDate:now];
        NSString *difString = [NSString stringWithFormat:@"%3.1f", dif];
        [button1 setTitle:difString forState:UIControlStateNormal];
        previousDate = now;
    }
    
    if (sender == button2) {
        NSDate *now = [NSDate date];
        double dif = -[previousDate timeIntervalSinceDate:now];
        NSString *difString = [NSString stringWithFormat:@"%0.2f", dif];
        [button2 setTitle:difString forState:UIControlStateNormal];
        previousDate = now;
    }
    
    if (sender == button3) {
        NSDate *now = [NSDate date];
        double dif = -[previousDate timeIntervalSinceDate:now];
        NSString *difString = [NSString stringWithFormat:@"%0.2f", dif];
        [button3 setTitle:difString forState:UIControlStateNormal];
        previousDate = now;
    }
    
    if (sender == button4) {
        NSDate *now = [NSDate date];
        double dif = -[previousDate timeIntervalSinceDate:now];
        NSString *difString = [NSString stringWithFormat:@"%0.2f", dif];
        [button4 setTitle:difString forState:UIControlStateNormal];
        previousDate = now;
    }
    
    if (sender == button5) {
        NSDate *now = [NSDate date];
        double dif = -[previousDate timeIntervalSinceDate:now];
        NSString *difString = [NSString stringWithFormat:@"%0.2f", dif];
        [button5 setTitle:difString forState:UIControlStateNormal];
        previousDate = now;
    }
    
    if (sender == button6) {
        NSDate *now = [NSDate date];
        double dif = -[previousDate timeIntervalSinceDate:now];
        NSString *difString = [NSString stringWithFormat:@"%0.2f", dif];
        [button6 setTitle:difString forState:UIControlStateNormal];
        previousDate = now;
    }
}

@end
