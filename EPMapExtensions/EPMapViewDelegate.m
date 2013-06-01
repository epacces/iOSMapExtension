//
//  EPMapViewDelegate.m
//  iOSMapExtension
//
//  Created by epacces on 5/6/13.
//  Copyright (c) 2013 it.reply. All rights reserved.
//

#import "EPMapViewDelegate.h"
#import "EPMapViewDecorator.h"

@implementation EPMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    return [_mapViewDecorator mapView:mapView viewForAnnotation:annotation];
}

@end
