//
//  NewGameViewController.m
//  bubblepop
//
//  Created by Ayodeji Ayodele on 1/05/2017.
//  Copyright © 2017 Ayodeji Ayodele. All rights reserved.
//

#import "NewGameViewController.h"
#import "GameViewController.h"

@interface NewGameViewController ()

@end

@implementation NewGameViewController

@synthesize startGameButton = _startGameButton;
@synthesize playerNameTextField = _playerNameTextField;

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationItem.backBarButtonItem setTitle:@"Home"];
    [_playerNameTextField addTarget:self
                  action:@selector(textFieldDidChange)
        forControlEvents:UIControlEventEditingChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIButton *senderButton = (UIButton*) sender;
    
    //Confirm it is the Play button
    if(senderButton != nil && [senderButton.currentTitle  isEqual: _startGameButton.currentTitle]){
        GameViewController *gameToLaunch = [segue destinationViewController];
        gameToLaunch.playerName = [_playerNameTextField text];
    }
}


- (IBAction)startGame_Clicked:(id)sender {
    [self performSegueWithIdentifier:@"OpenGameViewController" sender:_startGameButton];
}

- (void)textFieldDidChange{
    if([NewGameViewController isStringEmpty:[_playerNameTextField text]]){
        [_startGameButton setEnabled:NO];
        [_startGameButton setBackgroundColor:[UIColor grayColor]];
    }
    else{
        [_startGameButton setEnabled:YES];
        [_startGameButton setBackgroundColor:[UIColor colorWithRed:0.07 green:0.59 blue:1.00 alpha:1.00]];
    }
}

+ (BOOL)isStringEmpty:(NSString*)string {
    if([string length] == 0)
        return YES;
    
    if(![[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length])
        return YES;

    return NO;
}

@end
