//
//  MyUtility.h
//  LimitFreeFullVersion
//
//  Created by Yuen on 15/6/1.
//  Copyright (c) 2015年 Yuen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kHeightOfStatusBar 20
#define kHeightOfAssemble 44
#define kHeightOfNavigationAndStatusBar 64
#define kBoundsOfScreen [[UIScreen mainScreen] bounds]
#define kWidthOfScreen [[UIScreen mainScreen] bounds].size.width
#define kHeightOfScreen [[UIScreen mainScreen] bounds].size.height

@interface MyUtility : NSObject

// 创建Label的方法
+ (UILabel *)createLabelWithFrame:(CGRect)frame title:(NSString *)title textColor:(UIColor *)color font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment numberOfLines:(NSInteger)numberOfLines;

// 创建Label的另外一个方法
+ (UILabel *)createLabelWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font;

// 创建按钮的方法
+ (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title backgroundImageName:(NSString *)bgImageName selectImageName:(NSString *)selectImageName target:(id)target action:(SEL)action;

// 创建图片视图的方法
+ (UIImageView *)createImageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName;

// 创建文字输入框的方法
+ (UITextField *)createTextField:(CGRect)frame placeHolder:(NSString *)placeHolder;

@end
