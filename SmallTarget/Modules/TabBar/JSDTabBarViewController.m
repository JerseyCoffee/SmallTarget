//
//  JSDTabBarViewController.m
//  SmallTarget
//
//  Created by Jersey on 2019/7/31.
//  Copyright © 2019 JerseyCafe. All rights reserved.
//

#import "JSDTabBarViewController.h"

#import "JSDAddTargetButton.h"
#import "JSDPublic.h"


@interface JSDTabBarViewController ()

@end

@implementation JSDTabBarViewController

- (instancetype)init {
 
    if (!(self = [super init])) {
        return nil;
    }
    
    UIEdgeInsets imageInsets = UIEdgeInsetsZero;//UIEdgeInsetsMake(4.5, 0, -4.5, 0);
    UIOffset titlePositionAdjustment = UIOffsetMake(0, -3.5);
    
    CYLTabBarController* tabBarVC = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers  tabBarItemsAttributes:[self tabBarItemsAttributesForController] imageInsets:imageInsets titlePositionAdjustment:titlePositionAdjustment];
    
    return (self = (JSDTabBarViewController *)tabBarVC);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [JSDAddTargetButton registerPlusButton];
}

- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    
    [tabBarController setTintColor:[UIColor jsd_skyBluecolor]];
}

- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"目标",
                                                 CYLTabBarItemImage : @"home_defalut",
                                                 CYLTabBarItemSelectedImage : @"home_selected",  /* NSString and UIImage are supported*/
                                                 };
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"我的",
                                                  CYLTabBarItemImage : @"my_defalut",
                                                  CYLTabBarItemSelectedImage : @"my_selected",
                                                  };
    
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       ];
    return tabBarItemsAttributes;
}

#pragma mark -- set  && get

- (NSArray *)viewControllers {
    
    JSDTargetVC *homeViewController = [[JSDTargetVC alloc] init];
    JSDBaseNavigationController *homeNavigationController = [[JSDBaseNavigationController alloc]
                                                  initWithRootViewController:homeViewController];
    [homeViewController cyl_setHideNavigationBarSeparator:YES];
    
    UIViewController *myCenterVC = [[JSDMyCenterVC alloc] init];
    UIViewController *myNavigationController = [[JSDBaseNavigationController alloc]
                                                  initWithRootViewController:myCenterVC];

    [myCenterVC cyl_setHideNavigationBarSeparator: YES];
    NSArray *viewControllers = @[
                                 homeNavigationController,
                                 myNavigationController,
                                 ];
    return viewControllers;
}

@end
