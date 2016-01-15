//
//  PlayView.m
//  Wavelet
//
//  Created by dlios on 15-7-3.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "PlayView.h"
#import "UIButton+WebCache.h"
@implementation PlayView

+ (PlayView *)sharePlayView
{
    static PlayView *aView = nil;
    static dispatch_once_t takeOnce;
    dispatch_once(&takeOnce, ^{
        aView = [[PlayView alloc] init];
        
    });
    return aView;
}

- (void)addButtonWithCenter:(CGPoint)point
                        rad:(CGFloat)rad
{
    [PlayView sharePlayView].frame = CGRectMake(0, 0, 2 * rad, 2 *rad);
    [PlayView sharePlayView].center = point;
    [PlayView sharePlayView].layer.cornerRadius = rad;
    [PlayView sharePlayView].layer.masksToBounds = YES;
//    [PlayView sharePlayView].backgroundColor = [UIColor grayColor];
//    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"focusImage8.jpg"]];
    self.backgroundColor = [UIColor grayColor];
    NSLog(@"%ld", [PlayView sharePlayView].subviews.count);
    if ([PlayView sharePlayView].subviews.count == 0) {
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(8, 8, [PlayView sharePlayView].frame.size.width - 16, [PlayView sharePlayView].frame.size.height - 16);
        button.layer.cornerRadius = rad - 8;
        button.layer.masksToBounds = YES;
//        [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"play"]];
//        [button setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        [[PlayView sharePlayView] addSubview:button];
    }
    
}
- (void)setImageWithUrl:(NSString *)url
            playAlbumId:(NSString *)playId
{
    [button sd_setBackgroundImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal];
    self->playAlbumId = playId;
}

- (void)click
{
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
