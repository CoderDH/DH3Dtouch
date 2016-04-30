//
//  DHTextTwoViewController.m
//  DH3D Touch
//
//  Created by 董浩 on 16/4/15.
//  Copyright © 2016年 donghao. All rights reserved.
//

#import "DHTextTwoViewController.h"

@interface DHTextTwoViewController ()

@end

@implementation DHTextTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        
    }
    -(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
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
