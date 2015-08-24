//
//  MyUtility.m
//  LimitFreeFullVersion
//
//  Created by Yuen on 15/6/1.
//  Copyright (c) 2015年 Yuen. All rights reserved.
//

#import "MyUtility.h"

@implementation MyUtility

+ (UILabel *)createLabelWithFrame:(CGRect)frame title:(NSString *)title textColor:(UIColor *)color font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment numberOfLines:(NSInteger)numberOfLines
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    if (title) {
        label.text = title;
    }
    if (color) {
        label.textColor = color;
    }
    if (font) {
        label.font = font;
    }
    if (textAlignment) {
        label.textAlignment = textAlignment;
    }
    if (numberOfLines) {
        label.numberOfLines = numberOfLines;
    }
    
    return label;
}

+ (UILabel *)createLabelWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font
{
    return [self createLabelWithFrame:frame title:title textColor:[UIColor blackColor] font:font textAlignment:NSTextAlignmentLeft numberOfLines:1];
}

+ (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title backgroundImageName:(NSString *)bgImageName selectImageName:(NSString *)selectImageName target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    if (title) {
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    if (bgImageName) {
        [btn setBackgroundImage:[UIImage imageNamed:bgImageName] forState:UIControlStateNormal];
    }
    if (selectImageName) {
        [btn setBackgroundImage:[UIImage imageNamed:selectImageName] forState:UIControlStateSelected];
    }
    if (target && action) {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    return btn;
}

+ (UITextField *)createTextField:(CGRect)frame placeHolder:(NSString *)placeHolder
{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    if (placeHolder) {
        textField.placeholder = placeHolder;
    }
    textField.borderStyle = UITextBorderStyleRoundedRect;
    return textField;
}

+ (UIImageView *)createImageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName
{
    UIImageView *tmpImageView = [[UIImageView alloc] initWithFrame:frame];
    tmpImageView.image = [UIImage imageNamed:imageName];
    
    return tmpImageView;
}

@end
