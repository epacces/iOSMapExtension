//
//  EPAnnotationView.m
//  iOSMapExtension
//
//  Created by epacces on 7/11/13.
//  Copyright (c) 2013 it.reply. All rights reserved.
//

#import "EPAnnotationView.h"

@implementation EPAnnotationView {
    UIView      *_loadedView;
}

- (id)initWithNibName:(NSString *)nibName annotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseId
{
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseId]) {
        _loadedView = [[UINib nibWithNibName:nibName?:NSStringFromClass([self class])
                                      bundle:nil] instantiateWithOwner:self options:nil][0];
        if (_loadedView) {
            CGRect frame = self.frame;
            frame.size.height = CGRectGetHeight(_loadedView.bounds);
            frame.size.width = CGRectGetWidth(_loadedView.bounds);
            self.frame = frame;
            [self addSubview:_loadedView];
        }
    }
    return self;
}


- (UIView *)nibLoadedView
{
    return _loadedView;
}

@end
