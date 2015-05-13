//
//  webPage.m
//  GP2_2
//
//  Created by iiiedu6 on 2015/4/16.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "webPage.h"
#import "StoryPage.h"
#import "Note.h"
#import "CoreDataHelper.h"

@interface webPage ()
@property (weak, nonatomic) IBOutlet UIWebView *webPage;


@end

@implementation webPage
int count = 0;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    NSURL *url = [NSURL URLWithString:@"http://lol.garena.tw/champions/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webPage loadRequest:request];
    
    
    
    
    


}
-(void)viewDidAppear:(BOOL)animated{

    [[NSNotificationCenter defaultCenter] postNotificationName:@"NoteUpdated" object:nil userInfo:nil];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

    //self.note.cointing = [NSNumber numberWithInt:count];
       
   


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
