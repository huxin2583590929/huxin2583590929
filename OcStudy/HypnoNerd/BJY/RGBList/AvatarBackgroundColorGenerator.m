//
//  AvatarBackgroundColorGenerator.m
//  testOC
//
//  Created by HuXin on 2021/9/10.
//

#import "AvatarBackgroundColorGenerator.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define kHueStep 2
#define kSaturationStep1 0.16
#define kSaturationStep2 0.05
#define kBrightnessStep1 0.05
#define kBrightnessStep2 0.15
#define kLightColorCount 5
#define kDarkColorCount 4

@implementation AvatarBackgroundColorGenerator

+ (UIColor *)backgroundColorWithUserNumber:(NSString *)userNumber {
    if (userNumber == nil || userNumber.length < 1) {
        return nil;
    }
    NSString *number = userNumber;
    if (number.length < 2) {
        number = [@"0" stringByAppendingString:number];
    }
    else {
        number = [number substringWithRange:NSMakeRange(number.length - 2, 2)];
    }
    NSInteger light = (number.integerValue % 10) % 5 + 3;
    NSInteger majorNumber = floor(number.integerValue / 10) + ((number.integerValue % 10) >= 5 ? 10 : 0);
    NSArray *colorPalette = @[@"f5222d", @"fa541c", @"fa8c16", @"faad14", @"fadb14", @"a0d911", @"52c41a", @"13c2c2", @"1890ff", @"2f54eb"
                              , @"722ed1", @"eb2f96", @"833d41", @"835a3d", @"77833d", @"3d8379", @"3d6183", @"3f3d83", @"7f3d83", @"607d8d"];
    NSString *mainColor = colorPalette[majorNumber];
    NSLog(@"light: %ld  ,majorNumber: %ld     ,mainColor:  %@", light, majorNumber, mainColor);
    NSString *red = [mainColor substringWithRange:NSMakeRange(0, 2)];
    NSString *green = [mainColor substringWithRange:NSMakeRange(2, 2)];
    NSString *blue = [mainColor substringWithRange:NSMakeRange(4, 2)];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:red] scanHexInt:&r];
    [[NSScanner scannerWithString:green] scanHexInt:&g];
    [[NSScanner scannerWithString:blue] scanHexInt:&b];
    
    NSArray *hsv = [self hsvFromR:r / 255.0 G:g / 255.0 B:b / 255.0];
    bool isLight = light <= kLightColorCount;
    NSInteger offset = isLight ? kLightColorCount - light : light - kLightColorCount;
    
    CGFloat hue = [self hueWithHSV:hsv offset:offset light:isLight] / 360;
    CGFloat saturation = [self saturationWithHSV:hsv offset:offset light:isLight];
    CGFloat value = [self valueWithHSV:hsv offset:offset light:isLight];
    
//    NSArray<NSNumber *> *rgb = [self rgbFromH:hue S:saturation * 100 V:value * 100];
//    NSString *colorString = [NSString stringWithFormat:@"#%.2lx%.2lx%.2lx",(NSInteger)round(rgb[0].floatValue), (NSInteger)round(rgb[1].floatValue), (NSInteger)round(rgb[2].floatValue)];
    return [UIColor colorWithHue:hue saturation:saturation brightness:value alpha:1.0];
}

+ (NSArray<NSNumber *>* )hsvFromR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b {
    CGFloat max = MAX(r, MAX(g, b));
    CGFloat min = MIN(r, MIN(g, b));
    CGFloat d = max - min;
    CGFloat h = max;
    CGFloat s  = max;
    CGFloat v = max;
    if (max == 0) {
        s = 0;
    }
    else {
        s = d / max;
    }
    if (max == min) {
        h = 0;
    }
    else {
        if (max == r) {
            h = (g - b) / d + (g < b ? 6 : 0);
        }
        else if (max == g) {
            h = (b - r) / d + 2;
        }
        else {
            h = (r - g) / d + 4;
        }
        h  = (h / 6) * 360;
    }
    return @[@(h), @(s) ,@(v)];
}

