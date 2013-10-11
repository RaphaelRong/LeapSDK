//
//  Spell.m
//  SampleObjectiveC
//
//  Created by Rong Hao on 13-8-2.
//  Copyright (c) 2013年 Leap Motion. All rights reserved.
//

#import "Spell.h"

@implementation SpellRegin

- (id)initWithRegin:(CGRect)regin
{
    if (self = [super init]) {
        self.regin = regin;
    }
    return self;
}

@end

@implementation Spell

- (id)init
{
    if (self = [super init]) {
        NSMutableArray *reginArray = [NSMutableArray array];
        SpellRegin *spellReginOne = [[SpellRegin alloc] initWithRegin:CGRectMake(50, 50, REGIN_SIZE, REGIN_SIZE)];
        SpellRegin *spellReginTwo = [[SpellRegin alloc] initWithRegin:CGRectMake(550, 50, REGIN_SIZE, REGIN_SIZE)];
        SpellRegin *spellReginThree = [[SpellRegin alloc] initWithRegin:CGRectMake(300, 300, REGIN_SIZE, REGIN_SIZE)];
        SpellRegin *spellReginFour = [[SpellRegin alloc] initWithRegin:CGRectMake(50, 50, REGIN_SIZE, REGIN_SIZE)];
        [reginArray addObject:spellReginOne];
        [reginArray addObject:spellReginTwo];
        [reginArray addObject:spellReginThree];
        [reginArray addObject:spellReginFour];
        self.spellRegins = reginArray;
        
    }
    
    return self;
}

@end
