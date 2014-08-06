//
//  SCRDrawView.m
//  Scribbles
//
//  Created by Merritt Tidwell on 8/4/14.
//  Copyright (c) 2014 Merritt Tidwell. All rights reserved.
//

#import "SCRDrawView.h"

@implementation SCRDrawView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //always alloc and init array
        self.scribbles = [@[] mutableCopy];
        self.lineColor = [UIColor darkGrayColor];
        self.lineWidth= 1;
        self.backgroundColor = [UIColor whiteColor];
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code

    
    //this grabs our context layer to draw on
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //this sets stroke or fill colors that follow
    [self.lineColor set];

    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    for (NSDictionary * scribble in self.scribbles)
    
    
    {
        CGContextSetLineWidth(context,[scribble[@"width"]intValue]);

        NSArray * points= scribble[@"points"];
    
        UIColor * lineColor = scribble[@"color"];
        
        [lineColor set];
        
        if(self.scribbles.count > 0)
        {
            CGPoint startPoint = [points[0] CGPointValue];
            
            CGContextMoveToPoint(context, startPoint.x, startPoint.y);
        }
        
        
        for (NSValue * pointVal in points)
        {
            CGPoint point = [pointVal CGPointValue];
            CGContextAddLineToPoint(context, point.x, point.y);
            
        }
        //this draws the context
        CGContextStrokePath(context);
    }
    
    
    
    // we create this if statement so that you it won't crash saying there is nothing in the array//
    
    
    

}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
//    int random = arc4random_uniform(20) + 5;
    
   
    self.currentScribble = [@{
                              @"color":self.lineColor,
                              @"points": [@[] mutableCopy],
                              @"width":@(self.lineWidth)
                            } mutableCopy];
    
    [self.scribbles addObject:self.currentScribble];
    
//    [self scribbleWithTouches:touches];
    // this is for lines
    UITouch * touch = [touches allObjects][0];
    CGPoint location = [touch locationInView:self];
    self.currentScribble[@"points"][0] = [NSValue valueWithCGPoint:location];
    [self setNeedsDisplay];
    if (self.drawStyleScribble) {
      
        [self scribbleWithTouches:touches];
    } else
    
    {UITouch * touch = [touches allObjects][0];
        CGPoint location = [touch locationInView:self];
        self.currentScribble[@"points"][0] = [NSValue valueWithCGPoint:location];
        [self setNeedsDisplay];

        
    }


}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
//    [self scribbleWithTouches:touches];

    // this is for lines
    
    if (self.drawStyleScribble) {
        
        [self scribbleWithTouches:touches];
    } else
        
    {UITouch * touch = [touches allObjects][0];
        CGPoint location = [touch locationInView:self];
        self.currentScribble[@"points"][1] = [NSValue valueWithCGPoint:location];
        [self setNeedsDisplay];
        
        
    }
    

    
    
}

-(void)scribbleWithTouches: (NSSet *)touches
{
    for(UITouch * touch in touches)
    {
        CGPoint location = [touch locationInView: self];
        
        [self.currentScribble [@"points"] addObject: [NSValue valueWithCGPoint:location]];
        
    }
    
    [self setNeedsDisplay];
}

@end
