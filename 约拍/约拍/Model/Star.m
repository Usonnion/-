//
//  Star.m
//  NewZhiyou
//
//  Created by user on 11-8-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Star.h"

@implementation Star

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _max_star = 100;
        _show_star = 0;
        _isSelect = NO;
        
        self.backgroundColor = [UIColor clearColor];
        _font_size = 13.0f;
        self.empty_color = [UIColor colorWithRed:167.0f / 255.0f green:167.0f / 255.0f blue:167.0f / 255.0f alpha:1.0f];
        self.full_color = [UIColor colorWithRed:255.0f / 255.0f green:121.0f / 255.0f blue:22.0f / 255.0f alpha:1.0f];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSString* stars=@"★★★★★";
    
    rect= self.bounds;
    UIFont *font = [UIFont boldSystemFontOfSize: _font_size];
    CGSize starSize = [stars sizeWithAttributes:@{NSFontAttributeName: font}];
    rect.size=starSize;
    //    [stars drawInRect:rect withFont:font];
    [stars drawInRect:rect withAttributes:@{NSFontAttributeName: font,
                                            NSForegroundColorAttributeName: _empty_color}];
//    [@"☆☆☆☆☆" drawInRect:rect withFont:font];
    
    CGRect clip=rect;
    clip.size.width = clip.size.width * _show_star / _max_star;
    CGContextClipToRect(context,clip);
//    [_full_color set];
    [stars drawInRect:rect withAttributes:@{NSFontAttributeName: font,
                                            NSForegroundColorAttributeName: _full_color}];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_isSelect) {
        CGPoint pt = [[touches anyObject] locationInView:self];
        UIFont *font = [UIFont boldSystemFontOfSize: _font_size];
        CGSize starSize = [@"★★★★★" sizeWithAttributes:@{NSFontAttributeName: font}];
        if (pt.x > starSize.width + 5) {
            return;
        }
        _show_star = (NSInteger)(100.0f * pt.x / starSize.width);
        [self setNeedsDisplay];

    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_isSelect) {
        CGPoint pt = [[touches anyObject] locationInView:self];
        UIFont *font = [UIFont boldSystemFontOfSize: _font_size];
        CGSize starSize = [@"★★★★★" sizeWithAttributes:@{NSFontAttributeName: font}];
        if (pt.x > starSize.width + 5) {
            return;
        }
        _show_star = (NSInteger)(100.0f * pt.x / starSize.width);
        [self setNeedsDisplay];
        
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{

}

@end
