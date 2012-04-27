//
//  NationalViewController.m
//  Rowing
//
//  Created by Jeffrey Rosenbluth on 4/12/12.
//  Copyright (c) 2012 Applause Code. All rights reserved.
//

#import "NationalRowingViewController.h"

@interface NationalRowingViewController ()
@property int photoNum;
@end

@implementation NationalRowingViewController
@synthesize photoScroll;
@synthesize photoPageControl;
@synthesize photoNum;

const CGFloat kScrollObjHeight	= 199.0;
const CGFloat kScrollObjWidth	= 280.0;
const NSUInteger kNumImages		= 5;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[self tabBarItem] setTitle:@"Hart"];
        [[self tabBarItem] setImage:[UIImage imageNamed:@"glyphicons_012_heart"]];
    }
    return self;
}

- (void)layoutScrollImages
{
	UIImageView *view = nil;
	NSArray *subviews = [photoScroll subviews];
    
	// reposition all image subviews in a horizontal serial fashion
	CGFloat curXLoc = 0;
	for (view in subviews)
	{
		if ([view isKindOfClass:[UIImageView class]] && view.tag > 0)
		{
			CGRect frame = view.frame;
			frame.origin = CGPointMake(curXLoc, 0);
			view.frame = frame;
			curXLoc += (kScrollObjWidth);
		}
	}
	// set the content size so it can be scrollable
	[photoScroll setContentSize:CGSizeMake((kNumImages * kScrollObjWidth), [photoScroll bounds].size.height)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [photoScroll setBackgroundColor:[UIColor blackColor]];
	[photoScroll setCanCancelContentTouches:NO];
    [photoScroll setDelegate:self];
	photoScroll.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	photoScroll.clipsToBounds = YES;		
	photoScroll.scrollEnabled = YES;	
	photoScroll.pagingEnabled = YES;
	photoScroll.showsHorizontalScrollIndicator = NO;
	NSUInteger i;
	for (i = 1; i <= kNumImages; i++)
	{
		NSString *imageName = [NSString stringWithFormat:@"image%d.jpg", i];
		UIImage *image = [UIImage imageNamed:imageName];
		UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
		
		CGRect rect = imageView.frame;
		rect.size.height = kScrollObjHeight;
		rect.size.width = kScrollObjWidth;
		imageView.frame = rect;
		imageView.tag = i;
		[photoScroll addSubview:imageView];
	}
	self.photoNum = 0;
//  self.photoPageControl.defersCurrentPageDisplay = YES;
	[self layoutScrollImages];	// now place the photos in serial layout within the scrollview
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float x = scrollView.contentOffset.x;
    if (x < kScrollObjWidth)
        self.photoNum = 0;
    else if (x < 2 * kScrollObjWidth)
        self.photoNum = 1;
    else if (x < 3 * kScrollObjWidth)
        self.photoNum = 2;
    else if (x < 4 * kScrollObjWidth)
        self.photoNum = 3;
    else self.photoNum = 4;

    photoPageControl.currentPage = self.photoNum;
}

- (void)viewDidUnload
{
    [self setPhotoScroll:nil];
    [self setPhotoPageControl:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)pageControlValueChanged:(id)sender 
{
//    NSLog(@"%i",photoPageControl.currentPage);
}
@end
