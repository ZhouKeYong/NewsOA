//
//  excelViewController.m
//  表格
//
//  Created by MarkChen on 15/12/24.
//  Copyright © 2015年 www.wxhl.com. All rights reserved.
//

#import "excelViewController.h"
#import "excelCell.h"
#define  cellID @"cell"
#define  firstCell @"firstCell"
@interface excelViewController ()

@end

@implementation excelViewController
{
    UIButton*dayBtn;
    UIButton*monthBtn;
    UIView * lineView;
    UIView * lineView2;
    UIView * tyeView ;
    BOOL selet;
}


-(instancetype)initWithData:(NSArray*)data headerData:(NSArray*)headerData title:(NSString*)title{
    self = [super init];
    if (self) {
        _data = data;
        _headerData = headerData;
        __title = title;
        _HeaderIs = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    [self.view addSubview:_tableView];
    self.title =__title;
    selet = YES;
    [_tableView registerClass:[excelCell class] forCellReuseIdentifier:cellID];
    

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _data.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 30;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    view.backgroundColor =[UIColor whiteColor];
    UIView * footView = [[UIView alloc]initWithFrame:CGRectMake(10, 5, [UIScreen mainScreen].bounds.size.width-20, 40)];
    footView.backgroundColor = [UIColor colorWithRed:150 green:0 blue:20 alpha:1];
    footView.layer.borderColor = [[UIColor redColor]CGColor];
    footView.layer.borderWidth=2;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 2, 150, 36)];
    label.text =@"注意：";
    label.textColor = [UIColor redColor];
    [view addSubview:footView];
    [footView addSubview:label];
    return view;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (self.HeaderIs == NO) {
        return 0;
    }
    return 150;
    
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static dispatch_once_t onceToken = 0;
    static UIView * headerView =nil;
    dispatch_once(&onceToken, ^{
        headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
        headerView.backgroundColor=[UIColor whiteColor];
        //日月排行按钮
        dayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        dayBtn.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2, 50) ;
        [dayBtn setTitle:@"日排行" forState:UIControlStateNormal];
        [dayBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        dayBtn.tag = 1;
        [dayBtn addTarget:self action:@selector(headerViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        monthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        monthBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2, 0, [UIScreen mainScreen].bounds.size.width/2, 50);
        [monthBtn setTitle:@"月排行" forState:UIControlStateNormal];
        [monthBtn addTarget:self action:@selector(headerViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        monthBtn.tag =2;
        [monthBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [headerView addSubview:dayBtn];
        [headerView addSubview:monthBtn];
        //按钮下划线
        lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width/2, 2)];
        lineView.backgroundColor = [UIColor orangeColor];
        lineView2 = [[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2, 50, [UIScreen mainScreen].bounds.size.width/2, 2)];
        lineView2.backgroundColor = [UIColor grayColor];
        [headerView addSubview:lineView];
        [headerView addSubview:lineView2];
        //产品类型按钮
        UILabel * tyeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 60, 30)];
        tyeLabel.text=@"产品：";
        [headerView addSubview:tyeLabel];
        UIButton* tyeButton=[UIButton buttonWithType:UIButtonTypeCustom];
        tyeButton .frame = CGRectMake(70, 100, 70, 30);
        tyeButton.layer.borderColor = [[UIColor lightGrayColor]CGColor];
        tyeButton.layer.borderWidth=1;
        tyeButton.layer.cornerRadius =5;
        tyeButton.tag =3;
        [tyeButton addTarget:self action:@selector(headerViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:tyeButton];
        tyeView = [[UIView alloc]initWithFrame:CGRectMake(120, 80, 0, 70)];
        tyeView.backgroundColor= [UIColor blackColor];
        tyeView.alpha = 0.6;
        [headerView addSubview:tyeView];
    });
    
   
    return headerView;
}

-(void)headerViewButtonAction:(UIButton*)btn{
    if (btn.tag == 1) {
        [dayBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [monthBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        lineView.backgroundColor=[UIColor orangeColor];
        lineView2.backgroundColor=[UIColor grayColor];
    }else if (btn.tag ==2){
        [dayBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [monthBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        lineView.backgroundColor=[UIColor grayColor];
        lineView2.backgroundColor=[UIColor orangeColor];
        
    }else if(btn.tag == 3){
        btn.selected =!btn.selected;
        if (btn.selected) {
            [UIView beginAnimations:@"123" context:nil];
            [UIView setAnimationDuration:0.5];
            btn.transform = CGAffineTransformMakeRotation(-M_PI_2);
            //tyeView.transform = CGAffineTransformMakeRotation(-M_PI_2);
            [UIView commitAnimations];
            [self performSelector:@selector(action:) withObject:btn afterDelay:1];
        }else{
            [UIView beginAnimations:@"321" context:nil];
            [UIView setAnimationDuration:0.5];
            tyeView.frame = CGRectMake(120, 80, 0, 70);
            
            //tyeView.transform = CGAffineTransformMakeRotation(0);
            [UIView commitAnimations];
            [self performSelector:@selector(action:) withObject:btn afterDelay:1];
            
        }
        
    }
    
}
-(void)action:(UIButton*)btn{
    if (selet) {
        [UIView animateWithDuration:1 animations:^{
            tyeView.frame = CGRectMake(120, 80, 200, 70);
            
        }];
        
    }else{
        [UIView animateWithDuration:1 animations:^{
            btn.transform = CGAffineTransformMakeRotation(0);
            
        }];
        
    }
    selet =!selet;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0){
        UITableViewCell*firstcell = [tableView dequeueReusableCellWithIdentifier:firstCell];
        if (!firstcell) {
            firstcell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstCell];
            for (int i = 0; i < _headerData.count; i++) {
                UIButton*button = [UIButton buttonWithType:UIButtonTypeCustom];
                
                button.frame=CGRectMake(10+i*(([UIScreen mainScreen].bounds.size.width-20)/_headerData.count), 0, ([UIScreen mainScreen].bounds.size.width-20)/_headerData.count, 30);
                button.tag =i+100;
                // [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
                
                [button setBackgroundColor:[UIColor lightGrayColor]];
                button.alpha=0.5;
                button.layer.borderColor = [[UIColor grayColor]CGColor];
                button.layer.borderWidth=1;
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [button setTitle:_headerData[i] forState:UIControlStateNormal];
                [firstcell.contentView addSubview:button];
            }
        }
        
        return firstcell;
        
    }
    excelCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (!cell) {
        cell = [[excelCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.data = _data[indexPath.row];

    
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
