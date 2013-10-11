//
//  DWFParticleView.m
//  DrawWithFire
//
//  Created by Ray Wenderlich on 10/6/11.
//  Copyright 2011 Razeware LLC. All rights reserved.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "DWFParticleView.h"
#import <QuartzCore/QuartzCore.h>

@implementation DWFParticleView
{
    CAEmitterLayer* fireEmitter; //1
}
-(void)awakeFromNib
{
	_rootLayer = [CALayer layer];
    
	_rootLayer.bounds = CGRectMake(0, 0, 640, 480);
	CGColorRef color = CGColorCreateGenericRGB(0.5, 0.5, 0.5, 0.5);
	_rootLayer.backgroundColor = color;
	CGColorRelease(color);
    
    //set ref to the layer
    fireEmitter = [CAEmitterLayer layer]; //2
    //configure the emitter layer
    fireEmitter.emitterPosition = CGPointMake(50, 50);
    fireEmitter.emitterSize = CGSizeMake(10, 10);
    
	const char* fileName = [[[NSBundle mainBundle] pathForResource:@"Particles_fire" ofType:@"png"] UTF8String];
	CGDataProviderRef dataProvider = CGDataProviderCreateWithFilename(fileName);
	id img = (id) CFBridgingRelease(CGImageCreateWithPNGDataProvider(dataProvider, NULL, NO, kCGRenderingIntentDefault));
    
    CAEmitterCell* fire = [CAEmitterCell emitterCell];
    fire.birthRate = 200;
    fire.lifetime = 3.0;
    fire.lifetimeRange = 0.5;
    fire.color = CGColorCreateGenericRGB(0.8, 0.4, 0.2, 1);
    fire.contents = img;
    [fire setName:@"fire"];
    
    fire.yAcceleration = 0;
    fire.xAcceleration = 0;
//    fire.
//    fire.velocity = 10;
//    fire.velocityRange = 20;
    fire.emissionRange = M_2_PI;
    
//    fire.scaleSpeed = 0.3;
    fire.spin = 1;
    
    fireEmitter.renderMode = kCAEmitterLayerAdditive;
    
    //add the cell to the layer and we're done
    fireEmitter.emitterCells = [NSArray arrayWithObject:fire];
    [self.rootLayer addSublayer:fireEmitter];
	[self setLayer:self.rootLayer];
	[self setWantsLayer:YES];
	
	//Force the view to update
	[self setNeedsDisplay:YES];
    
}

+ (Class) layerClass //3
{
    //configure the UIView to have emitter layer
    return [CAEmitterLayer class];
}

-(void)setEmitterPositionFromPoint: (CGPoint)point
{
    //change the emitter's position
    fireEmitter.emitterPosition = CGPointMake(point.x, point.y);
}

-(void)setIsEmitting:(BOOL)isEmitting
{
    [fireEmitter setValue:[NSNumber numberWithInt:isEmitting?200:0] forKey:@"emitterCells.fire.birthRate"];
}
//- (void)mouseDown:(NSEvent *)theEvent
//{
//    NSPoint point = theEvent.locationInWindow;
//    
//    NSLog(@"%f, %f", point.x, point.y);
//    fireEmitter.emitterPosition = CGPointMake(point.x, point.y);
//}
//
//- (void)mouseMoved:(NSEvent *)theEvent
//{
//    NSLog(@"move");
//    NSPoint point = theEvent.locationInWindow;
//    fireEmitter.emitterPosition = CGPointMake(point.x, point.y);
//    
//}


@end
