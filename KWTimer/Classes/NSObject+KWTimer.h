//
//  NSObject+KWTimer.h
//  Pods
//
//  Created by kevin on 2017/5/27.
//
//

#import <Foundation/Foundation.h>

@class KWTimer;

/** add time interval event */
@interface NSObject (KWTimer)

/**
 add interval event to caller, default time interval is 0.3s, default thread is current thread

 @param action exec action
 */
- (void)addIntervalAction:(SEL)action;

/**
 add interval event to target, default time interval is 0.3s, default thread is current thread

 @param action exec action
 @param target exec target
 */
- (void)addIntervalAction:(SEL)action forTarget:(id)target;

/**
 add interval event to caller, default thread is current thread

 @param action exec action
 @param interval event exec interval,the interval can't less than 0.1s,othewise add will be failed
 */
- (void)addIntervalAction:(SEL)action withInterval:(NSTimeInterval)interval;


/**
 add interval event to target, default thread is current thread

 @param action exec action
 @param target exec target
 @param interval event exec interval,the interval can't less than 0.1s,othewise add will be failed
 */
- (void)addIntervalAction:(SEL)action forTarget:(id)target withInterval:(NSTimeInterval)interval;

/**
 add interval event to target, you can use this method select a backgroud thread or main thread

 @param action exec action
 @param target exec target
 @param interval event exec interval,the interval can't less than 0.1s,othewise add will be failed
 @param thread the thread that the action will be exec in(on)
 */
- (void)addIntervalAction:(SEL)action forTarget:(id)target withInterval:(NSTimeInterval)interval inThread:(NSThread *)thread;

/**
 remove all actions of caller, if all time interval actions are removed the timer will be stop running
 */
- (void)removeIntervalActions;

/**
 remove the action of caller you selected, if all time interval actions are removed the timer will be stop running

 @param action the action that you want to remove
 */
- (void)removeIntervalAction:(SEL)action;

/**
 remove the action of target you selected, if all time interval actions are removed the timer will be stop running

 @param action the action of target that you want to remove
 @param target the target that you want to remove action
 */
- (void)removeIntervalAction:(SEL)action forTarget:(id)target;

@end
