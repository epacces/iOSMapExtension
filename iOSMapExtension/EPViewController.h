//
//  EPViewController.h
//  iOSMapExtension
//
//  Created by epacces on 5/6/13.
//  Copyright (c) 2013 it.reply. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EPMapViewDelegate;
@class MKMapView;
@class EPAnnotationArray;

@interface EPViewController : UIViewController

- (id)initWithMapView:(MKMapView *)mapView;
- (id)initWithAnnotations:(EPAnnotationArray *)annotation;

@property (nonatomic, strong) EPMapViewDelegate *mapViewDelegate;

@end
