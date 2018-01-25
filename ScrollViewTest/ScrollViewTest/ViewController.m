//
//  ViewController.m
//  ScrollViewTest
//
//  Created by 韦荣炽 on 2018/1/16.
//  Copyright © 2018年 XingFei_韦荣炽. All rights reserved.
//
#define ScreenHeight [UIScreen mainScreen].bounds.size.height/**全局高度*/
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width/**全局宽度*/
#import "ViewController.h"
#import "FistVC.h"
#import "SecondVC.h"
#import "XFPanScrollView.h"
@interface ViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)XFPanScrollView *mainScrollView;//
@property(nonatomic,strong)UIScrollView *contentScrollView;//内容
@property(nonatomic,assign)BOOL canScroll;//YES 表示可以滚动 NO 表示不可以滚动

@property(nonatomic,strong)UIButton *firstBtn;//第一个按钮
@property(nonatomic,strong)UIButton *secondBtn;//第二个按钮
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];

    self.automaticallyAdjustsScrollViewInsets=NO;
    
    self.canScroll=YES;
    
    //步骤2
    //上下滑动的UIScrollView
    self.mainScrollView=[[XFPanScrollView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth , ScreenHeight)];
    self.mainScrollView.contentSize=CGSizeMake(ScreenWidth, ScreenHeight*2);
    self.mainScrollView.delegate=self;
    [self.view addSubview:self.mainScrollView];
    self.mainScrollView.backgroundColor=[UIColor whiteColor];
    
    //头部的视图
    UIImageView *headerView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    headerView.backgroundColor=[UIColor whiteColor];
    headerView.userInteractionEnabled=YES;
    [self.mainScrollView addSubview:headerView];
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(50, 50,150, 20)];
    lab.text=@"这个是头部的视图";
    [headerView addSubview:lab];
    
    
    self.firstBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 200-40, ScreenWidth/2, 40)];
    [self.firstBtn setTitle:@"One" forState:UIControlStateNormal];
     [self.firstBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.firstBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateDisabled];
    [self.firstBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.firstBtn.enabled=NO;
    [headerView addSubview:self.firstBtn];
    
    //设置layer
    CALayer *layer=[self.firstBtn layer];
    //是否设置边框以及是否可见
    [layer setMasksToBounds:YES];
    //设置边框线的宽
    [layer setBorderWidth:1];
    //设置边框线的颜色
    [layer setBorderColor:[[UIColor blackColor] CGColor] ];
    
    
    self.secondBtn=[[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2, 200-40, ScreenWidth/2, 40)];
    [self.secondBtn setTitle:@"Two" forState:UIControlStateNormal];
    [self.secondBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.secondBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateDisabled];
    [self.secondBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.secondBtn.enabled=YES;
    [headerView addSubview:self.secondBtn];
    
    
     //设置layer
     CALayer *layer2=[self.secondBtn layer];
     //是否设置边框以及是否可见
     [layer2 setMasksToBounds:YES];
     //设置边框线的宽
     [layer2 setBorderWidth:1];
     //设置边框线的颜色
      [layer2 setBorderColor:[[UIColor blackColor] CGColor] ];
    
    //步骤3
    //左右滑动的UIScrollView
    self.contentScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, headerView.frame.size.height+headerView.frame.origin.y,ScreenWidth , ScreenHeight-50)];
    self.contentScrollView.contentSize=CGSizeMake(ScreenWidth*2, ScreenHeight-50);
    self.contentScrollView.backgroundColor=[UIColor whiteColor];
    self.contentScrollView.pagingEnabled=YES;
    self.contentScrollView.bounces=NO;
    self.contentScrollView.delegate=self;
    [self.mainScrollView addSubview:self.contentScrollView];
    
    //左右滑动的内容1
    FistVC *fVC=[[FistVC alloc]init];
    fVC.view.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [self.contentScrollView addSubview:fVC.view];
    [self addChildViewController:fVC];
    
    //左右滑动的内容2
    SecondVC *sVC=[[SecondVC alloc]init];
    sVC.view.frame=CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight);
    [self.contentScrollView addSubview:sVC.view];
    [self addChildViewController:sVC];
    
    
    //步骤4
    //子视图变化通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollChange:) name:@"childScroChange" object:nil];
    
    
}
//步骤5
#pragma mark - 子级View滑动响应
-(void)scrollChange:(NSNotification *)noti
{
    self.canScroll=YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"rootScroChange" object:@[@0]];
}
//步骤6
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView==self.mainScrollView) {
        
        CGFloat contentOffsetY=scrollView.contentOffset.y;
        CGFloat headerHeight=150;
        
        if (contentOffsetY>headerHeight) {
            scrollView.contentOffset=CGPointMake(0, headerHeight);
            if (self.canScroll) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"rootScroChange" object:@[@1]];
                self.canScroll=NO;
            }
            
        }else
        {
            if (!self.canScroll) {
                scrollView.contentOffset=CGPointMake(0, headerHeight);
            }
            
        }
    }
}
#pragma mark - 按钮点击事件
-(void)buttonClick:(UIButton *)btn
{
    btn.enabled=!btn.enabled;
    if (btn==self.self.firstBtn) {
        self.secondBtn.enabled=YES;
        [self.contentScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else
    {
        self.firstBtn.enabled=YES;
        [self.contentScrollView setContentOffset:CGPointMake(ScreenWidth, 0) animated:YES];
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView==self.contentScrollView) {
        NSInteger index=scrollView.contentOffset.x/ScreenWidth;
        
        if (index==0) {
            self.firstBtn.enabled=NO;
            self.secondBtn.enabled=YES;
        }
        else
        {
            self.firstBtn.enabled=YES;
            self.secondBtn.enabled=NO;
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
