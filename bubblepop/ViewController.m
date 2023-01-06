//
//  ViewController.m
//  bubblepop
//
//  Created by Ayodeji Ayodele on 27/04/2017.
//  Copyright © 2017 Ayodeji Ayodele. All rights reserved.
//

#import "ViewController.h"
#import "GameViewController.h"
#import "Settings.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize resumeGameButton = _resumeGameButton;
@synthesize currentGame = _currentGame;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated{
    _currentGame = [Settings getSavedGame] != nil;
    
    if(_currentGame)
        _resumeGameButton.hidden = NO;
    else
        _resumeGameButton.hidden = YES;    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIButton *senderButton = (UIButton*) sender;
    if(senderButton != nil && [senderButton.currentTitle isEqualToString: _resumeGameButton.currentTitle]){
        GameViewController *gameViewController = (GameViewController*)segue.destinationViewController;
        gameViewController.isResuming = YES;
    }
}

- (IBAction)newGame_Clicked:(id)sender {
    _currentGame = NO;
}
@end
