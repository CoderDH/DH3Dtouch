//
//  DHChildViewController.m
//  DH3D Touch
//
//  Created by 董浩 on 16/4/15.
//  Copyright © 2016年 donghao. All rights reserved.
//

#import "DHChildViewController.h"

@interface DHChildViewController ()

@end

@implementation DHChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//上滑手势标签
-(NSArray<id<UIPreviewActionItem>> *)previewActionItems{
    
    UIPreviewAction *action1=[UIPreviewAction actionWithTitle:@"赞" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"赞");
    }];
    
    UIPreviewAction *action2=[UIPreviewAction actionWithTitle:@"评论" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"评论");
    }];
    
    UIPreviewAction *action3=[UIPreviewAction actionWithTitle:@"转发" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"转发");
    }];
    
    NSArray *actions=@[action1,action2,action3];
    
    
    return actions;
    
    
    
    
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
