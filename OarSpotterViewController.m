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
#import "LongPressGestureRecognizerWithTag.h"
#import "TapGestureRecognizerWithTag.h"

#define LANES 6

@interface OarSpotterViewController ()

@property (nonatomic,strong) NSMutableArray *lanes;
@property (nonatomic, strong) NSTimer *stopWatch;
@property (nonatomic, strong) NSMutableArray *timersOn;

- (void)stopWatchTick:(NSTimer *)aTimer;
- (void)timerTap:(TapGestureRecognizerWithTag *)gr;
- (void)resetTimer:(LongPressGestureRecognizerWithTag *)gr;
- (void) animateTextField: (UITextField*) textField up: (BOOL) up;

@end

@implementation OarSpotterViewController
@synthesize laneNames;
@synthesize spmLabels;
@synthesize timeLabels;
@synthesize navBar;
@synthesize timersOn;
@synthesize lanes;
@synthesize stopWatch;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    Lane *lane;
    lanes = [[NSMutableArray alloc] initWithCapacity:LANES];
    timersOn = [[NSMutableArray alloc] initWithCapacity:LANES];
    if (self) {
        [[self tabBarItem] setTitle:@"Strokes"];
        [[self tabBarItem] setImage:[UIImage imageNamed:@"glyphicons_025_binoculars"]];
        for (int i = 0; i < LANES; i++) {
            lane = [[Lane alloc] init];
            [lanes addObject:lane];
            NSNumber *off = [NSNumber numberWithBool:NO];
            [timersOn addObject:off];
        }
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
    for (int i = 0; i < LANES; i++) {
        LongPressGestureRecognizerWithTag *timerLongPress = [[LongPressGestureRecognizerWithTag alloc] initWithTarget:self action:@selector(resetTimer:)];
        [timerLongPress setTag:i];
        TapGestureRecognizerWithTag *timeTap = [[TapGestureRecognizerWithTag alloc] initWithTarget:self action:@selector(timerTap:)];
        [timeTap setTag:i];
        [[self.timeLabels  objectAtIndex:i] addGestureRecognizer:timeTap];
        [[self.timeLabels objectAtIndex:i] addGestureRecognizer:timerLongPress];
        [[laneNames objectAtIndex:i] setDelegate:self];
    }
}

- (void)viewDidUnload
{
    [self setSpmLabels:nil];
    [self setTimeLabels:nil];
    [self setLaneNames:nil];
    [self setNavBar:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{   
    int yDelta = - 167;
    if (textField.tag<4) return;
    yDelta = (up ? yDelta : -yDelta);
    [UIView animateWithDuration:0.25 animations:^{
        self.view.frame = CGRectOffset(self.view.frame, 0, yDelta);
//        navBar.frame = CGRectOffset(navBar.frame, 0, -yDelta);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)spmButton:(UIButton *)sender {
    double strokes = [[lanes objectAtIndex:sender.tag] spm:[NSDate date]];
    [[spmLabels objectAtIndex:sender.tag] setText:[NSString stringWithFormat:@"%3.1f",strokes]];
}

- (IBAction)startAll:(id)sender {
    for (int i = 0; i < LANES; i++) {
        [[lanes objectAtIndex:i] setStartTime:[NSDate date]];
        [timersOn replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:YES]];
    }
}

- (void)stopWatchTick:(NSTimer *)aTimer
{
    double et;
    for (int i = 0; i < LANES; i++) {
        if ([[timersOn objectAtIndex:i] boolValue]) {
            et = [[lanes objectAtIndex:i] updateElapsedTime:[NSDate date]];
            [[timeLabels objectAtIndex:i] setText:[TimeParse toString:et]];
        }
    }
}

- (void)resetTimer:(LongPressGestureRecognizerWithTag *)gr
{
    int tag = gr.tag;
    [[self.timeLabels objectAtIndex:tag] setText:[TimeParse toString:0.0]];
    [self.timersOn replaceObjectAtIndex:tag withObject:[NSNumber numberWithBool:NO]]; 
    [[self.lanes objectAtIndex:tag] resetStartTime];
}

- (void)timerTap:(TapGestureRecognizerWithTag *)gr {
    int tag = gr.tag;
    if (![[timersOn objectAtIndex:tag] boolValue]) {
        [[lanes objectAtIndex:tag] setStartTime:[NSDate date]];
        [timersOn replaceObjectAtIndex:tag withObject:[NSNumber numberWithBool:YES]];
    }
    else {
        [timersOn replaceObjectAtIndex:tag withObject:[NSNumber numberWithBool:NO]];
    }
}
     
@end
