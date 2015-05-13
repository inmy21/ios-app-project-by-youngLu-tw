#import "ChaInfo.h"





@interface ChaInfo ()

@property(nonatomic) NSMutableArray *heros;
@property (weak, nonatomic) IBOutlet UITextField *hpText;
@property (weak, nonatomic) IBOutlet UITextField *mpText;
@property (weak, nonatomic) IBOutlet UITextView *storyText;
-(void)jsonContent;

@end



@implementation ChaInfo
-(void)jsonContent{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"JsonExample" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *jsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"jsonObj = %lu", (unsigned long)jsonObj.count);
    
    
    NSDictionary* jsonDic = [jsonObj objectForKey:self.movie.EName];
    NSString *HP = [jsonDic objectForKey:@"生命"];
    NSString *MP = [jsonDic objectForKey:@"魔力"];
    NSString *story =[jsonDic objectForKey:@"story"];
    NSLog(@"name = %@",self.movie.EName);
    NSLog(@"HP = %@ ; MP = %@",HP,MP);
    self.hpText.text =HP;
    self.mpText.text =MP;
    self.storyText.text = story;

    
   }


- (void)viewDidLoad {
    [super viewDidLoad];
    [self jsonContent];
    self.nameLabel.text = self.movie.chaName;
   
}


   - (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}





@end
