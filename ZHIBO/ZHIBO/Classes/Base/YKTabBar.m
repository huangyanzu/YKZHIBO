//
//  YKTabBar.m
//  ZHIBO
//
//  Created by aZu on 2020/9/9.
//  Copyright © 2020 aZu. All rights reserved.
//

#import "YKTabBar.h"

@interface YKTabBar()
@property(nonatomic,strong)UIImageView *tabbgView;
@property(nonatomic,strong)NSArray *datalist;
@property(nonatomic,strong)UIButton *lastItem;
@property(nonatomic,strong)UIButton *cameraButton;

@end

@implementation YKTabBar

-(UIImageView *)tabbgView{
    if (!_tabbgView) {
        _tabbgView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"global_tab_bg"]];
    }
    return _tabbgView;
}

-(NSArray *)datalist{
    if (!_datalist) {
        _datalist = @[@"tab_live",@"tab_me"];
    }
    return _datalist;
}
-(UIButton *)cameraButton{
    if (!_cameraButton) {
        _cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cameraButton setImage:[UIImage imageNamed:@"tab_launch"] forState:UIControlStateNormal];
        [_cameraButton sizeToFit];
        _cameraButton.tag = YKItemTypeLaunch;
        [_cameraButton addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cameraButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.tabbgView];
       
        for (int i = 0;i < self.datalist.count ;i++ ) {
            UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
            //不让图片在高亮条件下改变
            item.adjustsImageWhenHighlighted = NO;
            [item setImage:[UIImage imageNamed:self.datalist[i]] forState:UIControlStateNormal];
            
            [item setImage:[UIImage imageNamed:[self.datalist[i] stringByAppendingString:@"_p"]] forState:UIControlStateSelected];
            
            [item addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
            item.tag = YKItemTypeLive + i ;
            
            if (i==0){
                item.selected = YES;
                self.lastItem = item;
            }
            
            [self addSubview:item];
        }
        
        [self addSubview:self.cameraButton];
        
    }
    return self;
}
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.tabbgView.frame = self.bounds;
    CGFloat width = self.bounds.size.width / self.datalist.count;
    
    for (int i = 0; i < self.subviews.count; i++) {
        
        UIView *view = self.subviews[i];
        
        if ([view isKindOfClass:[UIButton class]]) {
          
            view.frame = CGRectMake((view.tag - YKItemTypeLive) * width, 0, width, self.frame.size.height);
        }
    }
    
    [self.cameraButton sizeToFit];
    self.cameraButton.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height - 50 );
}


-(void)clickItem:(UIButton *)sender{
 
    if ([self.delegate respondsToSelector:@selector(tabBar:clickButton:)]) {
        [self.delegate tabBar:self clickButton:sender.tag];
    }
    
   !self.block ?: self.block(self,sender.tag);
   
//    if(self.block){
//        self.block(self, sender.tag);
//
//    }
//
    if (sender.tag != YKItemTypeLaunch) {
        self.lastItem.selected = NO;
        sender.selected = YES;
        self.lastItem = sender;
        
        [UIView animateWithDuration:0.2 animations:^{
           
            sender.transform = CGAffineTransformMakeScale(1.2, 1.2);
            
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                sender.transform = CGAffineTransformIdentity;
            }];
        }];
        
    }
    
    
}

@end
