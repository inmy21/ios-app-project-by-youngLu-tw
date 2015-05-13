//
//  StoryPage.m
//  GP2_2
//
//  Created by iiiedu6 on 2015/4/21.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "StoryPage.h"
#import "CoreDataHelper.h"
#import "Note.h"
#import "webPage.h"
#import <MediaPlayer/MediaPlayer.h>

@interface StoryPage ()<NSXMLParserDelegate, UITableViewDelegate >
@property (nonatomic) NSString * processTag;
@property (nonatomic) NSMutableArray *array;
@property (nonatomic) NSMutableArray *notes;
@property (weak, nonatomic) IBOutlet UILabel *storyLabel;
@property (weak, nonatomic) IBOutlet UIView *movieView;
@property (nonatomic) MPMoviePlayerController *moviePlayer;
-(void)moviePlayerToPlay;
-(void)coutBack;
@end

@implementation StoryPage
bool firstEnter = 1;
int counter = 0;


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishUpdate:) name:@"NoteUpdated" object:nil];
        
        }
    return self;
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

-(void)saveToCoreData{
    
    CoreDataHelper *helper = [CoreDataHelper sharedInstance];
    NSManagedObjectContext *moc = [helper managedObjectContext];
    Note *note = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:moc];
    note.cointing = [NSNumber numberWithInt:counter];
    NSError *error = nil;
    [moc save:&error]; //儲存
    if ( error ){
        NSLog(@" error %@",error);
    }
}
-(void)loadFromCoreData{
    CoreDataHelper *helper = [CoreDataHelper sharedInstance];
    NSManagedObjectContext *moc = [helper managedObjectContext]; //取得object context物件
    //產生查詢物件，指定要查詢Note Table(entity)
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Note"];
        NSError *error = nil;
    //執行查詢
    NSArray *results = [moc executeFetchRequest:request error:&error];
    if ( error ){
        NSLog(@"error %@",error);
    }else{
        //將查詢出來Note物件放在notes中
        self.notes = [NSMutableArray arrayWithArray:results];
    }
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)coutBack{
    
    static int G_notificationCounter =0;
    
    
    G_notificationCounter = G_notificationCounter +1;
    if (G_notificationCounter == 10) {
        NSString *message = [NSString stringWithFormat:@"謝謝您的使用"];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil  message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *connectFB = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [alert dismissViewControllerAnimated:true completion:nil];
            
        }];
        [alert addAction:connectFB];
        [self presentViewController:alert animated:true completion:nil];
        G_notificationCounter = 0;
    }
    
    NSLog(@"G_notificationCounter = %d", G_notificationCounter);
    
}
-(void)finishUpdate:(NSNotification* )notification{
    [self coutBack];
    
   
    
}
-(void)moviePlayerToPlay{
    
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"Welcome to League of Legends (Low).mp4" withExtension:nil];
    self.moviePlayer = [[MPMoviePlayerController alloc]initWithContentURL:url];
    self.moviePlayer.controlStyle = MPMovieControlStyleNone;
//    self.moviePlayer.backgroundView.frame = self.movieView.bounds;
   
    
    [self.moviePlayer.view setFrame:self.movieView.bounds];
    [self.movieView addSubview:self.moviePlayer.view];
//    CGSize size = self.movieView.frame.size;  // 取得viewController底層的size
    self.moviePlayer.view.frame = CGRectMake(0, 0, 368, 250);
    [self.moviePlayer prepareToPlay];
    [self.moviePlayer play];
    [self.moviePlayer shouldAutoplay ];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = [[NSMutableArray alloc]init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"story" ofType:@"xml"];
    //NSURL * url = [NSURL URLWithString:@"http://zh.wikipedia.org/wiki/Wikipedia:%E5%85%B3%E4%BA%8E"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //NSData * xmlData = [NSData dataWithContentsOfURL:url];
        NSData *xmlData = [[NSData alloc] initWithContentsOfFile:path];
        NSXMLParser * parser = [[NSXMLParser alloc]initWithData:xmlData];
        parser.delegate = self;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [parser parse];
        });
        
    });
    [self moviePlayerToPlay];
    
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NoteUpdated" object:nil userInfo:nil];
    counter = counter+1;
    
    [self saveToCoreData];
    [self loadFromCoreData];
    /*alert first enter into app*/
    if(firstEnter == 1){
        NSString *message = [NSString stringWithFormat:@"本app已經瀏覽第%lu次",self.notes.count];
        NSLog(@"notes count = %lu",(unsigned long)self.notes.count);
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil  message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [alert dismissViewControllerAnimated:true completion:nil];
        
        }];
        [alert addAction:ok];
        [self presentViewController:alert animated:true completion:nil];
        firstEnter = 0;
    }
    
    

}


-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
     NSInteger stringLength = [string length];
    if (stringLength > 5 ) {
        
         //NSLog(@"foundCharacters %@", string);
        [self.array addObject:string];
         //NSLog(@"array count %lu", self.array.count);
        NSMutableString *outputList = [[NSMutableString alloc] init];
        
        
        for (int i=0; i<_array.count; i++) {
//            NSLog(@"%@",[_array objectAtIndex:i]);
            [outputList appendString:[_array objectAtIndex:i]];
            if (i < (_array.count - 1)) {
                [outputList appendString:@", "];
            }
        }
        
        
        //NSLog(@"outputList: %@", outputList);
        self.storyTextView.text = outputList;

       
        
    }
}
   
    
    

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    
    //NSLog(@"didEndElement");
    //NSLog(@"elementName %@", elementName);
    
    // method 1
    self.processTag =nil; // prcessTag 清除就不會再跑到 foundCharacters
    // method 2
    //    if ([elementName isEqualToString:@"mediaid"]) {
    //        self.mediaIDLabel.text = self.text;
    //    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    float y = arc4random() % 255;
    float x = arc4random() % 255;
    float z = arc4random() % 255;
    
    
    NSLog(@"Content offset: %f", scrollView.contentOffset.y);
    self.view.backgroundColor  = [UIColor colorWithRed:x/255 green:y/255 blue:z/255 alpha:1];
    
}



@end
