//
//  SCRSliderView.h
//  Scribbles
//
//  Created by Merritt Tidwell on 8/4/14.
//  Copyright (c) 2014 Merritt Tidwell. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCRSliderViewDelegate;

@interface SCRSliderView : UIView

@property (nonatomic) float maxWidth;
@property (nonatomic) float minWidth;
@property (nonatomic) float currentWidth;
@property (nonatomic) UIColor * lineColor;


@property (nonatomic, assign) id <SCRSliderViewDelegate> delegate;

@end

@protocol SCRSliderViewDelegate <NSObject>

- (void)updateLineWidth:(float)lineWidth;





@end