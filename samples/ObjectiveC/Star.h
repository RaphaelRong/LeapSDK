//
//  Star.h
//  SampleObjectiveC
//
//  Created by Rong Hao on 13-8-2.
//  Copyright (c) 2013年 Leap Motion. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MagicType) {
    MTNULL,
    MTDragonSlave,
    MTSeaBlast,
    MTFlushToilets,
    MTOpenFaucet,
    MTCloseFaucet,
    MTShinning,
    MTShadow
};

typedef NS_ENUM(NSInteger, ForceType) {
    FTNULL,
    FTLight,
    FTShadow,
    FTWater,
    FTFire
    
};
@interface Star : NSObject

@property (nonatomic) CGPoint starPosition;
@property (nonatomic) ForceType forceType;

@end
