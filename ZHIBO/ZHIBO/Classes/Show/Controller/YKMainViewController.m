//
//  YKMainViewController.m
//  ZHIBO
//
//  Created by aZu on 2020/9/9.
//  Copyright © 2020 aZu. All rights reserved.
//

#import "YKMainViewController.h"

@interface YKMainViewController ()

@end

@implementation YKMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

-(void)setupUI{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"global_search"] style:UIBarButtonItemStyleDone target:self action:nil];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"title_button_more"] style:UIBarButtonItemStyleDone target:self action:nil];
    
    
    
}
@end
