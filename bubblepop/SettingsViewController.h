//
//  SettingsViewController.h
//  bubblepop
//
//  Created by Ayodeji Ayodele on 13/05/2017.
//  Copyright © 2017 Ayodeji Ayodele. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *maxNumOfBubblesLabel;
@property (weak, nonatomic) IBOutlet UISlider *maxNumOfBubblesSlider;
@property (weak, nonatomic) IBOutlet UILabel *gameTimeLabel;
@property (weak, nonatomic) IBOutlet UISlider *gameTimeSlider;
@property (weak, nonatomic) IBOutlet UIPickerView *difficultyPicker;
@property (strong, nonatomic) NSArray *difficultyLevels;

@end
