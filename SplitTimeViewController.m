//
//  SplitTimeViewController.m
//  Rowing
//
//  Created by Jeffrey Rosenbluth on 12/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SplitTimeViewController.h"
#import "InfoViewController.h"
#import "TimeParse.h"

@interface SplitTimeViewController ()
@property (nonatomic, assign) double splitSeconds;
@property (nonatomic, assign) double totalSeconds;
@property (nonatomic, assign) double distance;
@property (nonatomic, assign) CGFloat yBottom;
@property (nonatomic, weak) NSArray *bottom;
//@property (nonatomic, strong) CABasicAnimation *mover;


- (void)calc;
- (void)setControlsToDefaults;

@end


@implementation SplitTimeViewController

@synthesize splitStep;
@synthesize distStep;
@synthesize timeStep;
@synthesize distField;
@synthesize splitField;
@synthesize timeField;
@synthesize background;
@synthesize splitButton;
@synthesize distButton;
@synthesize timeButton;
@synthesize enter;
@synthesize splitControls;
@synthesize distControls;
@synthesize timeControls;
@synthesize splitSeconds;
@synthesize totalSeconds;
@synthesize distance;
@synthesize yBottom;
@synthesize bottom;
@synthesize nibView;
//@synthesize mover;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [self init];
}

- (id)init        
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        [[self tabBarItem] setTitle:@"Split"];
        [[self tabBarItem] setImage:[UIImage imageNamed:@"glyphicons_261_buoy"]];
        splitSeconds = 100.0;
        distance = 2000.0;
        totalSeconds = 400.0;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
//    [[self navigationItem] setTitle:@"Port Rowing"];
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeInfoLight];
//    [button addTarget:self action:@selector(about:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *infoItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//    [[self navigationItem] setLeftBarButtonItem:infoItem];
//    UIBarButtonItem *help = [[UIBarButtonItem alloc] initWithTitle:@"Help" style:UIBarButtonItemStylePlain target:self action:@selector(help:)];     
//    [[self navigationItem] setRightBarButtonItem:help];
    [timeButton setSelected:YES];
    [self setYBottom:[timeField frame].origin.y];
    [self setBottom:timeControls];
//    mover = [CABasicAnimation animationWithKeyPath:@"position"];
//    [mover setDuration:120];
//    [mover setRepeatCount:HUGE_VALF];
//    [mover setTimingFunction:[CAMediaTimingFunction 
//                              functionWithName:kCAMediaTimingFunctionLinear]];
//    [mover setToValue:[NSValue valueWithCGPoint:CGPointMake(800, 208)]];
//    [[[self background] layer] addAnimation:mover forKey:@"SlowMove"];
//    [[NSNotificationCenter defaultCenter] addObserver: self
//                                             selector: @selector(handleWillEnterForeground:) 
//                                                 name: UIApplicationWillEnterForegroundNotification
//                                               object: nil];
}

- (void)viewDidUnload
{
    [self setSplitStep:nil];
    [self setDistStep:nil];
    [self setTimeStep:nil];
    [self setDistField:nil];
    [self setSplitField:nil];
    [self setTimeField:nil];
    [self setBackground:nil];
    [self setSplitButton:nil];
    [self setDistButton:nil];
    [self setTimeButton:nil];
    [self setEnter:nil];
    [self setSplitControls:nil];
    [self setDistControls:nil];
    [self setDistControls:nil];
    [self setTimeControls:nil];
//    [self setMover:nil];
    [super viewDidUnload];
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    CALayer *layer = [[self background] layer];
//    CFTimeInterval pausedTime = [layer timeOffset];
//    layer.speed = 1.0;
//    layer.timeOffset = 0.0;
//    layer.beginTime = 0.0;
//    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
//    layer.beginTime = timeSincePause;
//}

//-(void) handleWillEnterForeground:(id)sender
//{
//    [[[self background] layer] removeAllAnimations];
//    mover = [CABasicAnimation animationWithKeyPath:@"position"];
//    [mover setDuration:120];
//    [mover setRepeatCount:HUGE_VALF];
//    [mover setTimingFunction:[CAMediaTimingFunction 
//                              functionWithName:kCAMediaTimingFunctionLinear]];
//    [mover setToValue:[NSValue valueWithCGPoint:CGPointMake(800, 208)]];
//    [[[self background] layer] addAnimation:mover forKey:@"SlowMove"];
//}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == splitField) {
        splitSeconds =[TimeParse toSeconds:[textField text]];
        [[self splitStep] setValue:splitSeconds];
        [[self splitField] setText:[TimeParse toString:splitSeconds]];
    } else if (textField == timeField) {
        totalSeconds = [TimeParse toSeconds:[textField text]];
        [[self timeStep] setValue:totalSeconds];
        [[self timeField] setText:[TimeParse toString:totalSeconds]];
    } else if (textField == distField) {
        distance = [[textField text] doubleValue];
        [[self distStep] setValue:distance];
    }
    [self calc];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)setControlsToDefaults;
{
    [splitStep setEnabled:YES];
    [distStep setEnabled:YES];
    [timeStep setEnabled:YES];
    [splitField setEnabled:YES];
    [distField setEnabled:YES];
    [timeField setEnabled:YES];
    [splitButton setSelected:NO];
    [distButton setSelected:NO];
    [timeButton setSelected:NO];
}

