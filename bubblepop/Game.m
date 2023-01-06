//
//  Game.m
//  bubblepop
//
//  Created by Ayodeji Ayodele on 1/05/2017.
//  Copyright © 2017 Ayodeji Ayodele. All rights reserved.
//

#import "Game.h"
#import "Settings.h"
#import "Bubble.h"

@implementation Game

@synthesize score = _score;
@synthesize player = _player;
@synthesize timeLeft = _timeLeft;
@synthesize currentPage = _currentPage;
@synthesize availableWidth = _availableWidth;
@synthesize availableHeight = _availableHeight;
@synthesize difficultyLevel = _difficultyLevel;
@synthesize state = _state;

NSString *playerNameKey = @"PlayerName";
NSString *gameScoreKey = @"GameScore";
NSString *currentPageScoreKey = @"CurrentPageScore";
NSString *gameTimeLeftKey = @"GameTimeLeft";
NSString *difficultyLevelKey = @"dKey";


- (Game *)initWith: (double)screenWidth by: (double)screenHeight{
    @try{
    self = [super init];
    if(self != nil){
        _timeLeft = [[Settings getGameTimeInSeconds] integerValue];
        _difficultyLevel = [[Settings getDifficultyLevel] integerValue] + 1;
        [self setAvailableDimensionsWithWidth:screenWidth andHeight:screenHeight];
        _currentPage = [[CurrentPage alloc] initWith:_availableWidth andHeight:_availableHeight];
    }
    
    return self;
    } @catch (NSException *exception) {
        NSLog(@"Catch - %@ : %@", [exception name], [exception reason]);
        NSLog(@"Finally - error initialising new game");
    }
}

- (void)setAvailableDimensionsWithWidth: (double)width andHeight: (double)height{
    _availableWidth = width - 2;    //Add a little space to the left and right of the screen
    _availableHeight = height - 162;    //Remove the height of the navigation bar and the toolbar
}


- (void)updateGameScoreWith: (NSInteger)pageScore{
    _score += pageScore;
}

- (void)startGame{
    _state = Playing;
}

- (void)pauseGame{
    _state = Paused;
    NSDictionary *gameStats = @{playerNameKey:_player,
                                gameScoreKey:[NSNumber numberWithInteger: _score],
                                currentPageScoreKey:[NSNumber numberWithInteger: _currentPage.pageScore],
                                gameTimeLeftKey:[NSNumber numberWithInteger: _timeLeft],
                                difficultyLevelKey:[NSNumber numberWithInteger:_difficultyLevel]
                                };
    [Settings setSavedGameWithGame:gameStats];
}

//Resume a saved game
- (Game *)initResumeGameWith: (double)screenWidth by: (double)screenHeight{
    @try{
    self = [super init];
    NSDictionary *pausedGame = [Settings getSavedGame];
    if(pausedGame != nil){
        _player = [pausedGame objectForKey:playerNameKey];
        _score = [(NSNumber*)[pausedGame objectForKey:gameScoreKey] integerValue]+
        [(NSNumber*)[pausedGame objectForKey:currentPageScoreKey] integerValue];
        _timeLeft = [(NSNumber*) [pausedGame objectForKey:gameTimeLeftKey] integerValue];
        _difficultyLevel = [(NSNumber*) [pausedGame objectForKey:difficultyLevelKey] integerValue];
        
        [self setAvailableDimensionsWithWidth:screenWidth andHeight:screenHeight];
        _currentPage = [[CurrentPage alloc] initWith:_availableWidth andHeight:_availableHeight];
        _state = Paused;
    }
    
    return  self;
    } @catch (NSException *exception) {
        NSLog(@"Catch - %@ : %@", [exception name], [exception reason]);
        NSLog(@"Finally - error resuming saved game");
    }
}

- (void)stopGame{
    for(Bubble *bubble in _currentPage.subviews){
        [bubble setUserInteractionEnabled:NO];
    }
    
    _state = Stopped;
    [Settings setSavedGameWithGame:nil];
}

@end
