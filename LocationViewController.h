//
//  LocationViewController.h
//  GP2_2
//
//  Created by young on 2015/4/26.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface LocationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *dotImage;
@property (weak, nonatomic) IBOutlet UIPageControl *dotControl;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;



@end
