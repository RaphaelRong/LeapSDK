/******************************************************************************\
* Copyright (C) 2012-2013 Leap Motion, Inc. All rights reserved.               *
* Leap Motion proprietary and confidential. Not for distribution.              *
* Use subject to the terms of the Leap Motion SDK Agreement available at       *
* https://developer.leapmotion.com/sdk_agreement, or another agreement         *
* between Leap Motion and you, your company or other organization.             *
\******************************************************************************/

#import <Foundation/Foundation.h>
#import "LeapObjectiveC.h"

@protocol SampleDelegate <NSObject>

- (void)onLeapMotionSwip:(LeapVector *)vector;
- (void)onLeapMotionCycleClockwise:(CGFloat)sweptAngle;
- (void)onLeapMotionCycleCounterClockwise:(CGFloat)sweptAngle;

@optional
- (void)getFingerPosition:(CGPoint)point;

@end

@interface Sample : NSObject<LeapListener>

@property (nonatomic, weak) id<SampleDelegate> delegate;

-(void)run;

@end
