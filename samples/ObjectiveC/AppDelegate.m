/******************************************************************************\
* Copyright (C) 2012-2013 Leap Motion, Inc. All rights reserved.               *
* Leap Motion proprietary and confidential. Not for distribution.              *
* Use subject to the terms of the Leap Motion SDK Agreement available at       *
* https://developer.leapmotion.com/sdk_agreement, or another agreement         *
* between Leap Motion and you, your company or other organization.             *
\******************************************************************************/

#import "AppDelegate.h"
#import "Sample.h"

@implementation AppDelegate

// Xcode 4.2 warns if we do not explicitly synthesize
@synthesize window = _window;
@synthesize sample = _sample; // must retain for notifications

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    _portText.stringValue = @"54321";
    _sample = [[Sample alloc]init];
    _sample.delegate = self;
    [_sample run];
    
    _ble = [[BLE alloc] init];
    [_ble controlSetup:1];
    _ble.delegate = self;
    
    self.magicBook = [[MagicBook alloc] initWithWord];
}

#pragma mark BLE Start ========>>>
-(void) bleDidConnect
{
    NSLog(@"->Connected");
    
    self.connectButton.title = @"Disconnect";
    [self.indicate stopAnimation:self];
    
    self.segSwitch.enabled = true;
    
    self.segSwitch.selectedSegment = 1;
}

- (void)bleDidDisconnect
{
    NSLog(@"->Disconnected");
    
    self.connectButton.title = @"Connect";
    
    self.segSwitch.enabled = false;
    
    self.rssiValue.stringValue = @"----";
}

-(void) bleDidReceiveData:(unsigned char *)data length:(int)length
{
    NSLog(@"Length: %d", length);
    
    // parse data, all commands are in 3-byte
    for (int i = 0; i < length; i+=3)
    {
        NSLog(@"0x%02X, 0x%02X, 0x%02X", data[i], data[i+1], data[i+2]);
        
    }
}

-(void) bleDidUpdateRSSI:(NSNumber *) rssi
{
    self.rssiValue.stringValue = rssi.stringValue;
}

- (IBAction)connectButtonPressed:(id)sender {
    if (self.ble.activePeripheral)
        if(self.ble.activePeripheral.isConnected)
        {
            [[self.ble CM] cancelPeripheralConnection:[self.ble activePeripheral]];
            return;
        }
    
    if (self.ble.peripherals)
        self.ble.peripherals = nil;
    
    [self.ble findBLEPeripherals:2];
    
    [NSTimer scheduledTimerWithTimeInterval:(float)2.0 target:self selector:@selector(connectionTimer:) userInfo:nil repeats:NO];
    
    [self.indicate startAnimation:self];

}

-(void) connectionTimer:(NSTimer *)timer
{
    if (self.ble.peripherals.count > 0)
    {
        [self.ble connectPeripheral:[self.ble.peripherals objectAtIndex:0]];
    }
    else
    {
        [self.indicate stopAnimation:self];
    }
}

- (IBAction)segSwitchPressed:(NSSegmentedControl *)sender {
    UInt8 buf[3] = {0x01, 0x00, 0x00};
    
    if (self.segSwitch.selectedSegment == 0)
        buf[1] = 0x01;
    else
        buf[1] = 0x00;
    
    NSData *data = [[NSData alloc] initWithBytes:buf length:3];
    [_ble write:data];
}
#pragma mark BLE End ===========<<<<

#pragma mark Socket Start ========>>>>
- (IBAction)startListen:(NSButton *)sender {
    NSLog(@"listen");
    
    socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSError *err = nil;
    if(![socket acceptOnPort:[_portText integerValue] error:&err])
    {
        NSLog(@"err:%@", err.description);
        self.socketStatus.stringValue = @"连接失败";
    }else
    {
        self.socketStatus.stringValue = [NSString stringWithFormat:@"开始监听%@端口.",_portText.stringValue];
    }
}

- (void)socket:(GCDAsyncSocket *)sender didAcceptNewSocket:(GCDAsyncSocket *)newSocket
{
    // The "sender" parameter is the listenSocket we created.
    // The "newSocket" is a new instance of GCDAsyncSocket.
    // It represents the accepted incoming client connection.
    
    // Do server stuff with newSocket...
    self.socketStatus.stringValue = [NSString stringWithFormat:@"建立与%@的连接",newSocket.connectedHost];
    
    s = newSocket;
    s.delegate = self;
    [s readDataWithTimeout:-1 tag:0];
}

