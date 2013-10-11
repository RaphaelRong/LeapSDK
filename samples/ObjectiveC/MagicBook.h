//
//  MagicBook.h
//  SampleObjectiveC
//
//  Created by Rong Hao on 13-7-31.
//  Copyright (c) 2013年 Leap Motion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constant.h"
#import "Star.h"

@interface MagicBook : NSObject

@property (nonatomic, strong) NSMutableArray *dragonSlayer;
@property (nonatomic, strong) NSMutableArray *shinning;
@property (nonatomic, strong) NSArray *keyStarPositions;


@property (nonatomic) MagicType currentMagicType;
@property (nonatomic) ForceType currentForceType;

- (id)initWithWord;

- (ForceType)checkForceType:(CGPoint)point;

- (void)cancelCast;

@end
