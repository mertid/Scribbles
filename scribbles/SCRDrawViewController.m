//
//  SCRDrawViewController.m
//  Scribbles
//
//  Created by Merritt Tidwell on 8/4/14.
//  Copyright (c) 2014 Merritt Tidwell. All rights reserved.
//

#import "SCRDrawViewController.h"
#import "SCRDrawView.h"
@interface SCRDrawViewController ()

@end

@implementation SCRDrawViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
   
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
    
        self.view =[[SCRDrawView alloc]initWithFrame:self.view.frame];
     
    // Custom initialization
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSArray * colors = @[
                         [UIColor redColor],
                         [UIColor magentaColor],
                         [UIColor yellowColor],
                         [UIColor blueColor],
                         
                         ];
    
    // Do any additional setup after loading the view.
    
    UIButton * redButton = [[UIButton alloc ]initWithFrame:CGRectMake(10, 10, 40, 40)];
    redButton.backgroundColor =[UIColor redColor];
    redButton.layer.cornerRadius = 20;
    
    [redButton addTarget:self action:@selector(changeLineColor:) forControlEvents:UIControlEventTouchUpInside];
   
    [self.view addSubview:redButton];

}

-(void)changeLineColor:(UIButton *)button
{
    SCRDrawView * view = (SCRDrawView *) self.view;
    view.lineColor = button.backgroundColor;
    [view setNeedsDisplay];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)prefersStatusBarHidden {return YES;}


@end
