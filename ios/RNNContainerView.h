//
//  RNContainerView.h
//  RNNExtraView
//
//  Created by alexwasner on 2/1/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RNContainerView : UIView

-(instancetype)initWithFrame:(CGRect)frame subView:(UIView*)subView alignment:(NSString*)alignment;

@end

