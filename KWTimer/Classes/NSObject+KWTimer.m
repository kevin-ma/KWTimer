//
//  NSObject+KWTimer.m
//  Pods
//
//  Created by kevin on 2017/5/27.
//
//

#import "NSObject+KWTimer.h"
#import "KWTimer.h"

@implementation NSObject (KWTimer)

- (void)addIntervalAction:(SEL)action
{
    [self addIntervalAction:action forTarget:self withInterval:0.3 inThread:nil];
}

- (void)addIntervalAction:(SEL)action forTarget:(id)target
{
    [self addIntervalAction:action forTarget:target withInterval:0.3 inThread:nil];
}

- (void)addIntervalAction:(SEL)action withInterval:(NSTimeInterval)interval
{
    [self addIntervalAction:action forTarget:self withInterval:interval inThread:nil];
}

- (void)addIntervalAction:(SEL)action forTarget:(id)target withInterval:(NSTimeInterval)interval
{
    [self addIntervalAction:action forTarget:target withInterval:interval inThread:nil];
}

- (void)addIntervalAction:(SEL)action forTarget:(id)target withInterval:(NSTimeInterval)interval inThread:(NSThread *)thread
{
    KWTimer *timer = [KWTimer sharedInstance];
    [timer addAction:action forTarget:target withInterval:interval inThread:thread];
}

- (void)removeIntervalActions
{
    KWTimer *timer = [KWTimer sharedInstance];
    [timer removeActionsOfTarget:self];
}

- (void)removeIntervalAction:(SEL)action
{
    [self removeIntervalAction:action forTarget:self];
}

- (void)removeIntervalAction:(SEL)action forTarget:(id)target
{
    KWTimer *timer = [KWTimer sharedInstance];
    [timer removeAction:action ofTarget:self];
}

@end
