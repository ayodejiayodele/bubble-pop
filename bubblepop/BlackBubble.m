//
//  BlackBubble.m
//  bubblepop
//
//  Created by Ayodeji Ayodele on 1/05/2017.
//  Copyright © 2017 Ayodeji Ayodele. All rights reserved.
//

#import "BlackBubble.h"

@implementation BlackBubble

- (BlackBubble *)initWithFrame: (CGRect)frame{
    self = [super initWithFrame:frame];
    if(self!=nil){
        self.gamepoints = 10;
        self.appearanceProbability = 5;
        [self setImage:[UIImage imageNamed:@"blackball"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"blacksplash"] forState:UIControlStateHighlighted];
        self.colour = Black;
    }
    return self;
}

@end
