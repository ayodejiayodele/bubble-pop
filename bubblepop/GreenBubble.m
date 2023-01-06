//
//  GreenBubble.m
//  bubblepop
//
//  Created by Ayodeji Ayodele on 1/05/2017.
//  Copyright © 2017 Ayodeji Ayodele. All rights reserved.
//

#import "GreenBubble.h"

@implementation GreenBubble

- (GreenBubble *)initWithFrame: (CGRect)frame{
    self = [super initWithFrame:frame];
    if(self != nil){
        self.gamepoints = 5;
        self.appearanceProbability = 15;
        [self setImage:[UIImage imageNamed:@"greenball"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"greensplash"] forState:UIControlStateHighlighted];
        self.colour = Green;
    }
    return self;
}

@end
