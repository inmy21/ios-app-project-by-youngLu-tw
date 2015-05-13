//
//  LocationViewController.m
//  GP2_2
//
//  Created by young on 2015/4/26.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>
{
    NSMutableArray *imageArray;
    CLLocationManager *locationManager;
    BOOL firstLocationReceived;
}
-(void)showImage;
@end

@implementation LocationViewController
- (IBAction)doSwipe:(UISwipeGestureRecognizer *)sender {
    NSLog(@"into handleSwipe block");
    switch (sender.direction) {
        case UISwipeGestureRecognizerDirectionRight:
            if (self.dotControl.currentPage < [imageArray count]) {
                self.dotControl.currentPage++;
                [self showImage];
                NSLog(@"right");
            }
            break;
            
        case UISwipeGestureRecognizerDirectionLeft:
            if (self.dotControl.currentPage > 0) {
                self.dotControl.currentPage--;
                [self showImage];
                NSLog(@"left");
            }
            break;
            
            
        default:;
            
    }

}

-(void)showImage;{
    NSString *filename = [imageArray objectAtIndex:self.dotControl.currentPage];
    self.dotImage.image = [UIImage imageNamed:filename];
    NSLog(@"did method : showImage ");

}


- (void)viewDidLoad {
    [super viewDidLoad];
    imageArray = [[NSMutableArray alloc]initWithObjects:@"location1.jpg",@"location2.jpg",@"location3.jpg", nil];
    self.dotControl.numberOfPages = [imageArray count];
    [self showImage];
    
   
   
    
    MKPointAnnotation *point;
    point = [[MKPointAnnotation alloc]init];
    point.coordinate = CLLocationCoordinate2DMake(25.079798,121.566947);
    point.title =@"Garena 電競館";
    point.subtitle = @"台北市內湖區瑞光路550號";
    
    [self.mapView setCenterCoordinate:point.coordinate];
    
    MKCoordinateSpan span;
    span.latitudeDelta = 0.001;
    span.longitudeDelta = 0.001;
    MKCoordinateRegionMake(point.coordinate, span);
    
    MKCoordinateRegion region = [self.mapView region];
    region.span = span;
    [self.mapView setRegion:region animated:YES];
    [self.mapView addAnnotation:point];

}


-(void)viewDidAppear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NoteUpdated" object:nil userInfo:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
