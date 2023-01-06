//
//  Settings.m
//  bubblepop
//
//  Created by Ayodeji Ayodele on 2/05/2017.
//  Copyright © 2017 Ayodeji Ayodele. All rights reserved.
//

#import "Settings.h"

@implementation Settings

NSString *numberOfBubblesKey = @"NumberOfBubbles";
NSString *difficultyKey = @"Difficulty";
NSString *gameTimeKey = @"GameTime";
NSString *redBallProbKey = @"RedBallProb";
NSString *blueBallProbKey = @"BlueBallProb";
NSString *greenBallProbKey = @"GreenBallProb";
NSString *pinkBallProbKey = @"PinkBallProb";
NSString *blackBallProbKey = @"BlackBallProb";
NSString *savedGameKey = @"SavedGame";

+ (NSNumber*)getNumberOfBubbles{
    NSUserDefaults *settings = [[NSUserDefaults standardUserDefaults] init];
    NSNumber *noOfBubbles = [settings objectForKey:numberOfBubblesKey];
    if(noOfBubbles == nil){
        noOfBubbles = [NSNumber numberWithInt:15];
        [settings setObject:noOfBubbles forKey:numberOfBubblesKey];
    }
    return noOfBubbles;
}

+ (void)setNumberOfBubblesWith: (int)value{
    NSUserDefaults *settings = [[NSUserDefaults standardUserDefaults] init];
    [settings setObject:[NSNumber numberWithInt:value] forKey:numberOfBubblesKey];
}

+ (NSNumber *)getDifficultyLevel{
    NSUserDefaults *settings = [[NSUserDefaults standardUserDefaults] init];
    NSNumber *difficulty = [settings objectForKey:difficultyKey];
    if(difficulty == nil){
        difficulty = [NSNumber numberWithInt:0];   //Easy
        [settings setObject:difficulty forKey:difficultyKey];
    }
    return difficulty;
}

+ (void)setDifficultyLevelWith: (int)value{
    NSUserDefaults *settings = [[NSUserDefaults standardUserDefaults] init];
    [settings setObject:[NSNumber numberWithInt:value] forKey:difficultyKey];
}

+ (NSNumber *)getGameTimeInSeconds{
    NSUserDefaults *settings = [[NSUserDefaults standardUserDefaults] init];
    NSNumber *gameTime = [settings objectForKey:gameTimeKey];
    if(gameTime == nil){
        gameTime = [NSNumber numberWithDouble:60.0];
        [settings setObject:gameTime forKey:gameTimeKey];
    }
    return gameTime;
}

+ (void)setGameTimeInSecondsWith: (double)value{
    NSUserDefaults *settings = [[NSUserDefaults standardUserDefaults] init];
    [settings setObject:[NSNumber numberWithDouble:value] forKey:gameTimeKey];
}

+ (NSNumber *)getRedBubbleProbability{
    NSUserDefaults *settings = [[NSUserDefaults standardUserDefaults] init];
    NSNumber *redBallProbability = [settings objectForKey:redBallProbKey];
    if(redBallProbability == nil){
        redBallProbability = [NSNumber numberWithInt:40];
        [settings setObject:redBallProbability forKey:redBallProbKey];
    }
    return redBallProbability;
}

+ (void)setRedBubbleProbabilityWith: (int)value{
    NSUserDefaults *settings = [[NSUserDefaults standardUserDefaults] init];
    [settings setObject:[NSNumber numberWithInt:value] forKey:redBallProbKey];
}

+ (NSNumber *)getBlueBubbleProbability{
    NSUserDefaults *settings = [[NSUserDefaults standardUserDefaults] init];
    NSNumber *blueBallProbability = [settings objectForKey:blueBallProbKey];
    if(blueBallProbability == nil){
        blueBallProbability = [NSNumber numberWithInt:10];
        [settings setObject:blueBallProbability forKey:blueBallProbKey];
    }
    return blueBallProbability;
}

+ (void)setBlueBubbleProbabilityWith: (int)value{
    NSUserDefaults *settings = [[NSUserDefaults standardUserDefaults] init];
    [settings setObject:[NSNumber numberWithInt:value] forKey:blueBallProbKey];
}

+ (NSNumber *)getGreenBubbleProbability{
    NSUserDefaults *settings = [[NSUserDefaults standardUserDefaults] init];
    NSNumber *greenBallProbability = [settings objectForKey:greenBallProbKey];
    if(greenBallProbability == nil){
        greenBallProbability = [NSNumber numberWithInt:15];
        [settings setObject:greenBallProbability forKey:greenBallProbKey];
    }
    return greenBallProbability;
}

+ (void)setGreenBubbleProbabilityWith: (int)value{
    NSUserDefaults *settings = [[NSUserDefaults standardUserDefaults] init];
    [settings setObject:[NSNumber numberWithInt:value] forKey:greenBallProbKey];
}

+ (NSNumber *)getPinkBubbleProbability{
    NSUserDefaults *settings = [[NSUserDefaults standardUserDefaults] init];
    NSNumber *pinkBallProbability = [settings objectForKey:pinkBallProbKey];
    if(pinkBallProbability == nil){
        pinkBallProbability = [NSNumber numberWithInt:30];
        [settings setObject:pinkBallProbability forKey:pinkBallProbKey];
    }
    return pinkBallProbability;
}

+ (void)setPinkBubbleProbabilityWith: (int)value{
    NSUserDefaults *settings = [[NSUserDefaults standardUserDefaults] init];
    [settings setObject:[NSNumber numberWithInt:value] forKey:pinkBallProbKey];
}

+ (NSNumber *)getBlackBubbleProbability{
    NSUserDefaults *settings = [[NSUserDefaults standardUserDefaults] init];
    NSNumber *blackBallProbability = [settings objectForKey:blackBallProbKey];
    if(blackBallProbability == nil){
        blackBallProbability = [NSNumber numberWithInt:5];
        [settings setObject:blackBallProbability forKey:blackBallProbKey];
    }
    return blackBallProbability;
}

+ (void)setBlackBubbleProbabilityWith: (int)value{
    NSUserDefaults *settings = [[NSUserDefaults standardUserDefaults] init];
    [settings setObject:[NSNumber numberWithInt:value] forKey:blackBallProbKey];
}

+ (NSDictionary *)getSavedGame{
    NSUserDefaults *settings = [[NSUserDefaults standardUserDefaults] init];
    return [settings objectForKey:savedGameKey];
}

+ (void)setSavedGameWithGame: (NSDictionary*) game{
    NSUserDefaults *settings = [[NSUserDefaults standardUserDefaults] init];
    if(game != nil)
        [settings setObject:game forKey:savedGameKey];
    else
        [settings removeObjectForKey:savedGameKey];
}


@end
