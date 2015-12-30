//
//  excelCell.m
//  表格
//
//  Created by MarkChen on 15/12/22.
//  Copyright © 2015年 www.wxhl.com. All rights reserved.
//

#import "excelCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation excelCell

- (void)awakeFromNib {


    NSLog(@"新测试");
    
    
}

-(void)setData:(NSArray *)data{
    for (UIView * view  in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    for (int i = 0; i < data.count; i++) {
        UIButton*button = [UIButton buttonWithType:UIButtonTypeCustom];

        button.frame=CGRectMake(10+i*(([UIScreen mainScreen].bounds.size.width-20)/data.count), 0, ([UIScreen mainScreen].bounds.size.width-20)/data.count, 30);
        button.tag =i+100;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        

        button.layer.borderColor = [[UIColor grayColor]CGColor];
        button.alpha=0.5;
        button.layer.borderWidth=1;
        [button setTitle:data[i] forState:UIControlStateNormal];
        if (i == data.count-1) {
            
            
        }
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        [self.contentView addSubview:button];
    }
  
    
}
-(void)buttonAction:(UIButton*)btn{
    NSLog(@"action%li",btn.tag);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
