//
//  UIPasswordTextView.h
//  TANAWallet
//
//  Created by quan on 2018/7/10.
//  Copyright © 2018年 Yue. All rights reserved.
//

#import "UIAutoHeightTextView.h"

@interface UIPasswordTextView : UIAutoHeightTextView
@property (assign, nonatomic) BOOL secureTextViewEntry;       // default is NO
@property (retain, nonatomic) NSMutableString * secureText;
@end
