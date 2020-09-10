//
//  YKTabBar.h
//  ZHIBO
//
//  Created by aZu on 2020/9/9.
//  Copyright © 2020 aZu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,YKItemType){
    YKItemTypeLaunch = 10,
    YKItemTypeLive = 100,
    YKItemTypeMe,
    
} ;





@class  YKTabBar;

typedef void(^TabBlock)(YKTabBar * _Nullable tabBar,YKItemType idx);

@protocol YKTabBarDelegate <NSObject>

-(void)tabBar:(YKTabBar *_Nullable)tabBar clickButton:(YKItemType)idx;

@end

NS_ASSUME_NONNULL_BEGIN

@interface YKTabBar : UIView

@property(nonatomic,weak) id<YKTabBarDelegate> delegate;
@property(nonatomic,copy) TabBlock block;

@end

NS_ASSUME_NONNULL_END
