//
//  HighScoreViewController.h
//  bubblepop
//
//  Created by Ayodeji Ayodele on 15/05/2017.
//  Copyright © 2017 Ayodeji Ayodele. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HighScoreViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *highscorelistView;

@end
