//
//  NSObject+KWTimer.h
//  Pods
//
//  Created by kevin on 2017/5/27.
//
//

#import <Foundation/Foundation.h>

@class KWTimer;

/** 为NSObject添加定时任务，默认0.3秒调用一次 */
@interface NSObject (KWTimer)

/** 指定需要定时调用某一对象的某一方法 */
- (void)addIntervalAction:(SEL)action;

- (void)addIntervalAction:(SEL)action forTarget:(id)target;

- (void)addIntervalAction:(SEL)action withInterval:(NSTimeInterval)interval;

- (void)addIntervalAction:(SEL)action forTarget:(id)target withInterval:(NSTimeInterval)interval;

- (void)addIntervalAction:(SEL)action forTarget:(id)target withInterval:(NSTimeInterval)interval inThread:(NSThread *)thread;

- (void)removeIntervalActions;

- (void)removeIntervalAction:(SEL)action;

- (void)removeIntervalAction:(SEL)action forTarget:(id)target;

@end
