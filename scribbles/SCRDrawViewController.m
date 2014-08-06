//
//  SCRDrawViewController.m
//  Scribbles
//
//  Created by Merritt Tidwell on 8/4/14.
//  Copyright (c) 2014 Merritt Tidwell. All rights reserved.
//

#import "SCRDrawViewController.h"
#import "SCRDrawView.h"
#import "SCRSliderView.h"
@interface SCRDrawViewController () <SCRSliderViewDelegate>

@end

@implementation SCRDrawViewController
{
    NSArray * colors;
    NSMutableArray * colorButtons;
    UIButton * chooseButton;
    UIButton * bigScribbleButton;
    UIButton * smallScribbleButton;
    UIButton * smallLineButton;
    NSMutableArray * scribbleButtons;
    UIImage * lineImage;
    UIImage * scribbleImage;
    BOOL buttonOpen;
    BOOL colorChoicesOpen;
    UIButton * resetButton;
    
    SCRSliderView * lineSlider;
    UIView * lineWidthSize;
//    UIButton * colorButton;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
   
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
    /*
     Short syntax refresher
     @"" -> NSString
     @[] -> NSArray
     @{} -> NSDictionary
     
     [@[] mutableCopy]  -> NSMutableArray
     [@{} mutableCopy] -> NSMutableDictionary
     */
        self.view =[[SCRDrawView alloc]initWithFrame:self.view.frame];
        
        colorButtons = [@[]mutableCopy];
        scribbleButtons = [@[]mutableCopy];
    // Custom initialization
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated
{
    
    colors = @[
               [UIColor colorWithRed:0.255f green:0.067f blue:0.584f alpha:1.0f],
               [UIColor  colorWithRed:0.024f green:0.204f blue:0.565f alpha:1.0f],
               [UIColor colorWithRed:0.996f green:0.914f blue:0.204f alpha:1.0f],
               [UIColor  colorWithRed:0.173f green:0.996f blue:0.867f alpha:1.0f],
               [UIColor colorWithRed:0.165f green:0.976f blue:0.596f alpha:1.0f],
               [UIColor  colorWithRed:0.988f green:0.071f blue:0.384f alpha:1.0f],
               [UIColor colorWithRed:0.800f green:0.992f blue:0.204f alpha:1.0f],
               [UIColor colorWithRed:0.992f green:0.533f blue:0.141f alpha:1.0f]
               ];
 
  // Reset Button
    resetButton = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-70)/2.0, SCREEN_HEIGHT-200, 60, 60)];
    resetButton.layer.cornerRadius = 15;
    resetButton.backgroundColor = [UIColor cyanColor];
   
    
    [resetButton addTarget:self action:@selector(resetClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:resetButton];
    
    
    
    
    
    // choose button
    
    chooseButton = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-60)/2.0, SCREEN_HEIGHT-70, 60, 60)];
    chooseButton.layer.cornerRadius = 30;
    chooseButton.backgroundColor = colors[0];
    [chooseButton addTarget:self action:@selector(showColorChoices) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chooseButton];
    
   
    // big scribble button
    
    bigScribbleButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-130/2.0, SCREEN_HEIGHT-70,60,60)];
    bigScribbleButton.layer.cornerRadius = 30;
    bigScribbleButton.backgroundColor = [UIColor clearColor];

    
 //   [bigScribbleButton addTarget:self action:@selector (expandButtons)forControlEvents: UIControlEventTouchUpInside];
    
    [self.view addSubview:bigScribbleButton];
    
  //  UIImage * scribbleImage = [UIImage imageNamed:@"scribble_button.png"];
//[bigScribbleButton setImage: scribbleImage forState:UIControlStateNormal];
    
    lineImage = [UIImage imageNamed: @"lines_button.png"];
    scribbleImage = [UIImage imageNamed:@"scribble_button.png"];
    
    //small scribble button
    
    
    smallScribbleButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-115/2.0, SCREEN_HEIGHT-115,40,40)];
    smallScribbleButton.layer.cornerRadius = 40/2;
    smallScribbleButton.backgroundColor = [UIColor clearColor];
    [smallScribbleButton setImage:scribbleImage forState:UIControlStateNormal];
    
    [smallScribbleButton addTarget:self action:@selector (drawScribbles)forControlEvents: UIControlEventTouchUpInside];
    
    [self.view addSubview:smallScribbleButton];
    

   
    
    // small line button
    
    smallLineButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-115/2.0, SCREEN_HEIGHT-160,40,40)];
    smallLineButton.layer.cornerRadius = 40/2;
    smallLineButton.backgroundColor = [UIColor clearColor];
      [smallLineButton setImage:lineImage forState:UIControlStateNormal];
    
    [smallLineButton addTarget:self action:@selector (drawLines)forControlEvents: UIControlEventTouchUpInside];
    
    
    [self.view addSubview:smallLineButton];
    
    
  
    

    
    
    self.view.lineColor = colors[0];
    
    
    [super viewWillAppear:animated];
    
    
    lineWidthSize = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 2,2)];
    lineWidthSize.backgroundColor = [UIColor blackColor];
    [self.view addSubview:lineWidthSize];
    
    UIButton * openLineWidthSlider =[[UIButton alloc]initWithFrame:CGRectMake(20, SCREEN_HEIGHT-60, 40, 40)];
    openLineWidthSlider.layer.cornerRadius = 20;
    openLineWidthSlider.layer.borderWidth = 1.0;
    openLineWidthSlider.layer.borderColor = [UIColor blackColor].CGColor;
    
    [openLineWidthSlider addTarget:self action:@selector(openSlider) forControlEvents:UIControlEventTouchUpInside];
    
    
 
    [self.view addSubview:openLineWidthSlider];
 
    lineWidthSize.center = openLineWidthSlider.center;
    
    
    
  // Do any additional setup after loading the view.

}



