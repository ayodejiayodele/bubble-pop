//
//  Bubble.h
//  bubblepop
//
//  Created by Ayodeji Ayodele on 1/05/2017.
//  Copyright © 2017 Ayodeji Ayodele. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"

@interface Bubble : UIButton

@property NSInteger gamepoints;
@property NSInteger appearanceProbability;
@property enum Colour colour;

enum Colour{
    Red, Blue, Pink, Green, Black
};

+ (double)getConfiguredWidth;
+ (double)getConfiguredHeight;

@end