- (void)calc
{
    int what = ([distButton isSelected]) ? 1 : 0;
    what = ([timeButton isSelected]) ? 2 : what;
    NSString *s;
    switch (what) {
        case 0:
            splitSeconds = (totalSeconds / distance) * 500.0;
            [[self splitStep] setValue:splitSeconds];
            [[self splitField] setText:[TimeParse toString:splitSeconds]];
            break;
        case 1:
            distance = (totalSeconds / splitSeconds) * 500.0;
            s = [NSString stringWithFormat:@"%5.0f", distance + 0.5];
            [[self distField] setText:s];
            [[self distStep] setValue:distance];
            break; 
        case 2:
            totalSeconds = (splitSeconds * distance) / 500.0;
            [[self timeStep] setValue:totalSeconds];
            [[self timeField] setText:[TimeParse toString:totalSeconds]];
            break;
        default:
            break;
    }
}

- (IBAction)splitCalc:(id)sender 
{
    CGFloat offset = yBottom - [splitField frame].origin.y;
    [UIView animateWithDuration:0.6 animations:^(void) {
        for (UIView *v in splitControls)
            [v setFrame:CGRectMake(v.frame.origin.x, v.frame.origin.y + offset, v.frame.size.width, v.frame.size.height)];
        for (UIView *v in bottom)
            [v setFrame:CGRectMake(v.frame.origin.x, v.frame.origin.y - offset, v.frame.size.width, v.frame.size.height)];
        
    }];
    [self setBottom:splitControls];
    [self setControlsToDefaults];
    [splitField setEnabled:NO];
    [splitStep setEnabled:NO];
    [sender setSelected:YES];
}

- (IBAction)distCalc:(id)sender 
{
    CGFloat offset = yBottom - [distField frame].origin.y;
    [UIView animateWithDuration:0.6 animations:^(void) {
        for (UIView *v in distControls)
            [v setFrame:CGRectMake(v.frame.origin.x, v.frame.origin.y + offset, v.frame.size.width, v.frame.size.height)];
        for (UIView *v in bottom)
            [v setFrame:CGRectMake(v.frame.origin.x, v.frame.origin.y - offset, v.frame.size.width, v.frame.size.height)];

    }];
    [self setBottom:distControls];
    [self setControlsToDefaults];
    [distField setEnabled:NO];
    [distStep setEnabled:NO];
    [sender setSelected:YES];
}

- (IBAction)timeCalc:(id)sender 
{
    CGFloat offset = yBottom - [timeField frame].origin.y;
    [UIView animateWithDuration:0.6 animations:^(void) {
        for (UIView *v in timeControls)
            [v setFrame:CGRectMake(v.frame.origin.x, v.frame.origin.y + offset, v.frame.size.width, v.frame.size.height)];
        for (UIView *v in bottom)
            [v setFrame:CGRectMake(v.frame.origin.x, v.frame.origin.y - offset, v.frame.size.width, v.frame.size.height)];
        
    }];
    [self setBottom:timeControls];
    [self setControlsToDefaults];
    [timeField setEnabled:NO];
    [timeStep setEnabled:NO];
    [sender setSelected:YES];
}

- (IBAction)splitStepChanged:(id)sender 
{
    splitSeconds = [[self splitStep] value];
    [[self splitField] setText:[TimeParse toString:splitSeconds]];
    [self calc];
}


- (IBAction)distStepChanged:(id)sender 
{
    distance = [[self distStep] value];
    NSString *s = [NSString stringWithFormat:@"%5.0f", distance];
    [[self distStep] setValue:distance];
    [[self distField] setText:s];
    [self calc];
}

- (IBAction)timeStepChanged:(id)sender 
{
    totalSeconds = [[self timeStep] value];
    [[self timeField] setText:[TimeParse toString:totalSeconds]];
    [self calc];
}

- (void)help:(id)sender
{
    UIView *helpView;
    [[NSBundle mainBundle] loadNibNamed:@"HelpView" owner:self options:nil];
    helpView = [self nibView];
    [[self view] addSubview:helpView];
    UIBarButtonItem *help = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(done:)];     
    [[self navigationItem] setRightBarButtonItem:help];
}

- (IBAction)done:(id)sender
{
    [nibView removeFromSuperview];
    UIBarButtonItem *help = [[UIBarButtonItem alloc] initWithTitle:@"Help" style:UIBarButtonItemStylePlain target:self action:@selector(help:)];     
    [[self navigationItem] setRightBarButtonItem:help];
}

- (IBAction)about:(id)sender 
{
    InfoViewController *ivc = [[InfoViewController alloc] init];
    UINavigationController *infoNav = [[UINavigationController alloc] initWithRootViewController:ivc];
    [[infoNav navigationBar] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                             [UIColor colorWithRed:93/255.0 green:140/255.0 blue:214/255.0 alpha:1.0],
                                                             UITextAttributeTextColor,
                                                             [UIFont fontWithName:@"Georgia-Bold" size:22.0], UITextAttributeFont,
                                                             nil]];
//    CALayer *layer = [[self background] layer];
//    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
//    layer.speed = 0.0;
//    layer.timeOffset = pausedTime;
    [[self navigationController] presentModalViewController:infoNav animated:YES];
}

@end
