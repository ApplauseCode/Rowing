//
//  OarSpotterViecControllerViewController.m
//  Rowing
//
//  Created by Jeffrey Rosenbluth on 4/10/12.
//  Copyright (c) 2012 Applause Code. All rights reserved.
//

#import "OarSpotterViewController.h"
#import "Lane.h"
#import "TimeParse.h"

@interface OarSpotterViewController ()

@property (nonatomic,strong) Lane *lane_1;
@property (nonatomic, strong) NSTimer *stopWatch;
@property (nonatomic) BOOL timerOn_1;

- (void)stopWatchTick:(NSTimer *)aTimer;
- (void)timerTap:(UITapGestureRecognizer *)gr;
- (void)resetTimer:(UILongPressGestureRecognizer *)gr;

@end

@implementation OarSpotterViewController
@synthesize spmLabel_1;
@synthesize timerLabel_1;
@synthesize LaneName;
@synthesize timerOn_1;
@synthesize lane_1;
@synthesize stopWatch;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[self tabBarItem] setTitle:@"Strokes"];
        [[self tabBarItem] setImage:[UIImage imageNamed:@"glyphicons_025_binoculars"]];
        lane_1 = [[Lane alloc] init];
        timerOn_1 = NO;
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        stopWatch = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(stopWatchTick:) userInfo:nil repeats:YES];
        [runLoop addTimer:stopWatch forMode:NSRunLoopCommonModes];
        [runLoop addTimer:stopWatch forMode:UITrackingRunLoopMode];;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UILongPressGestureRecognizer *timerLongPress_1 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(resetTimer:)];
    UITapGestureRecognizer *timerTap_1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(timerTap:)];
    [timerLabel_1 addGestureRecognizer:timerTap_1];
    [timerLabel_1 addGestureRecognizer:timerLongPress_1];
    [LaneName setDelegate:self];
}

- (void)viewDidUnload
{
    [self setTimerLabel_1:nil];
    [self setLaneName:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)spmButton_1:(id)sender {
    double strokes = [lane_1 spm:[NSDate date]];
    [spmLabel_1 setText:[NSString stringWithFormat:@"%3.1f",strokes]];
}

- (IBAction)startAll:(id)sender {
}

- (void)stopWatchTick:(NSTimer *)aTimer
{
    double et;
    if (timerOn_1) {
        et = [lane_1 updateElapsedTime:[NSDate date]];
        [timerLabel_1 setText:[TimeParse toString:et]];
    }
}

- (void)resetTimer:(UILongPressGestureRecognizer *)gr
{
    [lane_1 resetStartTime];
    [timerLabel_1 setText:[TimeParse toString:0.0]];
    self.timerOn_1 = NO;
}

- (void)timerTap:(UITapGestureRecognizer *)gr {
    if (!timerOn_1) {
        lane_1.startTime = [NSDate date];
        timerOn_1 = YES;
    }
    else 
        timerOn_1 = NO;
}
     
@end
