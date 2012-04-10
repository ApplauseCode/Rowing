//
//  SPM.m
//  Rowing
//
//  Created by Reed Rosenbluth on 4/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SPM.h"
#define NUMBER_OF_TAPS 4

@interface SPM ()
@property NSMutableArray *times;
@end

@implementation SPM
@synthesize  times;

- (id)init 
{
    self = [super init];
    if (self) {
        times = [[NSMutableArray alloc] initWithCapacity:NUMBER_OF_TAPS];
        for (int i = 0; i < NUMBER_OF_TAPS; i++)
            [times addObject:[NSDate date]];
    }
    return self;
}

- (double)bpm: (NSDate *)d
{
    double dif = 0.0;
    for (int i = 0; i < NUMBER_OF_TAPS - 1; i++)
         [times replaceObjectAtIndex:i withObject:[times objectAtIndex:i+1]];
    [times replaceObjectAtIndex:NUMBER_OF_TAPS withObject:d];
    for (int i = 0; i < NUMBER_OF_TAPS - 1; i++)
        dif += 60 / ([[times objectAtIndex:i+1] timeIntervalSince1970] - [[times objectAtIndex:i] timeIntervalSince1970]);
    return dif / (NUMBER_OF_TAPS - 1);
}

@end
