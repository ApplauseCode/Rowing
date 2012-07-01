//
//  Lane.h
//  Rowing
//
//  Created by Reed Rosenbluth on 4/8/12.
//  Copyright (c) 2012 Applause Code. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Lane : NSObject

@property (nonatomic, strong) NSDate *startTime;

- (double)spm: (NSDate *)d;
- (double)updateElapsedTime: (NSDate *)d;
- (void)resetStartTime;

@end
