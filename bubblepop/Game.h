//
//  Game.h
//  bubblepop
//
//  Created by Ayodeji Ayodele on 1/05/2017.
//  Copyright © 2017 Ayodeji Ayodele. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CurrentPage.h"

@interface Game : NSObject

@property (readonly) NSInteger score;
@property NSString *player;
@property NSInteger timeLeft;
@property NSInteger difficultyLevel;
@property (readonly) enum State state;
@property CurrentPage *currentPage;
@property (readonly) double availableHeight;
@property (readonly) double availableWidth;

- (Game *)initWith: (double)screenWidth by: (double)screenHeight;
- (Game *)initResumeGameWith: (double)screenWidth by: (double)screenHeight;
- (void)setAvailableDimensionsWithWidth: (double)width andHeight: (double)height;
- (void)updateGameScoreWith:(NSInteger)pageScore;
- (void)startGame;
- (void)pauseGame;
- (void)stopGame;

enum State{
    Playing, Stopped, Paused
};

@end
