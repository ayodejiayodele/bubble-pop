//
//  CurrentPage.h
//  bubblepop
//
//  Created by Ayodeji Ayodele on 2/05/2017.
//  Copyright © 2017 Ayodeji Ayodele. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrentPage : UIView

@property (readonly) int numberOfRows;
@property (readonly) int numberOfColumns;
@property (readonly) double rowSpacing;
@property (readonly) double columnSpacing;
@property (readonly) NSInteger numberOfBubbles;
@property (readonly) NSInteger pageScore;
@property (readonly) NSDictionary *bubbleProbabilities;

- (CurrentPage *)initWith: (double)availableWidth andHeight: (double)availableHeight;
- (void)readjustSizeWithWidth: (double)availableWidth andHeight: (double) availableHeight;
- (void)fillWithBubbles;
- (void)refillWithBubbles;

@end