-(void)resetClicked
{
    [ self.view.scribbles removeAllObjects];
    [self.view setNeedsDisplay];
}
-(void)drawLines
{
    [bigScribbleButton setImage:lineImage forState:UIControlStateNormal];
    self.view.drawStyleScribble = NO;
}



-(void)drawScribbles
{
 
    [bigScribbleButton setImage:scribbleImage forState:UIControlStateNormal];
    self.view.drawStyleScribble = YES;
    
}




-(void)hideButtons
{
    for(UIButton * colorButton in scribbleButtons)
    {
        NSInteger index =[scribbleButtons indexOfObject:colorButton];
        [UIView animateWithDuration:.2 delay:.05 * index options:UIViewAnimationOptionAllowUserInteraction animations:^{
            
            
            colorButton.center = chooseButton.center;
            
        } completion:^(BOOL finished){
            [colorButton removeFromSuperview];
            
        }];
        
    }
    
    [scribbleButtons removeAllObjects];
    buttonOpen = NO;
 
}


-(void)expandButtons
{
    
    if(buttonOpen)
    {
        [self hideButtons];
        return;
    }
    
    for(UIColor * color in scribbleButtons)
        
    {
        NSInteger index = [scribbleButtons indexOfObject:color];
        
       // UIButton * bigScribbleButton = [[UIButton alloc ]initWithFrame:CGRectMake(10, 10 + (50 * index), 40, 40)];
        
        
       
        
        [UIView animateWithDuration:0.2 delay:0.05 * index options:UIViewAnimationOptionAllowUserInteraction animations:^{
            
    //    bigScribbleButton.center = CGPointMake( moveX, moveY);
            
        }completion:^(BOOL finished){
            
        }];
        
        [self.view insertSubview:bigScribbleButton atIndex:0];
        
        
        
    }
    
   buttonOpen = YES;
    
}


    
    

    
-(void)hideColorChoices
{
    for(UIButton * colorButton in colorButtons)
    {
        NSInteger index =[colorButtons indexOfObject:colorButton];
        [UIView animateWithDuration:.2 delay:.05 * index options:UIViewAnimationOptionAllowUserInteraction animations:^{
            
            
            colorButton.center = chooseButton.center;
     
        } completion:^(BOOL finished){
            [colorButton removeFromSuperview];
            
        }];

    }
    
    [colorButtons removeAllObjects];
    colorChoicesOpen = NO;
    


}



-(void)showColorChoices
{
    if(colorChoicesOpen)
    {
        [self hideColorChoices];
         return;
    }
    
    for(UIColor * color in colors)
        
    {
        NSInteger index = [colors indexOfObject:color];
        
        UIButton * colorButton = [[UIButton alloc ]initWithFrame:CGRectMake(10, 10 + (50 * index), 40, 40)];
        
        
        
        [colorButtons addObject: colorButton ];
        
        colorButton.center = chooseButton.center;
        colorButton.backgroundColor = color;
        colorButton.layer.cornerRadius = 20;
        
        [colorButton addTarget:self action:@selector(changeLineColor:) forControlEvents:UIControlEventTouchUpInside];
        
        
        float radius = 70;
        float mpi = M_PI/180;
        float angle = 360/ colors.count;
        float radians= angle* mpi;
        
        float moveX = chooseButton.center.x + sinf(radians * index)* radius;
        float moveY = chooseButton.center.y + cosf(radians * index)* radius;
        
        [UIView animateWithDuration:0.2 delay:0.05 * index options:UIViewAnimationOptionAllowUserInteraction animations:^{
            
            colorButton.center = CGPointMake(moveX, moveY);
            
        }completion:^(BOOL finished){
            
        }];
        
        [self.view insertSubview:colorButton atIndex:0];
        
        
        
    }

    colorChoicesOpen = YES;
    
}

-(void)openSlider
{
    if (lineSlider) {
        [lineSlider removeFromSuperview];
        lineSlider = nil;
        return;
    }
    
    
    lineSlider = [[SCRSliderView alloc]initWithFrame:CGRectMake(20, SCREEN_HEIGHT-280, 40, 200)];
    
    lineSlider.currentWidth= self.view.lineWidth;
  
    
    lineSlider.delegate = self;
    
    [self.view addSubview:lineSlider];
}


-(void)updateLineWidth:(float)lineWidth
{
    self.view.lineWidth = lineWidth;
    CGPoint center = lineWidthSize.center;
    lineWidthSize.frame = CGRectMake(0, 0, lineWidth*2, lineWidth*2);
    lineWidthSize.center = center;
    lineWidthSize.layer.cornerRadius = lineWidth;

}

-(void)centerButtonWasPressed
{
    
}

-(void)changeLineColor:(UIButton *)button
{
    SCRDrawView * view = (SCRDrawView *) self.view;
    view.lineColor = button.backgroundColor;
    [view setNeedsDisplay];
    chooseButton.backgroundColor = button.backgroundColor;
    
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
