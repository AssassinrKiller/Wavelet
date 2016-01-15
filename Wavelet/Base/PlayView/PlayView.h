//
//  PlayView.h
//  Wavelet
//
//  Created by dlios on 15-7-3.
//  Copyright (c) 2015年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "BaseView.h"

@interface PlayView : BaseView
{
    @public
    UIButton *button;
    NSString *playAlbumId;
    BOOL isPlay;
}


+ (PlayView *)sharePlayView;
- (void)addButtonWithCenter:(CGPoint)point
                        rad:(CGFloat)rad;

- (void)setImageWithUrl:(NSString *)url
            playAlbumId:(NSString *)playId;
@end
