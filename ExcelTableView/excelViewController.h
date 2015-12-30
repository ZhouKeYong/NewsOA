//
//  excelViewController.h
//  表格
//
//  Created by MarkChen on 15/12/24.
//  Copyright © 2015年 www.wxhl.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface excelViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,copy)NSArray*data;
@property(nonatomic,copy)NSArray*headerData;
@property(nonatomic,copy)NSString*_title;

@property(nonatomic,assign)BOOL HeaderIs;
//调用初始化方法即可生成表格页面，具体参数参照示例；
-(instancetype)initWithData:(NSArray*)data headerData:(NSArray*)headerData title:(NSString*)title;
@end
