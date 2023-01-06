//
//  PinkBubble.m
//  bubblepop
//
//  Created by Ayodeji Ayodele on 1/05/2017.
//  Copyright © 2017 Ayodeji Ayodele. All rights reserved.
//

#import "PinkBubble.h"

@implementation PinkBubble

- (PinkBubble *)initWithFrame: (CGRect)frame{
    self = [super initWithFrame:frame];
    if(self != nil){
        self.gamepoints = 2;
        self.appearanceProbability = 30;
        [self setImage:[UIImage imageNamed:@"pinkball"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"pinksplash"] forState:UIControlStateHighlighted];
        self.colour = Pink;
    }
    return self;
}

@end
