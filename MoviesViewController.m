//
//  MoviesViewController.m
//  CustomizingTableViewCell
//
//  Created by Arthur Knopper on 1/2/13.
//  Copyright (c) 2013 Arthur Knopper. All rights reserved.
//

#import "MoviesViewController.h"
#import "Movie.h"
#import "MovieCell.h"
#import "ChaInfo.h"
#import <AVFoundation/AVFoundation.h>




@interface MoviesViewController ()<UITableViewDataSource,UITableViewDelegate,AVAudioPlayerDelegate>

@end

@implementation MoviesViewController



-(void)viewDidAppear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NoteUpdated" object:nil userInfo:nil];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
       
/********* movie tableView data ***********/
    self.movies = [NSMutableArray arrayWithCapacity:5];
    
    Movie *movie = [[Movie alloc] init];
    movie.chaName = @"阿璃 Ahri";
    movie.EName =@"Ahri";
    movie.title = @"九尾妖狐";
  
    [self.movies addObject:movie];
    
    movie = [[Movie alloc] init];
    movie.chaName = @"阿卡莉 Akali";
    movie.EName =@"Akali";
    movie.title = @"暗影之拳";

    [self.movies addObject:movie];
    
    movie = [[Movie alloc] init];
    movie.chaName = @"亞歷斯塔 Alistar";
    movie.EName =@"Alistar";
    movie.title = @"牛頭酋長 ";
    
    [self.movies addObject:movie];
    
    movie = [[Movie alloc] init];
    movie.chaName = @"阿姆姆 Amumu";
    movie.EName =@"Amumu";
    movie.title = @"殤之木乃伊";;
    
    [self.movies addObject:movie];
    
    movie = [[Movie alloc] init];
    movie.chaName = @"厄薩斯 Aatrox";
    movie.EName =@"Aatrox";
    movie.title = @"冥血邪劍 ";
    
    [self.movies addObject:movie];
    NSLog(@"%@",NSHomeDirectory());
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.movies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MovieCell";
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Movie *movie = (self.movies)[indexPath.row];
    
    
    cell.titleLabel.text = movie.chaName;
    cell.yearLabel.text = movie.title ;
    cell.posterImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"chaTable%lu", (long)indexPath.row+1]];
    
    
    return cell;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ChaInfo *chainfo= segue.destinationViewController;
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    chainfo.movie = self.movies[indexPath.row];
    
    
    
    NSLog(@"movies.count = %lu",(long)indexPath.row);
//    NSLog(@"movie countNumber %lu",(long)chainfo.movie.countNumber);
    
}



@end
