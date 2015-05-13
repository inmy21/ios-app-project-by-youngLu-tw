//
//  LoginPage.h
//  GP2_2
//
//  Created by iiiedu6 on 2015/5/7.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "user.h"


@interface LoginPage : UIViewController
@property (weak, nonatomic) user *user;
@property (weak, nonatomic) IBOutlet UITextField *loginName;
@property (weak, nonatomic) IBOutlet UITextField *loginCode;


@end
