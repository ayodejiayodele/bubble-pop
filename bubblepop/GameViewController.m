//
//  GameViewController.m
//  bubblepop
//
//  Created by Ayodeji Ayodele on 1/05/2017.
//  Copyright © 2017 Ayodeji Ayodele. All rights reserved.
//

#import "GameViewController.h"
#import "AppDelegate.h"
#import "Player+CoreDataProperties.h"


@interface GameViewController ()
{
    AppDelegate * appDelegate_;
    NSMutableArray * playerList_;
}
@end

@implementation GameViewController

@synthesize game=_game;
@synthesize  playerName = _playerName;
@synthesize scoreBoard;
@synthesize highScoreLabel;
@synthesize timeLeftLabel;
@synthesize pauseGameButton;
@synthesize endGameScoreLabel;
@synthesize endGameView;
@synthesize endGameButton;
@synthesize isResuming;
NSTimer *gameTimer, *pageTimer, *countdownTimer;
NSString *scorePrefix = @"Your score: ";

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate_ = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if(isResuming){ //Resuming from a saved game
        _game = [[Game alloc] initResumeGameWith:CGRectGetWidth(self.view.bounds) by:CGRectGetHeight(self.view.bounds)];
        _playerName = _game.player;
    }
    else{
        if(_game == nil)
            _game = [[Game alloc] initWith:CGRectGetWidth(self.view.bounds) by:CGRectGetHeight(self.view.bounds)];
        [_game setPlayer:_playerName];

    }
    
    [[self navigationItem] setTitle:_playerName];
    [[self navigationItem] setHidesBackButton:YES];
    [endGameView setUserInteractionEnabled:NO];
    [timeLeftLabel setText: [NSString stringWithFormat:@"%ld",(long)[_game timeLeft]]];
    [highScoreLabel setText:[NSString stringWithFormat:@"High score: %@",[appDelegate_ getHighestScore]]];
    [self startGame];
    
}

//Readjust the game frame if orientation is changed
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [_game setAvailableDimensionsWithWidth:(double)size.width andHeight:(double)size.height];
    [_game.currentPage readjustSizeWithWidth:_game.availableWidth andHeight:_game.availableHeight];
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) startGame{
    [_game startGame];
    gameTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                 target:self
                                               selector:@selector(updateGameTime)
                                               userInfo:nil
                                                repeats:YES];
    
    pageTimer = [NSTimer scheduledTimerWithTimeInterval:1.1 - (_game.difficultyLevel * 0.1) target:self selector:@selector(fillPage) userInfo:nil repeats:YES];
}

- (void)updateGameTime{
    @try{
        _game.timeLeft--;
        [timeLeftLabel setText: [NSString stringWithFormat:@"%ld", (long)_game.timeLeft]];
        if([_game timeLeft] <= 0){
            [_game updateGameScoreWith:_game.currentPage.pageScore];
            [_game stopGame];
            [self saveGameToDB];
            [self endGame];
        }
        else if([_game timeLeft] < 60 && [_game timeLeft] % 20 == 0){ //Increase game speed every 20 seconds
            double currentInterval = pageTimer.timeInterval;
            [pageTimer invalidate];
            pageTimer = nil;
            pageTimer = [NSTimer scheduledTimerWithTimeInterval:(currentInterval - 0.1) target:self selector:@selector(fillPage) userInfo:nil repeats:YES];
        }
        
        if([_game timeLeft] == 10){
            countdownTimer = [NSTimer scheduledTimerWithTimeInterval:0.33
                                                              target:self
                                                            selector:@selector(flashCountdown)
                                                            userInfo:nil
                                                             repeats:YES];
        }
    } @catch (NSException *exception) {
        NSLog(@"Catch - %@ : %@", [exception name], [exception reason]);
        NSLog(@"Finally - error in game timer calculations");
    }
}

- (void)fillPage{
    @try{
        [_game updateGameScoreWith:_game.currentPage.pageScore];
        [self.scoreBoard setText:[NSString stringWithFormat:@"Your score: %ld", (long)_game.score]];
        [_game.currentPage refillWithBubbles];
        
        if([self.view.subviews containsObject:_game.currentPage])
            [_game.currentPage removeFromSuperview];
        
        //Add bouncy animation
        _game.currentPage.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
        
        [self.view addSubview:_game.currentPage];
        
        [UIView animateWithDuration:0.3/1.5 animations:^{
            _game.currentPage.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                _game.currentPage.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3/2 animations:^{
                    _game.currentPage.transform = CGAffineTransformIdentity;
                }];
            }];
        }];
    } @catch (NSException *exception) {
        NSLog(@"Catch - %@ : %@", [exception name], [exception reason]);
    } @finally {
        NSLog(@"Finally - error filling page with current page");
    }

}

