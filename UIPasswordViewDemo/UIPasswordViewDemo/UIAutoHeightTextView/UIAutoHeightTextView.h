//
//  UIAutoHeightTextView.h
//  Cambodia
//
//  Created by quan on 2017/12/26.
//  Copyright © 2017年 JXG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextViewPlaceholder.h"

@class UIAutoHeightTextView;
@protocol UIAutoHeightTextViewDelegate <NSObject>

-(void)textViewResetSize:(CGSize)size;

@end

@interface UIAutoHeightTextView : UITextViewPlaceholder<UITextViewDelegate>

@property (nonatomic,retain) id<UIAutoHeightTextViewDelegate> autoDelegate;

- (void)textViewDidChange:(UITextView *)textView;

/**
 限制最大行数.
 */
@property (nonatomic, assign) NSInteger maxLineNum;

@end
