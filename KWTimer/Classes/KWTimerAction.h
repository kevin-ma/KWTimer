//
//  KWTimerAction.h
//  Pods
//
//  Created by kevin on 2017/5/27.
//
//

#import <Foundation/Foundation.h>

@interface KWTimerAction : NSObject

@property (nonatomic, weak) id target;

@property (nonatomic, assign) SEL action;

@property (nonatomic, weak) NSThread *thread;

@property (nonatomic, assign) NSTimeInterval interval;

@end