- (void)flashCountdown{
    if([timeLeftLabel alpha] == 1)
        [timeLeftLabel setAlpha:0.2];
    else
        [timeLeftLabel setAlpha:1];
}

- (void)gameWillEnd{
    if([_game state] == Playing || [_game state] == Paused){
        [gameTimer invalidate];
        [pageTimer invalidate];
        
        //Give player an opportunity to continue game at a later time by saving it
        UIAlertController* closingAlert = [UIAlertController
                                           alertControllerWithTitle:@"End Game"
                                           message:@"Do you want to save this game?"
                                           preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             [_game pauseGame];
                                                             [self.navigationController popToRootViewControllerAnimated:YES];
                                                         }];
    
        UIAlertAction* noAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              [self endGame];
                                                              [self.navigationController popToRootViewControllerAnimated:NO];
                                                              }];
    
        [closingAlert addAction:yesAction];
        [closingAlert addAction:noAction];
        [self presentViewController:closingAlert animated:YES completion:nil];
    }
    else
        [self endGame];
}

- (void)saveGameToDB{
    playerList_ = [appDelegate_ playerList];
    Player *playerWithLowestScore = nil;
    if(playerList_.count > 0)
        playerWithLowestScore = playerList_[playerList_.count - 1];
    
    //Save game only if player score is in top 20
    if(playerList_.count <= 20 || _game.score > [playerWithLowestScore.score integerValue])
        playerList_ = [appDelegate_ addNewPlayer:_game.player
                                   withScore:[NSNumber numberWithInteger:_game.score]
                                    andLevel:[NSNumber numberWithInteger:_game.difficultyLevel]];
}

- (void)endGame{
    [endGameScoreLabel setText:[NSString stringWithFormat:@"%ld", (long)_game.score]];
    [endGameView setHidden:NO];
    [endGameView setUserInteractionEnabled:YES];
    [pauseGameButton setEnabled:NO];
    [endGameButton setEnabled:NO];
    [self.view bringSubviewToFront:endGameView];
    if(gameTimer)
        [gameTimer invalidate];
    if(pageTimer)
        [pageTimer invalidate];
    if(countdownTimer)
        [countdownTimer invalidate];
    gameTimer = nil;
    pageTimer = nil;
    countdownTimer = nil;
    _game = nil;
    
}

- (void)resumeGame{
    [self startGame];
}

- (void)gameWillPause{
    if([_game state] == Playing)
        [_game pauseGame];
    [gameTimer invalidate];
    [pageTimer invalidate];
    
    //While game is paused, give player opportunity to quit
    UIAlertController* pausingAlert = [UIAlertController
                                       alertControllerWithTitle:@"Game Paused"
                                       message:@"Game has been paused."
                                       preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* resumeAction = [UIAlertAction actionWithTitle:@"Resume" style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action) {
                                                          [self resumeGame];
                                                      }];
    
    UIAlertAction* endGameAction = [UIAlertAction actionWithTitle:@"End Game" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
                                                         [self gameWillEnd];
                                                     }];
    
    [pausingAlert addAction:resumeAction];
    [pausingAlert addAction:endGameAction];
    [self presentViewController:pausingAlert animated:YES completion:nil];

}

- (IBAction)gameOverButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"OpenHighScoreViewController" sender:self];
}

- (IBAction)endGameButton_Clicked:(id)sender {
    [self gameWillEnd];
}

- (IBAction)pauseGameButton_Clicked:(id)sender {
    [self gameWillPause];
}

//Remove this controller from the stack so that it doesn't show as a back button
- (void)removeMeFromNavigationController{
    UINavigationController *myParent = self.navigationController;
    NSUInteger myPosition = [myParent.viewControllers indexOfObject:self];
    NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
    
    [navigationArray removeObjectAtIndex: myPosition];
    self.navigationController.viewControllers = navigationArray;
}

- (IBAction)playAgainButton_Clicked:(id)sender {
    [self removeMeFromNavigationController];
}

- (IBAction)bubblyHomeButton_Clicked:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
