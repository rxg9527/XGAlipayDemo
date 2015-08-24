//
//  ViewController.m
//  YuenAlipayDemo
//
//  Created by peikua on 15/8/17.
//  Copyright (c) 2015年 Ruan. All rights reserved.
//

#import "ViewController.h"
#import "MyUtility.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "PartnerConfig.h"
#import "DataSigner.h"

@interface ViewController () <UITableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *payButton = [MyUtility createButtonWithFrame:CGRectMake(0, kHeightOfScreen/2, kWidthOfScreen, 100) title:@"支付" backgroundImageName: nil selectImageName:nil target:self action:@selector(payAction)];
    payButton.backgroundColor = [UIColor colorWithRed:0.000 green:1.000 blue:0.870 alpha:1.000];
    [self.view addSubview:payButton];
}

- (void)payAction
{
    /**
     *  1. 生成订单信息
     */
    Order *order = [[Order alloc] init];
    order.partner = PartnerID; //支付宝分配给商户的ID
    order.seller = SellerID; //收款支付宝账号（用于收💰）
    order.tradeNO = [self generateTradeNO]; //订单ID(由商家自行制定)
    NSLog(@"%@", order.tradeNO);
    order.productName = @"Mac"; //商品标题
    order.productDescription = @"MacBook Air"; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格
    //???: 回调 URL 没有进行调试
    order.notifyURL =  @"http://www.xxx.com"; //回调URL（通知服务器端交易结果）(重要)
    
    //???: 接口名称要如何修改?
    order.service = @"mobile.securitypay.pay"; //接口名称, 固定值, 不可空
    order.paymentType = @"1"; //支付类型 默认值为1(商品购买), 不可空
    order.inputCharset = @"utf-8"; //参数编码字符集: 商户网站使用的编码格式, 固定为utf-8, 不可空
    order.itBPay = @"30m"; //未付款交易的超时时间 取值范围:1m-15d, 可空
    
    // 应用注册scheme,在当前项目的Info.plist定义URL types
    NSString *appScheme = @"alisdkdemo";
    // 将订单信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"订单信息orderSpec = %@", orderSpec);
    
    /**
     *  2. 签名加密
     *  获取私钥并将商户信息签名, 外部商户可以根据情况存放私钥和签名, 只需要遵循 RSA 签名规范, 并将签名字符串 base64 编码和 UrlEncode
     */
    id <DataSigner> signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:orderSpec];
    
    /**
     *  3. 将签名成功字符串格式化为订单字符串,请严格按照该格式
     */
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"", orderSpec, signedString, @"RSA"];
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }
}

/**
 *  产生随机订单号
 *
 *  @return 订单号字符串
 */
- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    
    /*
     支付宝官方给出的 Demo 中加入了这句生成种子的代码, 但是 arc4random 似乎并不需要生成随机种子(引用网上: arc4random() 是一个真正的伪随机算法，不需要生成随机种子，因为第一次调用的时候就会自动生成)
     srand((unsigned)time(0));
     */

    for (int i = 0; i < kNumber; i++)
    {
        unsigned index =  arc4random() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    NSLog(@"随机生成的订单号->%@", resultStr);
    return resultStr;
}

@end
