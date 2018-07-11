//
//  ViewController.m
//  UIPasswordViewDemo
//
//  Created by quan on 2018/7/11.
//  Copyright © 2018年 quan. All rights reserved.
//

#import "ViewController.h"
#import "UIPasswordTextView.h"

#define KUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface ViewController ()<UIAutoHeightTextViewDelegate>
@property (weak, nonatomic) IBOutlet UIPasswordTextView *passwordTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.passwordTextView setAutoDelegate:self];
    [self.passwordTextView setPlaceholder:@"请输入密码" PlaceholderTextColor:KUIColorFromRGB(0xC7C7CD) RealTextColor:[UIColor blackColor]];
    
    //建议初始化的时候 用一行的高度.
    [self.textViewHeightConstraint setConstant:40];
}
- (IBAction)changeStatus:(id)sender {
    UIButton * btn = sender;
    [btn setSelected:!btn.selected];
    [self.passwordTextView setSecureTextViewEntry:!btn.selected];
}
- (IBAction)enterEvent:(id)sender {
    UIAlertView * alert= [[UIAlertView alloc]initWithTitle:@"密码" message:self.passwordTextView.secureText delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)textViewResetSize:(CGSize)size{
    //建议初始化的时候 用一行的高度.
    [self.textViewHeightConstraint setConstant:size.height];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
