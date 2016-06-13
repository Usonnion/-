//
//  Star.h
//  NewZhiyou
//
//  Created by user on 11-8-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Star : UIView 

@property (nonatomic, assign) CGFloat font_size;
@property (nonatomic, assign) NSInteger max_star;
@property (nonatomic, assign) NSInteger show_star;
@property (nonatomic, retain) UIColor *empty_color;
@property (nonatomic, retain) UIColor *full_color;
@property (nonatomic, assign) BOOL isSelect; 

@end
