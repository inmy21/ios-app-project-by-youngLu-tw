//
//  LoginPage.m
//  GP2_2
//
//  Created by iiiedu6 on 2015/5/7.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "LoginPage.h"
#import "user.h"
#import <Parse/Parse.h>

#define ServerApiURL @"http://localhost:8888/LOL/"
@interface LoginPage ()
{
    NSMutableData *downloadedData;
    NSString *newAcountName;
    NSString *newPassword;
    NSMutableArray *userDB;
}
-(void)parse;
-(void)readMysql;
-(void)createNewAcount;
-(void)createNewPassword;
- (BOOL)validateAccount:(NSString *)account;
@end

@implementation LoginPage
-(void)createNewPassword{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"set your pssword" message:@"please enter your password" preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        
        textField.textColor = [UIColor blueColor];
        
        textField.font =[UIFont fontWithName:@"Georgia-BoldItalic" size:20];
        
        textField.placeholder =@"123abc";
        
    }];
    
    
    
    UIAlertAction *done = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        NSString *newAcountpassword = ((UITextField *)[alertController.textFields objectAtIndex:0]).text;
        NSLog(@"newAcountName = %@",newAcountpassword);
        
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    
    
    
    [alertController addAction:done];
    
    [alertController addAction:cancel];
    
    [self presentViewController:alertController animated:YES completion:^{NSLog(@"newPassword = %@",newPassword);}];

}
-(void)createNewAcount{
  
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"create an acount" message:@"please enter your name" preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        
        textField.textColor = [UIColor blueColor];
        
        textField.font =[UIFont fontWithName:@"Georgia-BoldItalic" size:20];
        
        textField.placeholder =@"ex:young";
        
    }];
    
    
    
    UIAlertAction *done = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        newAcountName = ((UITextField *)[alertController.textFields objectAtIndex:0]).text;
        NSLog(@"newAcountName = %@",newAcountName);
        [self createNewPassword];
        
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    
    
    
    [alertController addAction:done];
    
    [alertController addAction:cancel];
    
    
    
    [self presentViewController:alertController animated:YES completion:nil];
    }
- (IBAction)signUp:(id)sender {
    [self createNewAcount];
   
}
- (IBAction)logIn:(id)sender {
    NSString *userName = self.loginName.text;
    NSString *userPassword = self.loginCode.text;
    bool checkName = [self validateAccount:userName];
    bool checkPassword = [self validateAccount:userPassword];
    
    if (checkName && checkPassword) {
        
        
        for (int i = 0; i< userDB.count; i++) {
            self.user = userDB[i];
            
        
            if ([self.loginName.text isEqualToString:self.user.name]) {
                
                NSString *message = [NSString stringWithFormat:@"登入成功"];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil  message:message preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    [alert dismissViewControllerAnimated:true completion:nil];
                    
                }];
                [alert addAction:ok];
                [self presentViewController:alert animated:true completion:nil];
               


                
                }
            }
        if ([self.loginName.text isEqualToString:self.user.name] == 0) {
            NSString *message = [NSString stringWithFormat:@"帳號密碼輸入錯誤"];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil  message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                [alert dismissViewControllerAnimated:true completion:nil];
                
            }];
            [alert addAction:ok];
            [self presentViewController:alert animated:true completion:nil];
        }
    }else{
        NSString *message = [NSString stringWithFormat:@"帳號密碼輸入錯誤"];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil  message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [alert dismissViewControllerAnimated:true completion:nil];
            
        }];
        [alert addAction:ok];
        [self presentViewController:alert animated:true completion:nil];
    

    }


}



   - (BOOL)validateAccount:(NSString *)account{
    NSString *regex = @"[A-Z0-9a-z]{1,18}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:account];
}



-(void)readMysql{
    NSURL *jsonFileUrl = [NSURL URLWithString:@"http://localhost:8888/LOL/signUP.php"];
    
    // Create the request
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileUrl];
    
    // Create the NSURLConnection
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
}

#pragma mark NSURLConnectionDataProtocol Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // Initialize the data object
    downloadedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the newly downloaded data
    [downloadedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    
    // Parse the JSON that came in
    
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:downloadedData options:NSJSONReadingAllowFragments error:&error];
    
    
     userDB = [NSMutableArray new];
    NSLog(@"資料庫連線成功內有%lu筆資料", (unsigned long)jsonArray.count);
    
    for (int i = 0; i < jsonArray.count; i++)
    {
        NSDictionary *jsonElement = jsonArray[i];
        
        user *userinfo = [user new];
        userinfo.name = jsonElement[@"name"];
        userinfo.passWord = jsonElement[@"password"];
       
        [userDB addObject:userinfo];
        NSLog(@"user list = %@",userinfo.name);
        

    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self readMysql];
//    NSMutableArray *userDB= [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)parse{
        PFObject *parseList;
        parseList = [[PFObject alloc]initWithClassName:@"ClassName"];
        parseList [@"userName"] =@"bill";
        parseList [@"userCode"] = @"kk1111";
    
        [parseList saveInBackgroundWithBlock:^(bool succeeded, NSError *error){
            if(succeeded){
                NSLog(@"login成功");
            }else{
                NSLog(@"login失敗, error : %@",error);
            }
        }];

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
