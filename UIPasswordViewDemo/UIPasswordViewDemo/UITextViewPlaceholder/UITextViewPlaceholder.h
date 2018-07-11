//
//  UITextViewPlaceholder.h
//  Cambodia
//
//  Created by quan on 2017/4/21.
//  Copyright © 2017年 JXG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextViewPlaceholder : UITextView<UITextViewDelegate>
- (void)setPlaceholder:(NSString *)aPlaceholder PlaceholderTextColor:(UIColor *)placeholderTextColor RealTextColor:(UIColor *)aRealTextColor;
@end
