//
//  MagicBook.m
//  SampleObjectiveC
//
//  Created by Rong Hao on 13-7-31.
//  Copyright (c) 2013年 Leap Motion. All rights reserved.
//

#import "MagicBook.h"

@implementation MagicBook


- (id)initWithWord
{
    if (self = [super init]) {
        self.dragonSlayer = [NSMutableArray arrayWithObjects:@"比黄昏还要昏暗的东西", @"比血液还要鲜红的东西", @"在时间之流中出现吧", @"在您的伟大的名下", @"我在这黑暗中起誓", @"把阻挡在我们前方", @"所有的愚蠢之物", @"集合你我之力", @"赐与他们平等的毁灭吧!赐予他们平等的毁灭吧", nil];
        self.shinning = [NSMutableArray arrayWithObjects:@"是落课实施了湿了吃了颗死了可", nil];
//        self.keyStarPositions = [self createKeyStarPositions];
        
    }
    
    return self;
}


- (NSArray *)createKeyStarPositions
{
    NSMutableArray *positionArray = [NSMutableArray array];
    for (int i = 0; i < SCREEN_HEIGHT / 20; i++) {
        for (int j = 0; i < SCREEN_WIDTH / 20; j++) {
            CGPoint point = CGPointMake(i * 20, j * 20);
            Star *star = [[Star alloc] init];
            star.starPosition = point;
            star.forceType = [self checkForceType:point];
            [positionArray addObject:star];
        }
    }
    
    return [NSArray arrayWithArray:positionArray];
}


- (ForceType)checkForceType:(CGPoint)point;
{
    if (self.currentForceType == FTNULL) {
        
        if (point.x > SCREEN_WIDTH * 0.5) {
            if (point.y > SCREEN_HEIGHT * 0.5) {
                _currentForceType = FTShadow;
            } else {
                _currentForceType = FTLight;
            }
        } else {
            if (point.y > SCREEN_HEIGHT * 0.5) {
                _currentForceType = FTWater;
            } else {
                _currentForceType = FTFire;
            }
        }
    }
    return _currentForceType;
}

- (void)cancelCast
{
    self.currentForceType = FTNULL;
}
@end
