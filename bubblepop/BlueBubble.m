//
//  BlueBubble.m
//  bubblepop
//
//  Created by Ayodeji Ayodele on 1/05/2017.
//  Copyright © 2017 Ayodeji Ayodele. All rights reserved.
//

#import "BlueBubble.h"

@implementation BlueBubble

- (BlueBubble *)initWithFrame: (CGRect)frame{
    self = [super initWithFrame:frame];
    if(self != nil){
        self.gamepoints = 8;
        self.appearanceProbability = 10;
        [self setImage:[UIImage imageNamed:@"blueball"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"bluesplash"] forState:UIControlStateHighlighted];
        self.colour = Blue;
    }
    return self;
}

@end
