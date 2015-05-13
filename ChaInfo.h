//
//  ChaInfo.h
//  GP2_2
//
//  Created by young on 2015/4/18.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CoreDataHelper.h"

#import "Movie.h"


@interface ChaInfo : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) Movie *movie;




@end