+ (NSArray<NSNumber *>* )rgbFromH:(CGFloat)h S:(CGFloat)s V:(CGFloat)v {
    CGFloat hue = (h / 360) * 6;
    CGFloat saturation = s / 100;
    CGFloat value = v / 100;
    NSInteger i = floor(hue);
    CGFloat f = hue - i;
    CGFloat p = value * (1 - saturation);
    CGFloat q = value * (1 - f * saturation);
    CGFloat t = value * (1 - (1 - f) * saturation);
    NSInteger mod = i % 6;
    CGFloat r = [@[@(value), @(q), @(p), @(p), @(t), @(value)][mod] floatValue] * 255;
    CGFloat g = [@[@(t), @(value), @(value), @(q), @(p), @(p)][mod] floatValue] * 255;
    CGFloat b = [@[@(p), @(p), @(t), @(value), @(value), @(q)][mod] floatValue] * 255;
    
    return @[@(r), @(g), @(b)];
}

+ (CGFloat)hueWithHSV:(NSArray<NSNumber *>*)hsv offset:(NSInteger)i light:(BOOL)isLight {
    CGFloat hue;
    CGFloat h = hsv[0].floatValue;
    if (h >= 60 && h <= 240) {
        hue = isLight ? h - (kHueStep * i) : h + (kHueStep * i);
    }
    else {
        hue = isLight ? h + kHueStep * i : h - kHueStep * i;
    }
    if (hue < 0) {
        hue += 360;
    }
    else if (hue >= 360){
        hue -= 360;
    }
    return hue;
}

+ (CGFloat)saturationWithHSV:(NSArray<NSNumber *>*)hsv offset:(NSInteger)i light:(BOOL)isLight {
    CGFloat saturation;
    CGFloat s = hsv[1].floatValue;
    if (isLight) {
        saturation = s - kSaturationStep1 * i;
    } else if (i == kDarkColorCount) {
        saturation = s + kSaturationStep1;
    } else {
        saturation = s + kSaturationStep2 * i;
    }
    if (saturation > 1) {
        saturation = 1;
    }
    if (isLight && i == kLightColorCount && saturation > 0.1) {
        saturation = 0.1;
    }
    if (saturation < 0.06) {
        saturation = 0.06;
    }
    return saturation;
}

+ (CGFloat)valueWithHSV:(NSArray<NSNumber *>*)hsv offset:(NSInteger)i light:(BOOL)isLight {
    CGFloat value;
    CGFloat v = hsv[2].floatValue;
     if (isLight) {
         value = v + kBrightnessStep1 * i;
     } else {
         value = v - kBrightnessStep2 * i;
     }
     if (value > 1) {
         value = 1;
     }
    return value;
}

+ (nullable UIColor *)bjl_colorWithHexString:(NSString *)hexString {
    return [self bjl_colorWithHexString:hexString alpha:1.0];
}

+ (nullable UIColor *)bjl_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    if ([hexString hasPrefix:@"#"]) {
        hexString = [hexString substringFromIndex:1];
    }
    if ([[hexString lowercaseString] hasPrefix:@"0x"]) {
        hexString = [hexString substringFromIndex:2];
    }
    if ([hexString length] != 6) {
        return nil;
    }
    
    NSScanner *scanner = [[NSScanner alloc] initWithString:hexString];
    unsigned hexValue = 0;
    if ([scanner scanHexInt:&hexValue] && [scanner isAtEnd]) {
        return [self bjl_colorWithHex:hexValue alpha:alpha];
    }
    
    return nil;
}

+ (UIColor *)bjl_colorWithHex:(unsigned)hex {
    return [self bjl_colorWithHex:hex alpha:1.0];
}

+ (UIColor *)bjl_colorWithHex:(unsigned)hex alpha:(CGFloat)alpha {
    int r = ((hex & 0xFF0000) >> 16);
    int g = ((hex & 0x00FF00) >>  8);
    int b = ( hex & 0x0000FF)       ;
    return [UIColor colorWithRed:((CGFloat)r / 255)
                        green:((CGFloat)g / 255)
                         blue:((CGFloat)b / 255)
                        alpha:alpha];
}
@end
