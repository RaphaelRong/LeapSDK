//
//  Spell.h
//  SampleObjectiveC
//
//  Created by Rong Hao on 13-8-2.
//  Copyright (c) 2013年 Leap Motion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constant.h"

@interface SpellRegin : NSObject

@property (nonatomic) CGRect regin;

- (id)initWithRegin:(CGRect)regin;

@end


@interface Spell : NSObject

@property (nonatomic, strong) NSMutableArray *spellRegins;
@property (nonatomic, strong) NSMutableArray *spellWords;

@end
