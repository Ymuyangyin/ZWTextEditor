//
//  ViewController.m
//  ZWTextEditor
//
//  Created by 杨杨鹏 on 2020/9/14.
//  Copyright © 2020 杨杨鹏. All rights reserved.
//

#import "ViewController.h"
#import "ZWPublishArticleController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 150, 50)];
    [btn addTarget:self action:@selector(onShowVCClick) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = UIColor.greenColor;
    [self.view addSubview:btn];
}

- (void)onShowVCClick{
    ZWPublishArticleController *vc = [ZWPublishArticleController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self showViewController:nav sender:nil];
}

@end
