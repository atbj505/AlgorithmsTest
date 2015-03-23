//
//  ViewController.m
//  Algorithms
//
//  Created by Robert on 15/3/21.
//  Copyright (c) 2015年 NationSky. All rights reserved.
//

#import "ViewController.h"

#define GAP 30
@interface ViewController ()

@property (nonatomic, strong)NSArray *testArray;
@property (nonatomic, strong)UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //测试数组初始化
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Property List" ofType:@"plist"];
    self.testArray = [NSArray arrayWithContentsOfFile:plistPath];

    //测试case
    [self addCaseButton];
}
- (void)addCaseButton {
    WS(ws);
    self.textField = [UITextField new];
    self.textField.layer.borderWidth = 1;
    self.textField.layer.borderColor = [UIColor redColor].CGColor;
    self.textField.layer.cornerRadius = 3;
    self.textField.layer.masksToBounds = YES;
    self.textField.text = @"我去他妈的滚蛋！！！！。。。啊啊啊啊啊";
    [self.view addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.view).with.offset(100);
        make.centerX.mas_equalTo(ws.view);
        make.width.mas_equalTo(@250);
        make.height.mas_equalTo(@35);
    }];

    UIButton *btn1 = [UIButton new];
    [btn1 setTitle:@"For In" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(testMethod:) forControlEvents:UIControlEventTouchUpInside];
    btn1.tag = 1;
    [self.view addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.textField).with.offset(GAP*2);
        make.centerX.mas_equalTo(ws.view);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@30);
    }];
    
    UIButton *btn2 = [UIButton new];
    [btn2 setTitle:@"Enumerate Block" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(testMethod:) forControlEvents:UIControlEventTouchUpInside];
    btn2.tag = 2;
    [self.view addSubview:btn2];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btn1).with.offset(GAP);
        make.centerX.mas_equalTo(ws.view);
        make.width.mas_equalTo(@150);
        make.height.mas_equalTo(@30);
    }];
    
    UIButton *btn3 = [UIButton new];
    [btn3 setTitle:@"Linear search" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(testMethod:) forControlEvents:UIControlEventTouchUpInside];
    btn3.tag = 3;
    [self.view addSubview:btn3];
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btn2).with.offset(GAP);
        make.centerX.mas_equalTo(ws.view);
        make.width.mas_equalTo(@150);
        make.height.mas_equalTo(@30);
    }];
    
    UIButton *btn4 = [UIButton new];
    [btn4 setTitle:@"Half search" forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(testMethod:) forControlEvents:UIControlEventTouchUpInside];
    btn4.tag = 4;
    [self.view addSubview:btn4];
    [btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btn3).with.offset(GAP);
        make.centerX.mas_equalTo(ws.view);
        make.width.mas_equalTo(@150);
        make.height.mas_equalTo(@30);
    }];
    
    UIButton *btn5 = [UIButton new];
    [btn5 setTitle:@"NSSet" forState:UIControlStateNormal];
    [btn5 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn5 addTarget:self action:@selector(testMethod:) forControlEvents:UIControlEventTouchUpInside];
    btn5.tag = 5;
    [self.view addSubview:btn5];
    [btn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btn4).with.offset(GAP);
        make.centerX.mas_equalTo(ws.view);
        make.width.mas_equalTo(@150);
        make.height.mas_equalTo(@30);
    }];
    
    UIButton *btn6 = [UIButton new];
    [btn6 setTitle:@"Structure Test" forState:UIControlStateNormal];
    [btn6 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn6 addTarget:self action:@selector(testMethod:) forControlEvents:UIControlEventTouchUpInside];
    btn6.tag = 6;
    [self.view addSubview:btn6];
    [btn6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btn5).with.offset(GAP);
        make.centerX.mas_equalTo(ws.view);
        make.width.mas_equalTo(@150);
        make.height.mas_equalTo(@30);
    }];
}

- (void)testMethod:(UIButton *)btn {
    NSMutableDictionary *dic = [self.testArray structureTest];
    [[BTFilter shareBTFilter] keyWordWriteWithDictionary:dic];
    NSString *textString = self.textField.text;
    TICK;
    switch (btn.tag) {
        case 1:
        {
            NSLog(@"********For In");
            [self.testArray linearSearchForIn:textString];
            break;
        }
        case 2:
        {
            NSLog(@"********Enumerate Block");
            [self.testArray linearSearchEnumerate:textString];
            break;
        }
        case 3:
        {
            NSLog(@"********Linear search");
            [self.testArray linearSearchFor:textString];
            break;
        }
        case 4:
        {
            NSLog(@"********Binary search");
            [self.testArray halfSearch:textString];
            break;
        }
        case 5:
        {
            NSLog(@"********NSSet Search");
            [self.testArray setSearch:textString];
            break;
        }
        case 6:
        {
            NSLog(@"********structure test");
            NSString *result = [[BTFilter shareBTFilter] filterWithString:textString];
            NSLog(@"%@",result);
            break;
        }
    }
    TOCK;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.textField resignFirstResponder];
}

@end
