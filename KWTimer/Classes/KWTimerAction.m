//
//  KWTimerAction.m
//  Pods
//
//  Created by kevin on 2017/5/27.
//
//

#import "KWTimerAction.h"

@implementation KWTimerAction

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[self class]]) {
        typeof(self) o = object;
        if (o.target == self.target && [NSStringFromSelector(o.action) isEqualToString:NSStringFromSelector(self.action)]) {
            return YES;
        }
        return NO;
    }
    return [super isEqual:object];
}

@end
