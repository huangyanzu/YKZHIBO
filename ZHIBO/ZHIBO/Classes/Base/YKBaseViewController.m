//
//  YKBaseViewController.m
//  ZHIBO
//
//  Created by aZu on 2020/9/9.
//  Copyright © 2020 aZu. All rights reserved.
//

#import "YKBaseViewController.h"
#import <objc/message.h>

@interface YKBaseViewController ()

@end

@implementation YKBaseViewController

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL sel = @selector(modalPresentationStyle);
        SEL swizzSel = @selector(swiz_modalPresentationStyle);
        Method method = class_getInstanceMethod([self class], sel);
        Method swizzMethod = class_getInstanceMethod([self class], swizzSel);
        BOOL isAdd = class_addMethod(self, sel, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
        if (isAdd) {
            class_replaceMethod(self, swizzSel, method_getImplementation(method), method_getTypeEncoding(method));
        }else{
            method_exchangeImplementations(method, swizzMethod);
        }
    });
}

- (UIModalPresentationStyle)swiz_modalPresentationStyle {
    return UIModalPresentationFullScreen;
}


- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor = RGB(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255));
    
    
    
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
