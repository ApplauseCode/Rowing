//
//  TimeParse.h
//  Rowing
//
//  Created by Jeffrey Rosenbluth on 4/12/12.
//  Copyright (c) 2012 Applause Code. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeParse : NSObject

+(double)toSeconds:(NSString *)s;
+ (NSString *)toString:(double)x;

@end
