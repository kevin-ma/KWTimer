//
//  KWTimer.h
//  Pods
//
//  Created by kevin on 2017/5/27.
//
//

#import <Foundation/Foundation.h>
#import "NSObject+KWTimer.h"

@class KWTimerAction;

@interface KWTimer : NSObject

@property (nonatomic, strong) NSMutableArray<KWTimerAction *> *actions;

/** 时间间隔 */
@property (nonatomic, assign) NSTimeInterval timeInterval;

@property (nonatomic, assign,getter=isWorking) BOOL working;

+ (instancetype)sharedInstance;

- (void)stopTimer;

- (void)startTimer;

- (void)addAction:(SEL)action forTarget:(id)target withInterval:(NSTimeInterval)interval inThread:(NSThread *)thread;

- (void)removeAction:(SEL)action ofTarget:(id)target;

- (void)removeActionsOfTarget:(id)target;

- (void)removeActionAtIndex:(NSInteger)index;

- (BOOL)containsAction:(SEL)action ofTarget:(id)target;
@end
