//
//  CustomAnnotationView.m
//  iOSMapExtension
//
//  Created by epacces on 7/10/13.
//  Copyright (c) 2013 it.hepakkes. All rights reserved.
//

#import "CustomAnnotationView.h"

@implementation CustomAnnotationView

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithNibName:@"CustomAnnotationView" annotation:annotation reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

@end
