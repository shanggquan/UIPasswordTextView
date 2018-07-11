//
//  UIPasswordTextView.m
//  TANAWallet
//
//  Created by quan on 2018/7/10.
//  Copyright © 2018年 Yue. All rights reserved.
//

#import "UIPasswordTextView.h"

@interface UIPasswordTextView (){
    NSTimer * timer;
    NSString * lastText;
}

@end

@implementation UIPasswordTextView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)awakeFromNib{
    // Drawing code
    [super awakeFromNib];
    self.delegate = self;
    self.secureTextEntry = YES;
    self.secureTextViewEntry = YES;
    _secureText = [NSMutableString string];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([@"\n" isEqualToString:text]) {
        [textView resignFirstResponder];
        return NO;
    }
    lastText = text;
    return [super textView:textView shouldChangeTextInRange:range replacementText:text];
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"----%@", _secureText);
    if (_secureTextViewEntry) {
        NSString * text = textView.text;
        if (text.length>0) {
            if ([@"" isEqualToString:lastText]) {
                [_secureText deleteCharactersInRange:NSMakeRange(_secureText.length -1, 1)];
//                self.text = secureStr;
                [self onlyPassword];
                [timer invalidate];
                [super textViewDidChange:textView];
                return;
            }else{
                NSString * one = [text substringFromIndex:text.length -1];
                [_secureText appendString:one];
                
                NSMutableString * temp = [NSMutableString string];
                for (int i= 0; i<_secureText.length-1; i++) {
                    [temp appendString:@"•"];
                }
                [temp appendString:[_secureText substringFromIndex:_secureText.length -1]];
                self.text = temp;
                
                [timer invalidate];
                timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(onlyPassword) userInfo:nil repeats:NO];
            }
        }else{
            _secureText = [NSMutableString string];
        }
        
        [super textViewDidChange:textView];
    }else{
        if (textView.text.length == 0) {
            _secureText = [NSMutableString string];
        }else{
            _secureText = [NSMutableString stringWithString:textView.text];
        }
        
        [timer invalidate];
        [super textViewDidChange:textView];
    }
}

- (void)onlyPassword{
    [timer invalidate];
    NSMutableString * temp = [NSMutableString string];
    for (int i= 0; i<_secureText.length; i++) {
        [temp appendString:@"•"];
    }
    self.text = temp;
}

- (void)textViewDidChangeSelection:(UITextView *)textView{
    [super textViewDidChangeSelection:textView];
}
- (void)setSecureTextViewEntry:(BOOL)secureTextViewEntry{
    _secureTextViewEntry = secureTextViewEntry;
    if (_secureText.length==0) {
        return;
    }else{
        if (secureTextViewEntry) {
            //密码
            NSMutableString * aaa = [NSMutableString string];
            for (int i= 0; i<_secureText.length; i++) {
                [aaa appendString:@"•"];
            }
            self.text = aaa;
        }else{
            //明文
            self.text = _secureText;
            [timer invalidate];
        }
    }
    
    [super textViewDidChange:self];
}
- (BOOL)getSecureTextViewEntry{
    return _secureTextViewEntry;
}

@end
