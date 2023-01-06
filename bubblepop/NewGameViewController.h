//
//  NewGameViewController.h
//  bubblepop
//
//  Created by Ayodeji Ayodele on 1/05/2017.
//  Copyright © 2017 Ayodeji Ayodele. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewGameViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *playerNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *startGameButton;
- (IBAction)startGame_Clicked:(id)sender;

@end
