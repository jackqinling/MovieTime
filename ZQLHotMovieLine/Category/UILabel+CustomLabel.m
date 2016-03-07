//
//  UILabel+CustomLabel.m
//  PrefectLife
//
//  Created by apple on 16/1/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UILabel+CustomLabel.h"
#import <CoreText/CoreText.h>

@implementation UILabel (CustomLabel)
-(void)setLineSpace:(NSInteger)space WordSpace:(long)number
{
    //label属性
    NSMutableAttributedString *attributedString =[[NSMutableAttributedString alloc]initWithString:self.text];
    //段落的设置
    NSMutableParagraphStyle *Paragraph =[[NSMutableParagraphStyle alloc]init];
    //设置段落的间距
    [Paragraph setLineSpacing:space];
    //把段落间距添加到属性上
    [attributedString addAttribute:NSParagraphStyleAttributeName value:Paragraph range:NSMakeRange(0, [self.text length])];
    //字间距
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
    //字间距添加到属性上
    [attributedString addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0, [attributedString length])];
    self.attributedText =attributedString;
}
@end