-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *receive = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", [NSString stringWithFormat:@"%@:%@",sock.connectedHost,receive]);
    
    
//    NSUInteger tagValue = 999;
//    
//    for (NSString *word in self.magicBook.dragonSlayer) {
//        if ([word rangeOfString:receive].length > 0) {
//            tagValue = [self.magicBook.dragonSlayer indexOfObject:word] + 101;
//            NSTextField *aLabel = [self.particleView viewWithTag:tagValue];
//            aLabel.stringValue = word;
//            break;
//        }
//    }
//    
//    if (tagValue != 999) {
//        [self.magicBook.dragonSlayer replaceObjectAtIndex:tagValue - 101 withObject:@"readout"];
//    }
//    
    
    
}
- (IBAction)fakeInfoButton:(id)sender {
    [self sendDataString:((NSButton *)sender).stringValue];
}

- (void)sendDataString:(NSString *)dataString
{
    
    UInt8 buf[3] = {0x01, 0x00, 0x00};
    if ([dataString isEqualToString:@"SpeakAccept"]) {
        
        buf[1] = 0x01;
        
        NSData *data = [[NSData alloc] initWithBytes:buf length:3];
        [_ble write:data];
    }
    if ([dataString isEqualToString:@"SpeakReject"]) {
        
        buf[1] = 0x00;
        
        NSData *data = [[NSData alloc] initWithBytes:buf length:3];
        [_ble write:data];
    }
    
    NSData *data = [[NSData alloc] initWithBytes:buf length:3];
    [_ble write:data];
    
    
    NSLog(@"send");
    dataString = [NSString stringWithFormat:@"%@%f", dataString, self.lastTime];
    [s writeData:[dataString dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
    [s readDataWithTimeout:-1 tag:0];
    
}
#pragma mark BLE END =========<<<<

#pragma mark LeapMotionDelegate Start =========>>>>

- (void)getFingerPosition:(CGPoint)point
{
    CGFloat width = self.particleView.frame.size.width * 0.5;
    //    NSLog(@"%f, %f", width  + point.x, point.y);
    [self.particleView setEmitterPositionFromPoint:CGPointMake((width + point.x * 2), (point.y - 100) * 2)];
    
    NSString *dataString = [NSString stringWithFormat:@"position%f, %f",point.x, point.y];
    
    NSLog(@"send:%@", dataString);
    [self.socket writeData:[dataString dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
}

- (BOOL)isTimeEffect:(NSDate *)time
{
    NSTimeInterval timeInterval = [time timeIntervalSince1970] - self.lastTime;
    self.lastTime = [time timeIntervalSince1970];
    return timeInterval < 2;
}

- (void)onLeapMotionCycleCounterClockwise:(CGFloat)sweptAngle
{
    if (self.isStartSpeak && [self isTimeEffect:[NSDate date]]) {
        self.counterClockwiseAngle += sweptAngle;
        if (self.counterClockwiseAngle > 3) {
            self.counterClockwiseAngle = 0;
            NSLog(@"counterclockwise");
            [self sendDataString:@"SpeakReject"];
            self.isStartSpeak = NO;
        }
    } else {
        self.counterClockwiseAngle = 0;
    }
}

- (void)onLeapMotionCycleClockwise:(CGFloat)sweptAngle
{
    //    NSLog(@"cycle");
    
    if (!self.isStartSpeak && [self isTimeEffect:[NSDate date]]) {
        self.clockwiseAngle += sweptAngle;
        if (self.clockwiseAngle > 3) {
            self.clockwiseAngle = 0;
            NSLog(@"clockwise");
            [self sendDataString:@"SpeakAccept"];
            self.isStartSpeak = YES;
        }
    } else {
        self.counterClockwiseAngle = 0;
    }
}

- (void)onLeapMotionSwip:(LeapVector *)vector
{
    if (_ble.isConnected == NO) {
        return;
    }
    
    UInt8 i = vector.x > 0 ? 0x01 : 0x00;
    
    UInt8 buf[3] = {0x01, i, 0x00};
    
    NSData *data = [[NSData alloc] initWithBytes:buf length:3];
    [_ble write:data];
}
#pragma mark LeapMotionDelegate End ========<<<<

#pragma mark path track Start =========>>>>


#pragma mark path track End =========>>>>

@end
