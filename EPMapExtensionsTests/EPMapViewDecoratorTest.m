//
//  EPMapViewDecoratorTest.m
//  iOSMapExtension
//
//  Created by epacces on 5/6/13.
//  Copyright (c) 2013 it.reply. All rights reserved.
//

#import "EPMapViewDecoratorTest.h"
#import "EPMapViewDecorator.h"
#import <CoreLocation/CoreLocation.h>
#import "EPPointOfInterest.h"
#import "YAAnnotationView.h"


#define ARC4RANDOM_MAX      0x100000000

static inline double RAND_IN_RANGE(double min, double max) {
    return min + ((double) arc4random() / ARC4RANDOM_MAX) * (max - min) ;
}

static inline CLLocationCoordinate2D EPRandomLocationCoordinateMake(void) {
    return CLLocationCoordinate2DMake(RAND_IN_RANGE(-90, 90), RAND_IN_RANGE(-180, 180));
}

@interface AnnotationClass : EPPointOfInterest

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


@implementation EPMapViewDecoratorTest {
    EPMapViewDecorator *_mapDecorator;
    MKMapView          *_mapView;
    AnnotationClass    *_annotation;
    NSMutableArray            *_pois;
}

- (void)setUp
{
    _mapDecorator = [[EPMapViewDecorator alloc] init];
    _mapView = [[MKMapView alloc] init];
    
    _annotation = [AnnotationClass new];
    _pois = [[NSMutableArray alloc] initWithCapacity:5];
    for (int i = 0; i < 5; i++) {
        [_pois addObject:[[EPPointOfInterest alloc] initWithCoordinate:EPRandomLocationCoordinateMake()]];
    }
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
