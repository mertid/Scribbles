//
//  SCRDrawView.h
//  Scribbles
//
//  Created by Merritt Tidwell on 8/4/14.
//  Copyright (c) 2014 Merritt Tidwell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCRDrawView : UIView
@property (nonatomic) NSMutableArray * scribbles;
//@property (nonatomic) NSMutableArray *scribblePoints;

@property (nonatomic) NSMutableDictionary * currentScribble;

@property (nonatomic) UIColor * lineColor;
@property (nonatomic) int lineWidth;
@property (nonatomic) BOOL drawStyleScribble;


@end
