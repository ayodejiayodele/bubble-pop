//
//  Bubble.m
//  bubblepop
//
//  Created by Ayodeji Ayodele on 1/05/2017.
//  Copyright © 2017 Ayodeji Ayodele. All rights reserved.
//

#import "Bubble.h"

@implementation Bubble

@synthesize gamepoints;
@synthesize appearanceProbability;
const int configuredWidth = 60;
const int configuredHeight = 60;

- (Bubble *)init{
    self = (Bubble *)[UIButton buttonWithType:UIButtonTypeCustom];
    if(self != nil){
        [self setFrame: CGRectMake(0, 0, configuredWidth, configuredHeight)];
    }
    
    return self;
}

+ (double)getConfiguredWidth{
    return configuredWidth;
}

+ (double)getConfiguredHeight{
    return configuredHeight;
}

@end
