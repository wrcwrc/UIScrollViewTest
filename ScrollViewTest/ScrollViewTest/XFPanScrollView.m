//
//  XFPanScrollView.m
//  XF_xproject
//
//  Created by 韦荣炽 on 2018/1/16.
//  Copyright © 2018年 XingFei_韦荣炽. All rights reserved.
//  滚动的嵌套视图父级View

#import "XFPanScrollView.h"

@implementation XFPanScrollView

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(nonnull UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
