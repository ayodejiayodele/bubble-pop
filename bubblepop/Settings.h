//
//  Settings.h
//  bubblepop
//
//  Created by Ayodeji Ayodele on 2/05/2017.
//  Copyright © 2017 Ayodeji Ayodele. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject

+ (NSNumber *)getNumberOfBubbles;
+ (void)setNumberOfBubblesWith: (int)value;
+ (NSNumber *)getDifficultyLevel;
+ (void)setDifficultyLevelWith: (int)value;
+ (NSNumber *)getGameTimeInSeconds;
+ (void)setGameTimeInSecondsWith: (double)value;
+ (NSNumber *)getRedBubbleProbability;
+ (void)setRedBubbleProbabilityWith: (int)value;
+ (NSNumber *)getBlueBubbleProbability;
+ (void)setBlueBubbleProbabilityWith: (int)value;
+ (NSNumber *)getGreenBubbleProbability;
+ (void)setGreenBubbleProbabilityWith: (int)value;
+ (NSNumber *)getPinkBubbleProbability;
+ (void)setPinkBubbleProbabilityWith: (int)value;
+ (NSNumber *)getBlackBubbleProbability;
+ (void)setBlackBubbleProbabilityWith: (int)value;
+ (NSDictionary *)getSavedGame;
+ (void)setSavedGameWithGame: (NSDictionary *)game;

@end
