//
//  EPAnnotationView.h
//  iOSMapExtension
//
//  Created by epacces on 7/11/13.
//  Copyright (c) 2013 it.hepakkes. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface EPAnnotationView : MKAnnotationView

@property (nonatomic, readonly) UIView *nibLoadedView;

- (id)initWithNibName:(NSString *)nibName annotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseId;

@end
