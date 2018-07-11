//
//  UITextViewPlaceholder.m
//  Cambodia
//
//  Created by quan on 2017/4/21.
//  Copyright © 2017年 JXG. All rights reserved.
//

#import "UITextViewPlaceholder.h"

@interface UITextViewPlaceholder ()<UITextViewDelegate>
@property (nonatomic, retain) UIColor* realTextColor;
@property(nonatomic, retain) NSString * placeholder;
@property(nonatomic, retain) UIColor * placeholderTextColor;
@end

@implementation UITextViewPlaceholder


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginEditing) name:UITextViewTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endEditing) name:UITextViewTextDidEndEditingNotification object:self];
    
    self.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    
    self.delegate = self;
}
- (void)setPlaceholder:(NSString *)aPlaceholder PlaceholderTextColor:(UIColor *)placeholderTextColor RealTextColor:(UIColor *)aRealTextColor{
    _placeholder = aPlaceholder;
    if (placeholderTextColor) {
        _placeholderTextColor = placeholderTextColor;
    }else{
        _placeholderTextColor = [UIColor lightGrayColor];
    }
    if (aRealTextColor) {
        _realTextColor = aRealTextColor;
    }else{
        _realTextColor = self.textColor;
    }
    
    
    [self setText:aPlaceholder];
    [self setTextColor:placeholderTextColor];
}


- (void)beginEditing{
    if ([self.text isEqualToString:_placeholder]) {
        self.text = @"";
        [self setTextColor:_realTextColor];
    }
}

- (void)endEditing{
    if (self.text.length<1) {
        self.text = _placeholder;
        [self setTextColor:_placeholderTextColor];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    } else {
        return YES;
    }
}



@end
