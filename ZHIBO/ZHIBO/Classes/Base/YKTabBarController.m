//
//  YKTabBarController.m
//  ZHIBO
//
//  Created by aZu on 2020/9/9.
//  Copyright © 2020 aZu. All rights reserved.
//

#import "YKTabBarController.h"
#import "YKTabBar.h"
#import "YKBaseNavViewController.h"
#import "YKLaunchViewController.h"


@interface YKTabBarController ()<YKTabBarDelegate>

@property(nonatomic,strong)YKTabBar *ykTabBar;

@end

@implementation YKTabBarController

-(YKTabBar *)ykTabBar{
    
    if (!_ykTabBar) {
        _ykTabBar = [[YKTabBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
        _ykTabBar.delegate = self;
        
    }
    return _ykTabBar;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self configViewControllers];
    
    [self.tabBar addSubview:self.ykTabBar];
    
    //解决tabbar的阴影线
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
}


-(void)configViewControllers{
    
    NSMutableArray *arry = [NSMutableArray arrayWithArray:@[@"YKMainViewController",@"YKMeViewController"]];
    for (int i = 0; i < arry.count; i++) {
        NSString *vcName = arry[i];
        
        UIViewController *vc = [[NSClassFromString(vcName) alloc] init];
        
        YKBaseNavViewController *nav = [[YKBaseNavViewController alloc] initWithRootViewController:vc];
        [arry replaceObjectAtIndex:i withObject:nav];
    }
    self.viewControllers = arry;
    
}

- (void)tabBar:(YKTabBar *)tabBar clickButton:(YKItemType)idx{
    
    if (idx != YKItemTypeLaunch){
        self.selectedIndex = idx - YKItemTypeLive;
        return;
        
    }
    
    YKLaunchViewController *launchVC = [[YKLaunchViewController alloc] init];
    
    [self presentViewController:launchVC animated:YES completion:nil];
    
}


@end
