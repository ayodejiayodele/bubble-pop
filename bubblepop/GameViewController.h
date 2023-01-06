//
//  GameViewController.h
//  bubblepop
//
//  Created by Ayodeji Ayodele on 1/05/2017.
//  Copyright © 2017 Ayodeji Ayodele. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"

@interface GameViewController : UIViewController

@property NSString *playerName;
@property Game *game;
@property BOOL isResuming;
@property (weak, nonatomic) IBOutlet UILabel *scoreBoard;
@property (weak, nonatomic) IBOutlet UILabel *highScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLeftLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *endGameButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *pauseGameButton;
@property (weak, nonatomic) IBOutlet UILabel *endGameScoreLabel;
@property (weak, nonatomic) IBOutlet UIView *endGameView;
- (IBAction)gameOverButtonPressed:(id)sender;
- (IBAction)endGameButton_Clicked:(id)sender;
- (IBAction)pauseGameButton_Clicked:(id)sender;
- (IBAction)playAgainButton_Clicked:(id)sender;
- (IBAction)bubblyHomeButton_Clicked:(id)sender;

@end
