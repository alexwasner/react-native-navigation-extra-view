//
//  RNNExtraViewWrapper.m
//  RNNExtraView
//
//  Created by alexwasner on 2/1/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "RNNExtraViewWrapper.h"

@interface RNNExtraViewWrapper ()
@property (nonatomic, strong) UIView *subView;
@end

@implementation RNNExtraViewWrapper


-(instancetype)initWithFrame:(CGRect)frame subView:(UIView*)subView{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.subView = subView;
        self.subView.backgroundColor = [UIColor clearColor];
        
        subView.frame = self.bounds;
        [self addSubview:subView];
    }
    
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    for (UIView *sub in [self.subView.subviews reverseObjectEnumerator]) {
        if (!sub.isHidden && sub.isUserInteractionEnabled && sub.alpha > 0) {
            for (UIView *deeperSub in [sub.subviews reverseObjectEnumerator]) {
                if (!deeperSub.isHidden && deeperSub.isUserInteractionEnabled && deeperSub.alpha > 0) {
                    CGPoint convertedPoint = [deeperSub convertPoint:point fromView:self.subView];
                    UIView *subviewHitTestView = [deeperSub hitTest:convertedPoint withEvent:event];
                    if (subviewHitTestView != nil) {
                        return subviewHitTestView;
                    }
                }
            }
        }
    }
    return nil;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.subView.frame = self.bounds;
}

@end
