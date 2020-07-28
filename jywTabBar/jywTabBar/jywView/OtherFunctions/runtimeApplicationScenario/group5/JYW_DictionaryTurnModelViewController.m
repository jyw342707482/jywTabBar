//
//  JYW_DictionaryTurnModelViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/22.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_DictionaryTurnModelViewController.h"
#import "JYW_DictionaryTurnModel.h"
#import "NSObject+JYW_DictionaryTurnModel.h"
@interface JYW_DictionaryTurnModelViewController ()
{
    NSDictionary *dictionary1;
    JYW_DictionaryTurnModel *dtm1;
    JYW_DictionaryTurnModel1 *dtm2;
    JYW_DictionaryTurnModel2 *dtm3;
}
@end

@implementation JYW_DictionaryTurnModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(IBAction)btn1_Click:(id)sender{
    dictionary1=@{@"dtmId":@1,@"dtmName":@"name",@"dtmRemark":@"备注"};
    dtm1=[[JYW_DictionaryTurnModel alloc] init];
    BOOL isOK=[dtm1 dictionaryTurnModel1:dictionary1];
    if(isOK){
        messageTextView.text=[NSString stringWithFormat:@"模型：dtmId:%d;dtmName:%@;dtmRemark:%@",dtm1.dtmId,dtm1.dtmName,dtm1.dtmRemark];
    }
    else{
        messageTextView.text=@"报错了！";
    }
    
}
-(IBAction)btn2_Click:(id)sender{
    NSArray *array1=@[
    @{@"dtmId":@2,@"dtmName":@"name2",@"dtmRemark":@"备注2"},
    @{@"dtmId":@3,@"dtmName":@"name3",@"dtmRemark":@"备注3"},
    @{@"dtmId":@4,@"dtmName":@"name4",@"dtmRemark":@"备注4"}
    ];
    dictionary1=@{@"dtmId":@1,@"dtmName":@"name",@"dtmRemark":@"备注",@"dtmArray":array1};
    dtm2=[[JYW_DictionaryTurnModel1 alloc] init];
    BOOL isOK=[dtm2 dictionaryTurnModel2:dictionary1];
    if(isOK){
        messageTextView.text=[NSString stringWithFormat:@"模型：dtmId:%d;dtmName:%@;dtmRemark:%@;字典数组:",dtm2.dtmId,dtm2.dtmName,dtm2.dtmRemark];
        for(int i=0;i<dtm2.dtmArray.count;i++){
            JYW_DictionaryTurnModel1 *model1=dtm2.dtmArray[i];
            messageTextView.text=[messageTextView.text stringByAppendingFormat:@"dtmId:%d;dtmName:%@;dtmRemark:%@;",model1.dtmId,model1.dtmName,model1.dtmRemark];
        }
    }else{
        messageTextView.text=@"报错了！";
    }
}
-(IBAction)btn3_Click:(id)sender{
    NSDictionary *dictionary=@{@"dtmId":@2,@"dtmName":@"name2",@"dtmRemark":@"备注2"};
    dictionary1=@{@"dtmId":@1,@"dtmName":@"name",@"dtmRemark":@"备注",@"dtmDictionary":dictionary};
    dtm3=[[JYW_DictionaryTurnModel2 alloc] init];
    BOOL isOK=[dtm3 dictionaryTurnModel2:dictionary1];
    if(isOK){
        messageTextView.text=[NSString stringWithFormat:@"模型：dtmId:%d;dtmName:%@;dtmRemark:%@;字典:",dtm3.dtmId,dtm3.dtmName,dtm3.dtmRemark];
        JYW_DictionaryTurnModel2 *model2=(NSDictionary *)dtm3.dtmDictionary;
        messageTextView.text=[messageTextView.text stringByAppendingFormat:@"dtmId:%d;dtmName:%@;dtmRemark:%@;",model2.dtmId,model2.dtmName,model2.dtmRemark];
    }
    else{
        messageTextView.text=@"报错了！";
    }
}
@end
