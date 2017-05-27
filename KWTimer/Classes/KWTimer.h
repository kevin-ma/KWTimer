//
//  KWTimer.h
//  Pods
//
//  Created by kevin on 2017/5/27.
//
//

#import <Foundation/Foundation.h>
#import "NSObject+KWTimer.h"

/** DON'T USE THE CLASS **/
/** USE NSObject+KWTimer PLEASE **/

@class KWTimerAction;

/** this is single instance of main part IN KWTimer,
    ** DON'T USE THE CLASS **
 */
@interface KWTimer : NSObject

/** the property of timer,
    it can tell you if the timer is working,
    you should not change this via kvc or other way
 */
@property (nonatomic, assign,readonly ,getter=isWorking) BOOL working;

/**
 get the single instance,
 you may create one by yourself, but i don't think you need do this

 @return the single instance
 */
+ (instancetype)sharedInstance;


/**
 add interval action of target to timer

 @param action exec action
 @param target exec target
 @param interval exec interval
 @param thread exec in(on) this thread
 */
- (void)addAction:(SEL)action forTarget:(id)target withInterval:(NSTimeInterval)interval inThread:(NSThread *)thread;

/**
 remove interval action of target

 @param action remove action of target
 @param target the target of remove action
 */
- (void)removeAction:(SEL)action ofTarget:(id)target;

/**
 remove all interval actions of target

 @param target the target of remove actions
 */
- (void)removeActionsOfTarget:(id)target;

/**
 you can check you action if working via the method

 @param action the action you will check
 @param target the target you will check
 @return the result of contains
 */
- (BOOL)containsAction:(SEL)action ofTarget:(id)target;
@end
