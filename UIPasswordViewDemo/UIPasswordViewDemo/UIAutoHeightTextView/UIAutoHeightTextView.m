//
//  UIAutoHeightTextView.m
//  Cambodia
//
//  Created by quan on 2017/12/26.
//  Copyright © 2017年 JXG. All rights reserved.
//

#import "UIAutoHeightTextView.h"

@interface UIAutoHeightTextView ()

@end

@implementation UIAutoHeightTextView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setDelegate:self];
    //限制最大行数.
    self.maxLineNum = 40;
    self.layoutManager.allowsNonContiguousLayout = NO;
    [self setScrollEnabled:YES];
    // Initialization code
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        //隐藏键盘
//        [[[UIApplication sharedApplication] keyWindow]endEditing:NO];
        [textView resignFirstResponder];
        return NO;
    }
    
//    NSString *textString = textView.text;
    CGSize fontSize = [@"一行高度" sizeWithAttributes:@{NSFontAttributeName:textView.font}];
    
    NSString* newText = [textView.text stringByReplacingCharactersInRange:range withString:text];
    CGSize tallerSize = CGSizeMake(textView.frame.size.width-15,textView.frame.size.height*2);
    
    CGSize newSize = [newText boundingRectWithSize:tallerSize
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName: textView.font}
                                           context:nil].size;
    NSInteger newLineNum = newSize.height / fontSize.height;
    
    if ((newLineNum <= self.maxLineNum)
        && newSize.width < textView.frame.size.width-16)
    {
        return YES;
    }else{
        return NO;
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    //如果用户一直在输入内容的状态的时候，不改变内容textView的大小 如果有高亮选择的字，就不进行判断。
    UITextRange *selectedRange = [textView  markedTextRange];
    UITextPosition *position =  [textView  positionFromPosition:selectedRange.start offset:0];
    if (position) {
        return;
    }
    
//    CGRect frame = textView.frame;
    CGRect bounds = textView.bounds;
    // 计算 text view 的高度
    CGSize maxSize = CGSizeMake(bounds.size.width, CGFLOAT_MAX);
    CGSize newSize = [textView sizeThatFits:maxSize];
    if (newSize.width<bounds.size.width) {
        newSize.width = bounds.size.width;
    }
    
    //改变UITableView ListArray 的数据
    if ([self.autoDelegate respondsToSelector:@selector(textViewResetSize:)]) {
        [self.autoDelegate textViewResetSize:newSize];
    }    
}
//让 UITextView 适配中文 中文不跳
#pragma mark UITextView
- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if(floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        CGRect r = [textView caretRectForPosition:textView.selectedTextRange.end];
        CGFloat caretY =  MAX(r.origin.y - textView.frame.size.height + r.size.height + 8, 0);
        if (textView.contentOffset.y < caretY && r.origin.y != INFINITY) {
            textView.contentOffset = CGPointMake(0, caretY);
        }
    }
}
@end
