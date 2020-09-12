//
//  YKMainViewController.m
//  ZHIBO
//
//  Created by aZu on 2020/9/9.
//  Copyright © 2020 aZu. All rights reserved.
//

#import "YKMainViewController.h"

@interface YKMainViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewWidthCons;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@property(nonatomic,strong)NSArray *datalist;

@end

@implementation YKMainViewController

-(NSArray *)datalist{
    if (!_datalist) {
        _datalist = [NSArray arrayWithObjects:@"关注",@"热门",@"附近", nil];
    }
    return _datalist;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

-(void)setupUI{
    
    
    [self setupNav];
    
    [self setupChildViewControllers];
    
    self.contentScrollView.delegate = self;
    
    
}

-(void)setupChildViewControllers{
    
    NSArray *vcNames = @[@"YKBaseViewController",@"YKHotViewController",@"YKNearViewController"];
    
    for (int i = 0; i < vcNames.count; i++ ) {
        NSString *vcName = vcNames[i];
        UIViewController *vc = [[NSClassFromString(vcName) alloc]init];
        
        vc.title = self.datalist[i];
        
        //当执行这个方法时，不会执行该vc的ViewDidLoad方法；
        
        [self addChildViewController:vc];
        
    }

    self.contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.datalist.count, 0);
    
    
    [self scrollViewDidEndDecelerating:self.contentScrollView];
}



-(void)setupNav{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"global_search"] style:UIBarButtonItemStyleDone target:self action:nil];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"title_button_more"] style:UIBarButtonItemStyleDone target:self action:nil];
}
-(void)updateViewConstraints{
    [super updateViewConstraints];
    //self.scrollViewWidthCons.constant = self.view.bounds.size.width * self.datalist.count;
    
}


#pragma mark ---UIScrollViewDelegate---
//滑动结束再加载
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat width = SCREEN_WIDTH;
    CGFloat height = SCREEN_HEIGHT;
    
    CGFloat offSetX = scrollView.contentOffset.x;
    
    //获取索引值
    NSInteger idx = offSetX / width;
    NSLog(@"%d",idx);
    
    UIViewController *vc = self.childViewControllers[idx];
    
    //判断当前vc是否执行过viewDidLoad
    if([vc isViewLoaded]) return;
    
    vc.view.frame = CGRectMake(offSetX, 0, width, height);
    
    [scrollView addSubview:vc.view];
    
}



@end
