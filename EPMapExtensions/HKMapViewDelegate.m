//
//  EPMapViewDelegate.m
//  iOSMapExtension
//
//  Created by epacces on 5/6/13.
//  Copyright (c) 2013 it.hepakkes. All rights reserved.
//

#import "HKMapViewDelegate.h"
#import "HKMapViewDecorator.h"

@implementation HKMapViewDelegate {
    NSMutableDictionary *_navigationBlocks;
}

- (id)init
{
    if (self = [super init]) {
        _navigationBlocks = [[NSMutableDictionary alloc] initWithCapacity:1];
    }
    return self;
}

- (void)registerNavigationBlock:(void (^)(UIView *))block annotationView:(MKAnnotationView *)annotationView
{
    [_navigationBlocks setObject:block forKey:NSStringFromClass([annotationView class])];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    return [_mapViewDecorator mapView:mapView viewForAnnotation:annotation];
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    if (_navigationBlocks[NSStringFromClass([view class])]) {
        ((void(^)(UIView *sender)) _navigationBlocks[NSStringFromClass([view class])])(control);
    }
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    if (_navigationBlocks[NSStringFromClass([view class])]) {
        ((void(^)(UIView *sender)) _navigationBlocks[NSStringFromClass([view class])])(view);
    }
}

@end
