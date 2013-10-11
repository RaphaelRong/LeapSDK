/******************************************************************************\
* Copyright (C) 2012-2013 Leap Motion, Inc. All rights reserved.               *
* Leap Motion proprietary and confidential. Not for distribution.              *
* Use subject to the terms of the Leap Motion SDK Agreement available at       *
* https://developer.leapmotion.com/sdk_agreement, or another agreement         *
* between Leap Motion and you, your company or other organization.             *
\******************************************************************************/

#import <Cocoa/Cocoa.h>
#import "BLE.h"
#import "Sample.h"
#import "DWFParticleView.h"
#import "GCDAsyncSocket.h"
#import "MagicBook.h"

@class Sample;

@interface AppDelegate : NSObject <NSApplicationDelegate, BLEDelegate, SampleDelegate, GCDAsyncSocketDelegate>
{
    GCDAsyncSocket *socket;
    GCDAsyncSocket *s;
}
@property(strong)  GCDAsyncSocket *socket;

@property (weak) IBOutlet NSSegmentedControl *segSwitch;
@property (weak) IBOutlet NSTextField *rssiValue;
@property (weak) IBOutlet NSButton *connectButton;
@property (weak) IBOutlet NSProgressIndicator *indicate;
@property (weak) IBOutlet DWFParticleView *particleView;
@property (weak) IBOutlet NSTextField *portText;
@property (weak) IBOutlet NSTextField *socketStatus;

@property (weak) IBOutlet NSTextField *wordOne;
@property (weak) IBOutlet NSTextField *wordTwo;
@property (weak) IBOutlet NSTextField *wordThree;
@property (weak) IBOutlet NSTextField *wordFour;
@property (weak) IBOutlet NSTextField *wordFive;
@property (weak) IBOutlet NSTextField *wordSix;
@property (weak) IBOutlet NSTextField *wordSeven;
@property (weak) IBOutlet NSTextField *wordEight;


@property (nonatomic, strong, readwrite)IBOutlet NSWindow *window;
@property (nonatomic, strong, readwrite)Sample *sample;
@property (nonatomic, strong, readwrite)BLE *ble;
@property (nonatomic, strong) MagicBook *magicBook;

@property (nonatomic) CGFloat clockwiseAngle;
@property (nonatomic) CGFloat counterClockwiseAngle;
@property (nonatomic) NSTimeInterval lastTime;
@property (nonatomic) BOOL isStartSpeak;

@end
