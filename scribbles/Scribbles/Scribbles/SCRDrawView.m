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
        self.scribblePoints = [@[] mutableCopy];
        self.lineColor = [UIColor darkGrayColor];
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
    // we create this if statement so that you it won't crash saying there is nothing in the array//
    
    if(self.scribblePoints.count > 0)
    {
        CGPoint startPoint = [self.scribblePoints[0] CGPointValue];
        
        CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    }
    
    
    for (NSValue * pointVal in self.scribblePoints)
    {
        CGPoint point = [pointVal CGPointValue];
        CGContextAddLineToPoint(context, point.x, point.y);
    
    }
    
    
    //this draws the context
    CGContextStrokePath(context);

}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self scribbleWithTouches:touches];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self scribbleWithTouches:touches];
}

-(void)scribbleWithTouches: (NSSet *)touches
{
    for(UITouch * touch in touches)
    {
        CGPoint location = [touch locationInView: self];
        
        [self.scribblePoints addObject: [NSValue valueWithCGPoint:location]];
        
    }
    
    [self setNeedsDisplay];
}

@end
