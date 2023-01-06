//
//  CurrentPage.m
//  bubblepop
//
//  Created by Ayodeji Ayodele on 2/05/2017.
//  Copyright © 2017 Ayodeji Ayodele. All rights reserved.
//

#import "CurrentPage.h"
#import "Bubble.h"
#import "RedBubble.h"
#import "PinkBubble.h"
#import "BlueBubble.h"
#import "BlackBubble.h"
#import "GreenBubble.h"
#import "Settings.h"


@implementation CurrentPage

@synthesize numberOfRows = _numberOfRows;
@synthesize numberOfColumns = _numberOfColumns;
@synthesize rowSpacing = _rowSpacing;
@synthesize columnSpacing = _columnSpacing;
@synthesize numberOfBubbles = _numberOfBubbles;
@synthesize pageScore = _pageScore;
@synthesize bubbleProbabilities = _bubbleProbabilities;


const int startX = 1;
const int startY = 117;
double bubbleDefaultWidth = 0;
double bubbleDefaultHeight = 0;
NSString *locXKey = @"X";
NSString *locYKey = @"Y";
NSArray *probabilityKeys = nil;
NSArray *usedLocations = nil;
enum Colour lastPoppedBubble;


- (CurrentPage *)initWith: (double)availableWidth andHeight: (double)availableHeight{
    @try{
        self = [super initWithFrame:CGRectMake(startX, startY, availableWidth, availableHeight)];
        
        [self setDimensionsWithWidth:availableWidth andHeight:availableHeight];
        
        
        if(probabilityKeys == nil)
            probabilityKeys = @[@"Black", @"Blue", @"Green", @"Pink", @"Red"]; //in that order
        _bubbleProbabilities = @{
                                 probabilityKeys[0] : [Settings getBlackBubbleProbability],
                                 probabilityKeys[1] : [Settings getBlueBubbleProbability],
                                 probabilityKeys[2] : [Settings getGreenBubbleProbability],
                                 probabilityKeys[3] : [Settings getPinkBubbleProbability],
                                 probabilityKeys[4] : [Settings getRedBubbleProbability]
                                 };
        
        usedLocations = [[NSArray alloc] init];
        
        return self;
        
    } @catch (NSException *exception) {
        NSLog(@"Catch - %@ : %@", [exception name], [exception reason]);
        NSLog(@"Finally - error initialising current page");
    }
}

- (void)fillWithBubbles{
    @try {
        _numberOfBubbles = [[Settings getNumberOfBubbles] integerValue];
        
        //If it is a small screen, you might not be able to fit in up
        //to the default number of bubbles in the setting
        int maximumPossible = _numberOfRows * _numberOfColumns;
        if(_numberOfBubbles > maximumPossible)
            _numberOfBubbles = maximumPossible;
        
        _pageScore = 0;
        
        NSInteger randomNumberOfBubblesToDisplay = (arc4random() % _numberOfBubbles) + 1;
        
        for(int i = 0; i < randomNumberOfBubblesToDisplay; i++){
            
            NSString *randomBubble = [self pickRandomBubble];
            NSDictionary *bubbleLocation = [self getRandomLocationToInsertBubble];
            
            if(randomBubble != nil && bubbleLocation != nil){
                if([randomBubble isEqualToString:@"Red"]){
                    RedBubble *newBubble = [[RedBubble alloc] initWithFrame:CGRectMake(
                                                                                       [[bubbleLocation objectForKey:locXKey] floatValue],
                                                                                       [[bubbleLocation objectForKey:locYKey] floatValue],
                                                                                       bubbleDefaultWidth, bubbleDefaultHeight)];
                    [self addSubview:newBubble];
                    [newBubble addTarget:self action:@selector(updateScoreWithColor:) forControlEvents:UIControlEventTouchUpInside];
                }
                else if([randomBubble isEqualToString:@"Pink"]){
                    PinkBubble *newBubble = [[PinkBubble alloc] initWithFrame:CGRectMake(
                                                                                         [[bubbleLocation objectForKey:locXKey] floatValue],
                                                                                         [[bubbleLocation objectForKey:locYKey] floatValue],
                                                                                         bubbleDefaultWidth, bubbleDefaultHeight)];
                    
                    [self addSubview:newBubble];
                    [newBubble addTarget:self action:@selector(updateScoreWithColor:) forControlEvents:UIControlEventTouchUpInside];
                }
                else if([randomBubble isEqualToString:@"Green"]){
                    GreenBubble *newBubble = [[GreenBubble alloc] initWithFrame:CGRectMake([[bubbleLocation objectForKey:locXKey] floatValue], [[bubbleLocation objectForKey:locYKey] floatValue], bubbleDefaultWidth, bubbleDefaultHeight)];
                    
                    [self addSubview:newBubble];
                    [newBubble addTarget:self action:@selector(updateScoreWithColor:) forControlEvents:UIControlEventTouchUpInside];
                }
                else if([randomBubble isEqualToString:@"Blue"]){
                    BlueBubble *newBubble = [[BlueBubble alloc] initWithFrame:CGRectMake(
                                                                                         [[bubbleLocation objectForKey:locXKey] floatValue],
                                                                                         [[bubbleLocation objectForKey:locYKey] floatValue],
                                                                                         bubbleDefaultWidth, bubbleDefaultHeight)];
                    
                    [self addSubview:newBubble];
                    [newBubble addTarget:self action:@selector(updateScoreWithColor:) forControlEvents:UIControlEventTouchUpInside];
                }
                else if([randomBubble isEqualToString:@"Black"]){
                    BlackBubble *newBubble = [[BlackBubble alloc] initWithFrame:CGRectMake(
                                                                                           [[bubbleLocation objectForKey:locXKey] floatValue],
                                                                                           [[bubbleLocation objectForKey:locYKey] floatValue],
                                                                                           bubbleDefaultWidth, bubbleDefaultHeight)];
                    
                    [self addSubview:newBubble];
                    [newBubble addTarget:self action:@selector(updateScoreWithColor:) forControlEvents:UIControlEventTouchUpInside];
                }
            }
        }

    } @catch (NSException *exception) {
        NSLog(@"Catch - %@ : %@", [exception name], [exception reason]);
        NSLog(@"Finally - error filling bubble");
    }
}

