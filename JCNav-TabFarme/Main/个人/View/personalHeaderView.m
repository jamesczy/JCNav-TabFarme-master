//
//  personalHeaderView.m
//  TORNADOEYES
//
//  Created by yingyi on 16/3/25.
//  Copyright © 2016年 yingyi. All rights reserved.
//

#import "personalHeaderView.h"

@implementation personalHeaderView

//-(instancetype)init{
//    personalHeaderView *viewHeader = [[[NSBundle mainBundle]loadNibNamed:@"personalHeaderView" owner:self options:nil]lastObject];
//    self.imgheader.layer.cornerRadius = 4;
//    self.imgheader.clipsToBounds = YES;
//    return viewHeader;
//}

-(instancetype)initWithFrame:(CGRect)frame
{
    personalHeaderView *viewHeader = [[[NSBundle mainBundle]loadNibNamed:@"personalHeaderView" owner:self options:nil]lastObject];
    
    self.imgheader.layer.cornerRadius = 4;
    self.imgheader.clipsToBounds = YES;
//    NSLog(@"%f",viewHeader.frame.size.height);
    if (frame.size.width != 0) {
        viewHeader.frame = frame;
        
    }
    return viewHeader;
}
@end
