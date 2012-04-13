//
//  Lane.m
//  Rowing
//
//  Created by Reed Rosenbluth on 4/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Lane.h"
#define NUMBER_OF_TAPS 4

@interface Lane ()
@property NSMutableArray *times;
@property (nonatomic) double elapsedTime;
@end

@implementation Lane
@synthesize  times;
@synthesize startTime;
@synthesize elapsedTime;

- (id)init 
{
    self = [super init];
    if (self) {
        times = [[NSMutableArray alloc] initWithCapacity:NUMBER_OF_TAPS];
        for (int i = 0; i < NUMBER_OF_TAPS; i++)
            [times addObject:[[NSDate date]  dateByAddingTimeInterval:i * 3]];
        elapsedTime = 0.0;
    }
    return self;
}

- (double)spm: (NSDate *)d
{
    double dif = 0.0;
    for (int i = 0; i < NUMBER_OF_TAPS - 1; i++)
         [times replaceObjectAtIndex:i withObject:[times objectAtIndex:i+1]];
    [times replaceObjectAtIndex:NUMBER_OF_TAPS - 1 withObject:d];
    for (int i = 0; i < NUMBER_OF_TAPS - 1; i++) {
        dif += 60 / ([[times objectAtIndex:i+1] timeIntervalSince1970] - [[times objectAtIndex:i] timeIntervalSince1970]);
    }
    return dif / (NUMBER_OF_TAPS - 1);
}

- (void)resetStartTime
{
    self.elapsedTime = 0.0;
    self.startTime = [NSDate date];
}

- (double)updateElapsedTime: (NSDate *)d
{
    elapsedTime += [d timeIntervalSince1970] - [startTime timeIntervalSince1970];
    self.startTime = d;
    return elapsedTime;
}

@end