- (void)refillWithBubbles{
    [[self subviews ] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    usedLocations = [[NSArray alloc] init];
    [self fillWithBubbles];
}

- (NSString *)pickRandomBubble{
    int diceRoll = (arc4random() % 100) + 1;
    
    int cumulative = 0;
    for (NSString *bubbleProbability in probabilityKeys){
        cumulative += [[_bubbleProbabilities objectForKey:bubbleProbability] integerValue];
        if (diceRoll < cumulative){
            return bubbleProbability;
        }
    }
    
    return nil;
}

- (NSDictionary *)getRandomLocationToInsertBubble{
    float locX, locY;
    int maxNumOfBubblesPossible = _numberOfRows * _numberOfColumns;

    int location = (arc4random() % maxNumOfBubblesPossible) + 1;
    NSString *assignedLocation = [NSString stringWithFormat:@"%d",location];
    
    while ([usedLocations containsObject:assignedLocation]) {
        location =  (arc4random() % maxNumOfBubblesPossible) + 1;
        assignedLocation = [NSString stringWithFormat:@"%d",location];
    }
    usedLocations = [usedLocations arrayByAddingObject:assignedLocation];
    
    locX = [self calculateCoordinateXForLocation:location];
    locY = [self calculateCoordinateYForLocation:location];
    
    return  @{
              locXKey : [NSNumber numberWithFloat: locX],
              locYKey : [NSNumber numberWithFloat: locY]
              };
}

- (float)calculateCoordinateXForLocation: (int) location{
    int column = [self calculateColumnNumberForLocation:location];
    int multiplier = column - 1;
    
    return (multiplier * bubbleDefaultWidth) + (multiplier * _columnSpacing);
}

- (float)calculateCoordinateYForLocation: (int) location{
    int row = [self calculateRowNumberForLocation:location];
    int multiplier = row - 1;
    
    return (multiplier * bubbleDefaultHeight) + (multiplier * _rowSpacing);
}

- (int)calculateRowNumberForLocation: (int) location{
    int rowNumber = location / _numberOfColumns;
    int remainder = location % _numberOfColumns;
    if(remainder > 0)
        rowNumber++;
    
    return rowNumber;
}

- (int)calculateColumnNumberForLocation: (int) location{
    int columnNumber = location % _numberOfColumns;
    if(columnNumber == 0)
        columnNumber = _numberOfColumns;
    
    return columnNumber;
}

- (void)setDimensionsWithWidth: (double)availableWidth andHeight: (double) availableHeight{
    bubbleDefaultWidth = [Bubble getConfiguredWidth];
    bubbleDefaultHeight = [Bubble getConfiguredHeight];

    _numberOfColumns = (int)availableWidth / (int)bubbleDefaultWidth;
    _numberOfRows = (int)availableHeight / (int)bubbleDefaultHeight;
    
    int rowDivisor = _numberOfRows - 1;
    if(rowDivisor < 1)  //In case we can only fit in one row
        rowDivisor = 1;
    
    int columnDivisor = _numberOfColumns - 1;
    if(columnDivisor < 1) //In case we can only fit in one column
        columnDivisor = 1;
    
    _rowSpacing = (availableHeight - (_numberOfRows * bubbleDefaultHeight)) / rowDivisor;
    _columnSpacing = (availableWidth - (_numberOfColumns * bubbleDefaultWidth)) / columnDivisor;
}


- (void)updateScoreWithColor:(id)sender{
    Bubble *bubble = (Bubble*) sender;
    NSInteger scoreToAdd = [bubble gamepoints];
     if(lastPoppedBubble == bubble.colour)
         scoreToAdd *= 1.5;
     
     _pageScore += scoreToAdd;
    lastPoppedBubble = bubble.colour;
    [bubble removeFromSuperview];
}

- (void)readjustSizeWithWidth: (double)availableWidth andHeight: (double) availableHeight{
    [self setDimensionsWithWidth:availableWidth andHeight:availableHeight];
    [self refillWithBubbles];
}

@end
