//
//  SettingsViewController.m
//  bubblepop
//
//  Created by Ayodeji Ayodele on 13/05/2017.
//  Copyright © 2017 Ayodeji Ayodele. All rights reserved.
//

#import "SettingsViewController.h"
#import "Settings.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize maxNumOfBubblesLabel;
@synthesize maxNumOfBubblesSlider;
@synthesize gameTimeLabel;
@synthesize gameTimeSlider;
@synthesize difficultyPicker;
@synthesize difficultyLevels;



- (void)viewDidLoad {
    [super viewDidLoad];

    NSNumber *maxNumOfBubbles = [Settings getNumberOfBubbles];
    [maxNumOfBubblesLabel setText:[NSString stringWithFormat:@"%ld",(long)[maxNumOfBubbles integerValue]]];
    [maxNumOfBubblesSlider setValue:[maxNumOfBubbles integerValue]];
    [maxNumOfBubblesSlider addTarget:self action:@selector(maxNumOfBubblesSliderDidChange) forControlEvents:UIControlEventValueChanged];
    
    NSNumber *gameTime = [Settings getGameTimeInSeconds];
    [gameTimeLabel setText:[NSString stringWithFormat:@"%ld",(long)[gameTime integerValue]]];
    [gameTimeSlider setValue:[gameTime integerValue]];
    [gameTimeSlider addTarget:self action:@selector(gameTimeSliderDidChange) forControlEvents:UIControlEventValueChanged];
    
    difficultyLevels = @[@"Easy", @"Intermediate", @"I'm a pro"];
    [difficultyPicker selectRow:[[Settings getDifficultyLevel] integerValue] inComponent:0 animated:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)maxNumOfBubblesSliderDidChange{
    [maxNumOfBubblesLabel setText:[NSString stringWithFormat:@"%d",(int)maxNumOfBubblesSlider.value]];
    [Settings setNumberOfBubblesWith:(int)maxNumOfBubblesSlider.value];
}

- (void)gameTimeSliderDidChange{
    [gameTimeLabel setText:[NSString stringWithFormat:@"%d",(int)gameTimeSlider.value]];
    [Settings setGameTimeInSecondsWith:gameTimeSlider.value];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return difficultyLevels.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [difficultyLevels objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [Settings setDifficultyLevelWith:(int)row];
}


@end
