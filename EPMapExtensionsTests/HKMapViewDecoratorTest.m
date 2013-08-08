//
//  EPMapViewDecoratorTest.m
//  iOSMapExtension
//
//  Created by epacces on 5/6/13.
//  Copyright (c) 2013 it.hepakkes. All rights reserved.
//

#import "HKMapViewDecoratorTest.h"
#import "HKMapViewDecorator.h"
#import <CoreLocation/CoreLocation.h>
#import "HKPointOfInterest.h"
#import "YAAnnotationView.h"
#import "utils.h"
#import "HKMapView.h"

@interface AnnotationClass : HKPointOfInterest

@property (copy, nonatomic) NSString *name;
@property (nonatomic, readonly, copy) NSString *title;

@end

@implementation AnnotationClass

- (CLLocationCoordinate2D)coordinate
{
    return EPRandomLocationCoordinateMake();
}

- (NSString *)title
{
    return @"Jesus";
}

@end


@implementation HKMapViewDecoratorTest {
    HKMapViewDecorator *_mapDecorator;
    HKMapView          *_mapView;
    AnnotationClass    *_annotation;
    NSMutableArray            *_pois;
}

- (void)setUp
{
    _mapDecorator = [[HKMapViewDecorator alloc] init];
    _mapView = [[HKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    
    _annotation = [AnnotationClass new];
    _pois = [[NSMutableArray alloc] initWithCapacity:10];
    for (int i = 0; i < 10; i++) {
        HKPointOfInterest *poi = [[HKPointOfInterest alloc] initWithCoordinate:EPRandomLocationCoordinateMake()];
        [_pois addObject:poi];
    }
    [_mapView addAnnotations:_pois];
}


- (void)testMapViewDecoratorRegisterNonExistentAnnotationForClass
{
    [_mapView addAnnotation:_annotation];
    STAssertThrows([_mapDecorator registerAnnotationViewForClass:[AnnotationClass class] annotationView:@"MKPinPoint"],
                   @"should throw exception");
}

- (void)testMapViewDecoratorRegisterAnnotationForClass
{
    [_mapView addAnnotation:_annotation];
    [_mapDecorator registerAnnotationViewForClass:[AnnotationClass class] annotationView:@"MKPinAnnotationView"];
    STAssertEquals([[_mapDecorator mapView:_mapView viewForAnnotation:_annotation] class], [MKPinAnnotationView class],
                   @"Annotation class should be pinpoint");
}

- (void)testMapViewDecoratorRegisterAnnotationForClassWithConfigurationBlock
{
    [_mapDecorator registerAnnotationViewForClass:[AnnotationClass class] annotationView:@"MKPinAnnotationView"
                                      configBlock:^(MKAnnotationView *av, id<MKAnnotation> annotation){
                                          [av setCanShowCallout:YES];
                                      }];
    MKPinAnnotationView *pinAV = (MKPinAnnotationView *)[_mapDecorator mapView:_mapView viewForAnnotation:_annotation];
    STAssertTrue([pinAV canShowCallout], @"annotation should show callout");
}

- (void)testRegisterAnnotationViewForClassWithTraslationBlock
{
    [_mapView addAnnotation:_annotation];
    [_mapDecorator registerAnnotationViewForClass:[AnnotationClass class]
                                 translationBlock:^NSString * (id<MKAnnotation> annotation) {
                                     if (![[(AnnotationClass *)annotation name] isEqualToString:@"Jesus"])
                                         return @"YAAnnotationView";
                                     else
                                         return @"YAJesusAnnotationView";
                                 }];
    STAssertEquals([[_mapDecorator mapView:_mapView viewForAnnotation:_annotation] class], [YAAnnotationView class],
                   @"Annotation class should be YAAnotationView");
    
    [_annotation setName:@"Jesus"];
    STAssertEquals([[_mapDecorator mapView:_mapView viewForAnnotation:_annotation] class], [YAJesusAnnotationView class],
                   @"Annotation class should be YAJesusAnnotationView");
    
}

- (void)testRegisterAnnotationViewForClassWithBadTraslationBlock
{
    [_mapView addAnnotation:_annotation];
    [_mapDecorator registerAnnotationViewForClass:[AnnotationClass class]
                                 translationBlock:^NSString * (id<MKAnnotation> annotation) {
                                     if (![[(AnnotationClass *)annotation name] isEqualToString:@"Jesus"])
                                         return @"YAAnnotationView";
                                     else
                                         return @"YZ";
                                 }];
    STAssertEquals([[_mapDecorator mapView:_mapView viewForAnnotation:_annotation] class], [YAAnnotationView class],
                   @"Annotation class should be YAAnotationView");
    
    [_annotation setName:@"Jesus"];
    STAssertThrows([_mapDecorator mapView:_mapView viewForAnnotation:_annotation], @"should raise exception");

}

- (void)testRegisterAnnotationViewForClassWithTranslationBlockWithInheritance
{
    [_mapView addAnnotation:_annotation];
    [_mapDecorator setDefaultAnnotationView:[[MKPinAnnotationView alloc] init]];
    [_mapDecorator registerAnnotationViewForClass:[AnnotationClass class]
                                 translationBlock:^NSString * (id<MKAnnotation> annotation) {
                                     if (![[(AnnotationClass *)annotation name] isEqualToString:@"Jesus"])
                                         return @"YAAnnotationView";
                                     else
                                         return nil;
                                         }];
    STAssertEquals([[_mapDecorator mapView:_mapView viewForAnnotation:_annotation] class], [YAAnnotationView class],
                   @"Annotation class should be YAAnotationView");
    
    [_annotation setName:@"Jesus"];
    STAssertEquals([[_mapDecorator mapView:_mapView viewForAnnotation:_annotation] class], [MKPinAnnotationView class],
                   @"Annotation class should be MKPinAnnotationView");
}


- (void)testSetConfigurationBlock
{
    [_mapDecorator registerAnnotationViewForClass:[AnnotationClass class]
                                 translationBlock:^NSString * (id<MKAnnotation> annotation) {
                                     if (![[(AnnotationClass *)annotation name] isEqualToString:@"Jesus"])
                                         return @"YAAnnotationView";
                                     else
                                         return @"YAJesusAnnotationView";
                                 }];
    
    [_mapDecorator setConfigBlockForClass:[AnnotationClass class]
                                    block:^(MKAnnotationView *av, id<MKAnnotation> annotation){
                                        if([av class] == [YAAnnotationView class]) {
                                            [av setCanShowCallout:YES];
                                        } else {
                                            [av setCanShowCallout:NO];
                                        }
                                    }];
    
    STAssertEquals([[_mapDecorator mapView:_mapView viewForAnnotation:_annotation] class], [YAAnnotationView class],
                   @"Annotation class should be YAAnotationView");
    YAAnnotationView *av = (YAAnnotationView *)[_mapDecorator mapView:_mapView viewForAnnotation:_annotation];
    STAssertTrue([av canShowCallout], @"annotation view should show callout");
    
    [_annotation setName:@"Jesus"];
    STAssertEquals([[_mapDecorator mapView:_mapView viewForAnnotation:_annotation] class], [YAJesusAnnotationView class],
                   @"Annotation class should be YAAnotationView");
    YAJesusAnnotationView *jav = (YAJesusAnnotationView *)[_mapDecorator mapView:_mapView viewForAnnotation:_annotation];
    STAssertFalse([jav canShowCallout], @"annotation view should not show callout");

    STAssertEquals((NSObject *)[_mapDecorator mapView:_mapView viewForAnnotation:_pois[2]], (NSObject *)nil, @"Annotation class should be nil");

}


- (void)testMapViewDecoratorConfigBlockForAllClasses
{
    [_mapDecorator setTranslationBlockForAllClasses:^NSString * (id<MKAnnotation> annotation) {
        if (![annotation respondsToSelector:@selector(title)])
            return @"YAAnnotationView";
        else
            return @"YAJesusAnnotationView";
    }];
    
    [_mapDecorator setConfigBlockForAllClasses: ^(MKAnnotationView *annotationView, id<MKAnnotation> annotation) {
        if([annotationView class] == [YAAnnotationView class]) {
            [annotationView setCanShowCallout:YES];
        } else {
            [annotationView setCanShowCallout:NO];
        }
    }];
    
    STAssertEquals([[_mapDecorator mapView:_mapView viewForAnnotation:_pois[2]] class], [YAAnnotationView class],
                   @"Annotation class should be YAAnotationView");
    YAAnnotationView *av = (YAAnnotationView *)[_mapDecorator mapView:_mapView viewForAnnotation:_pois[2]];
    STAssertTrue([av canShowCallout], @"annotation view should show callout");
    
    STAssertEquals([[_mapDecorator mapView:_mapView viewForAnnotation:_annotation] class], [YAJesusAnnotationView class],
                   @"Annotation class should be YAAnotationView");
    YAJesusAnnotationView *jav = (YAJesusAnnotationView *)[_mapDecorator mapView:_mapView viewForAnnotation:_annotation];
    STAssertFalse([jav canShowCallout], @"annotation view should not show callout");
}


@end
