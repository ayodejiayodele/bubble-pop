//
//  RedBubble.m
//  bubblepop
//
//  Created by Ayodeji Ayodele on 1/05/2017.
//  Copyright © 2017 Ayodeji Ayodele. All rights reserved.
//

#import "RedBubble.h"

@implementation RedBubble

- (RedBubble *)initWithFrame: (CGRect)frame{
    self = [super initWithFrame:frame];
    if(self != nil){
        self.gamepoints = 1;
        self.appearanceProbability = 40;
        [self setImage:[UIImage imageNamed:@"redball"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"redsplash"] forState:UIControlStateHighlighted];
        self.colour = Red;        
    }
    return self;
}


@end
