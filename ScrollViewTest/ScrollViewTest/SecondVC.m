//
//  SecondVC.m
//  ScrollViewTest
//
//  Created by 韦荣炽 on 2018/1/16.
//  Copyright © 2018年 XingFei_韦荣炽. All rights reserved.
//

#import "SecondVC.h"
#define ScreenHeight [UIScreen mainScreen].bounds.size.height/**全局高度*/
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width/**全局宽度*/
@interface SecondVC ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scro;//滚动视图
@property(nonatomic,assign)BOOL canScroll;//YES 表示可以滚动 NO 表示不可以滚动

@end

@implementation SecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    self.scro=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-50)];
    _scro.delegate=self;
    [self.view addSubview:_scro];
    _scro.backgroundColor=[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.2];
    _scro.contentSize=CGSizeMake(ScreenWidth, ScreenHeight*1.5);
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(20, 30, 200, 20)];
    lab.text=@"这是第二个子UIScrollView";
    [self.scro addSubview:lab];
    
   
    
    UIImageView *redImg2=[[UIImageView alloc]initWithFrame:CGRectMake(20, 120, 50, 50)];
    redImg2.backgroundColor=[UIColor orangeColor];
    [_scro addSubview:redImg2];
    
    
    
    UIImageView *redImg3=[[UIImageView alloc]initWithFrame:CGRectMake(20, 320, 50, 50)];
    redImg3.backgroundColor=[UIColor blackColor];
    [_scro addSubview:redImg3];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollChange:) name:@"rootScroChange" object:nil];
    
    
}
#pragma mark - 父级View滑动响应
-(void)scrollChange:(NSNotification *)noti
{
    NSArray *arr=noti.object;
    NSInteger num =[arr.firstObject integerValue];
    if (num==0) {
        self.canScroll=NO;
        [self.scro setContentOffset:CGPointZero];
    }
    else
    {
        self.canScroll=YES;
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.canScroll) {
        [scrollView setContentOffset:CGPointZero];
    }else
    {
        if (scrollView.contentOffset.y<=0) {
            self.canScroll=NO;
            scrollView.contentOffset=CGPointZero;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"childScroChange" object:@[[NSString stringWithFormat:@"%f",scrollView.contentOffset.y]]];
        }
    }
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

