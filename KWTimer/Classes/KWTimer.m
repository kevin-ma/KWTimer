//
//  KWTimer.m
//  Pods
//
//  Created by kevin on 2017/5/27.
//
//

#import "KWTimer.h"
#import "KWTimerAction.h"

@interface KWTimer ()
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSInteger counter;
@end


@implementation KWTimer
+ (instancetype)sharedInstance
{
    static KWTimer *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
        
    });
    return _instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        _actions = [[NSMutableArray alloc] init];
        _timeInterval = 0.1f;
    }
    return self;
}

- (BOOL)containsAction:(SEL)action ofTarget:(id)target
{
    for (KWTimerAction *act in self.actions) {
        if (act.target == target && [NSStringFromSelector(action) isEqualToString:NSStringFromSelector(act.action)]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)containsAction:(KWTimerAction *)action
{
    for (KWTimerAction *act in self.actions) {
        if ([act isEqual:action]) {
            return YES;
        }
    }
    return NO;
}

- (void)addAction:(SEL)action forTarget:(id)target withInterval:(NSTimeInterval)interval inThread:(NSThread *)thread
{
    if (!action || !target || interval < 0.1) return;
    @synchronized(self) {
        KWTimerAction *actionOjc = [[KWTimerAction alloc] init];
        actionOjc.action = action;
        actionOjc.target = target;
        actionOjc.interval = interval;
        actionOjc.thread = thread ?: [NSThread currentThread];
        if ([self containsAction:actionOjc]) {
            [self removeAction:action ofTarget:target];
        }
        [_actions addObject:actionOjc];
        if (_actions.count > 0) {
            [self startTimer];
        }
    }
}

- (void)removeAction:(SEL)action ofTarget:(id)target
{
    @synchronized(self) {
        NSInteger index = 0;
        for (KWTimerAction *act in self.actions) {
            if (act.target == target && [NSStringFromSelector(action) isEqualToString:NSStringFromSelector(act.action)]) {
                [_actions removeObjectAtIndex:index];
                break;
            }
            index++;
        }
        if (_actions.count == 0) {
            [self stopTimer];
        }
    }
}

- (void)removeActionsOfTarget:(id)target
{
    @synchronized(self) {
        for (NSInteger i = _actions.count - 1; i >= 0; i--) {
            KWTimerAction *act = _actions[i];
            if (act.target == target) {
                [_actions removeObjectAtIndex:i];
            }
        }
        if (_actions.count == 0) {
            [self stopTimer];
        }
    }
}

- (void)removeActionAtIndex:(NSInteger)index
{
    @synchronized(self) {
        if (index >= 0 && index < _actions.count) {
            [_actions removeObjectAtIndex:index];
            
            if (_actions.count == 0) {
                [self stopTimer];
            }
        }
    }
}

- (void)execTimeActions
{
    _counter ++;
    [_actions enumerateObjectsUsingBlock:^(KWTimerAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger counter = (NSInteger)(floor(obj.interval * 10));
        if (_counter % counter == 0) {
            [obj.target performSelector:obj.action onThread:obj.thread withObject:nil waitUntilDone:YES];
        }

    }];
    if (_counter >= 100000) {
        _counter = 0;
    }
}

- (void)stopTimer
{
    if (!_working) {
        return;
    }
    
    [self.timer setFireDate:[NSDate distantFuture]];
    self.working = NO;
}

- (void)startTimer
{
    if (_working) {
        return;
    }
    
    if (self.timer) {
        [self.timer setFireDate:[NSDate date]];
    }else{
        self.timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target:self selector:@selector(execTimeActions) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    self.working = YES;
}
@end

