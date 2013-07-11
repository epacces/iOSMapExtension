//
//  EPViewController.m
//  iOSMapExtension
//
//  Created by epacces on 5/6/13.
//  Copyright (c) 2013 it.reply. All rights reserved.
//

#import "EPViewController.h"
#import <MapKit/MapKit.h>
#import "EPMapExtensions.h"
#import "CustomAnnotationView.h"

@interface EPViewController () <MKMapViewDelegate>

@end

@implementation EPViewController {
    EPMapView *_mapView;
    EPMapViewDecorator *_mapDecorator;
    EPMapViewDelegate *_mapViewDelegate;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    _mapView = [[EPMapView alloc] initWithMapView:[[MKMapView alloc] initWithFrame:self.view.bounds]];
    [self.view addSubview:_mapView];
    _mapDecorator = [[EPMapViewDecorator alloc] init];

    [_mapDecorator setTranslationBlockForAllClasses:^NSString *(id<MKAnnotation> annotation) {
        if ([annotation isKindOfClass:[MKUserLocation class]]) {
            return nil;
        } else {
            return @"CustomAnnotationView";
        }
    }];
    
    [_mapDecorator setConfigBlockForAllClasses:^(MKAnnotationView *annotationView, id<MKAnnotation> annotation ) {
        [annotationView setCanShowCallout:YES];
    }];
    
    MKPlacemark *pl = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(45.1132827, 7.6782737)
                                            addressDictionary:nil];
    MKPlacemark *pl1 = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(45.0889828, 7.660230344)
                                            addressDictionary:nil];
    
    [_mapView addAnnotations:@[pl, pl1]];
    _mapViewDelegate = [[EPMapViewDelegate alloc] init];
    [_mapViewDelegate setMapViewDecorator:_mapDecorator];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_mapView setShowsUserLocation:YES];
    [_mapView setDelegate:_mapViewDelegate];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_mapView setShowsUserLocation:NO];
    [_mapView setDelegate:nil];
    [super viewWillDisappear:animated];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [_mapView setRegion:[_mapView centeredRegion] animated:YES];
    [mapView setVisibleMapRect:[_mapView visibleMapRect]
                   edgePadding:UIEdgeInsetsMake(.5f, .5f, .5f, .5f)
                      animated:YES];
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    NSLog(@"visible annotations: %d", [_mapView visibleAnnotations]);
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    return [_mapDecorator mapView:mapView viewForAnnotation:annotation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
