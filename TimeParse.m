//
//  TimeParse.m
//  Rowing
//
//  Created by Jeffrey Rosenbluth on 4/12/12.
//  Copyright (c) 2012 Applause Code. All rights reserved.
//

#import "TimeParse.h"

@implementation TimeParse

+ (NSString *)toString:(double)x
{
    int minutes = x / 60;
    double seconds = fmod(x, 60.0);
    NSString *z = (seconds < 10) ? @"0" : @"";
    return [NSString stringWithFormat:@"%i'%@%3.1f''", minutes, z, seconds];   
}

+ (double)toSeconds:(NSString *)s
{
    double seconds;
    int length;
    NSCharacterSet *digits = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSCharacterSet *delimeters = [digits invertedSet];
    NSArray *timeComponents = [s componentsSeparatedByCharactersInSet:delimeters];
    length = [timeComponents count];
    switch (length) {
        case 0:
            seconds = 0.0;
            break;
        case 1:
            seconds = [[timeComponents objectAtIndex:0] doubleValue] * 60.0;
            break;
        case 2:
            seconds = [[timeComponents objectAtIndex:0] doubleValue] * 60.0;
            seconds += [[timeComponents objectAtIndex:1] doubleValue];
            break;    
        default:
            seconds = [[timeComponents objectAtIndex:0] doubleValue] * 60.0;
            seconds += [[timeComponents objectAtIndex:1] doubleValue];
            seconds += [[timeComponents objectAtIndex:2] doubleValue] / 10.0;
            break;
    }
    return seconds;
}

@end
