//
//  ViewController.h
//  bubblepop
//
//  Created by Ayodeji Ayodele on 27/04/2017.
//  Copyright © 2017 Ayodeji Ayodele. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property BOOL currentGame;
@property (weak, nonatomic) IBOutlet UIButton *resumeGameButton;

- (IBAction)newGame_Clicked:(id)sender;


@end

