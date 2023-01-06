//
//  HighScoreViewController.m
//  bubblepop
//
//  Created by Ayodeji Ayodele on 15/05/2017.
//  Copyright © 2017 Ayodeji Ayodele. All rights reserved.
//

#import "HighScoreViewController.h"
#import "AppDelegate.h"
#import "Player+CoreDataProperties.h"

@interface HighScoreViewController ()
{
    AppDelegate *appDelegate_;
    NSMutableArray *playerList_;
}

@end

@implementation HighScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    appDelegate_ = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    playerList_ = [appDelegate_ playerList];
    self.highscorelistView.dataSource = self;
    self.highscorelistView.delegate = self;
    
    [self.highscorelistView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView: (UITableView *) tableView
{
    return 1; //return the number of sections
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [playerList_ count]; //return the number of rows with respect to the section number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"player" forIndexPath:indexPath];
    
    Player * player = (Player *)[playerList_ objectAtIndex: indexPath.row];
    cell.textLabel.text = player.name;
    // Configure the cell to present data...
    cell.detailTextLabel.text = player.score.stringValue;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void) tableView: (UITableView *) tv commitEditingStyle: (UITableViewCellEditingStyle) editingStyle forRowAtIndexPath:(NSIndexPath *) indexPath
{
    [appDelegate_ deletePlayerAtIndex: indexPath.row];
    [self.highscorelistView deleteRowsAtIndexPaths:[NSArray arrayWithObject: indexPath]
                             withRowAnimation: UITableViewRowAnimationFade];
}

@end
