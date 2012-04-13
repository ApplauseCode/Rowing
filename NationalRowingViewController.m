//
//  NationalViewController.m
//  Rowing
//
//  Created by Jeffrey Rosenbluth on 4/12/12.
//  Copyright (c) 2012 Applause Code. All rights reserved.
//

#import "NationalRowingViewController.h"

@interface NationalRowingViewController ()

@end

@implementation NationalRowingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[self tabBarItem] setTitle:@"NRF"];
        [[self tabBarItem] setImage:[UIImage imageNamed:@"glyphicons_266_flag"]];
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
