//
//  ViewController.m
//  testBlocks
//
//  Created by Arcilite on 08.02.17.
//  Copyright © 2017 naxtrader. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
  NSInteger _integer;
  NSString *_string;
  NSMutableArray *_array;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self testMethod];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)testMethod
{
  _integer = 1;
  _string = @"1";
  _array = [@[@1] mutableCopy];
  
 __block NSInteger localInteger = 1;
 __block NSString *localString = @1;
  NSMutableArray *localArray = [@[@1] mutableCopy];
  dispatch_queue_t backgroundQueue = dispatch_queue_create("dispatch_queue_#1", 0);
  dispatch_async(backgroundQueue, ^{
    
    _integer = 2;
    _string = @"2";
    [_array addObject:@2];
    
    localInteger = 2;
    localString = @"2";
    [localArray addObject:@2];
    
    
    NSLog(@"%d", _integer);
    NSLog(@"%@", _string);
    NSLog(@"%@", _array);
    
    NSLog(@"%d", localInteger);
    NSLog(@"%@", localString);
    NSLog(@"%@", localArray);
  });
}
- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
