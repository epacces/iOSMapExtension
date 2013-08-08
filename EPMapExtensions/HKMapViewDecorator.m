//
//  EPMapViewDecorator.m
//  iOSMapExtension
//
//  Created by epacces on 5/6/13.
//  Copyright (c) 2013 it.hepakkes. All rights reserved.
//


#import "HKMapViewDecorator.h"

@interface HKMapViewDecorator () <MKMapViewDelegate>

- (NSString *)HK_reuseIdentifierForAnnotation:(id<MKAnnotation>)annotation;
- (Class)HK_annotationViewClassFromAnnotation:(id<MKAnnotation>)annotation;
- (void)HK_configureAnnotationView:(MKAnnotationView *)annotationView;
- (BOOL)HK_isNoneRegistered;

typedef  NSString* (^TranslationBlockType)(id<MKAnnotation>);
typedef  void (^ConfigurationBlockType)(MKAnnotationView *, id<MKAnnotation>);

@end

@implementation HKMapViewDecorator

- (id)init
{
    if(self = [super init]) {
        _annotationViewForClass = [[NSMutableDictionary alloc] init];
        _configBlockForAnnotationView = [[NSMutableDictionary alloc] init];
        _translationBlockForClass = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)registerAnnotationViewForClass:(Class<MKAnnotation>)cls annotationView:(NSString *)annotation
{
    NSParameterAssert(annotation != nil && cls != Nil);
    if ([NSClassFromString(annotation) isSubclassOfClass:[MKAnnotationView class]])
        _annotationViewForClass[NSStringFromClass(cls)] = NSClassFromString(annotation);
    else
        [[NSException exceptionWithName:NSInvalidArgumentException
                                 reason:[NSString stringWithFormat:@"Annotation %@ should be any subclass of the MKAnnotationView", annotation]
                               userInfo:nil] raise];
}

- (void)registerAnnotationViewForClass:(Class<MKAnnotation>)cls annotationView:(NSString *)annotation
                           configBlock:(void (^)(MKAnnotationView *, id<MKAnnotation>))block
{
    [self registerAnnotationViewForClass:cls annotationView:annotation];
    if (block)
        [self setConfigBlockForClass:cls block:block];
}

- (void)setConfigBlockForClass:(Class<MKAnnotation>)cls block:(ConfigurationBlockType)block
{
    NSParameterAssert(cls != Nil && block != nil);
    _configBlockForAnnotationView[NSStringFromClass(cls)] = [block copy];
}


- (void)setDefaultAnnotationView:(MKAnnotationView *)annotationView
{
    _defaultAnnotationView = annotationView;
}

- (void)setTranslationBlockForAllClasses:(TranslationBlockType)translationBlock
{
    
    _translationBlockForAllClasses = [translationBlock copy];
}

- (void)setConfigBlockForAllClasses:(ConfigurationBlockType)block
{
    _configBlockForAllClasses = [block copy];
}

- (void)registerAnnotationViewForClass:(Class <MKAnnotation>)cls translationBlock:(TranslationBlockType)annotationToAnnotationView
{
    if (cls) {
        _translationBlockForClass[NSStringFromClass(cls)] = [annotationToAnnotationView copy];
    } else {
        _translationBlockForAllClasses = [annotationToAnnotationView copy];
    }
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
   
    if ([annotation class] == [MKUserLocation class]) return _userLocationAnnotationView;
    
    if ([self HK_isNoneRegistered])
        return _defaultAnnotationView;
    
    MKAnnotationView* annotationView;
    NSString *reuseIdentifier = [self HK_reuseIdentifierForAnnotation:annotation];
    
    if (!reuseIdentifier) return _defaultAnnotationView;
    
    if( !(annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier]) ) {
        Class c = [self HK_annotationViewClassFromAnnotation:annotation];
        annotationView = [[c alloc] initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    }
    annotationView.annotation = annotation;
    [self HK_configureAnnotationView:annotationView];
    
    return annotationView;
}


#pragma mark - Private Methods

- (NSString *)HK_reuseIdentifierForAnnotation:(id<MKAnnotation>)annotation
{
    if (_translationBlockForAllClasses && _translationBlockForAllClasses(annotation))
        return _translationBlockForAllClasses(annotation);
    
    NSString *annotationViewClass = NSStringFromClass([annotation class]);
    
    if (_translationBlockForClass[annotationViewClass] && ((TranslationBlockType) _translationBlockForClass[annotationViewClass]) (annotation) )
        return ((TranslationBlockType) _translationBlockForClass[annotationViewClass]) (annotation);
    else
        return  NSStringFromClass(_annotationViewForClass[annotationViewClass]);
}

- (Class)HK_annotationViewClassFromAnnotation:(id<MKAnnotation>)annotation
{
    Class annotationViewClass = NSClassFromString([self HK_reuseIdentifierForAnnotation:annotation]);
    
    if (! [annotationViewClass isSubclassOfClass:[MKAnnotationView class]] )
        [[NSException exceptionWithName:NSInvalidArgumentException
                                 reason:[NSString stringWithFormat:@"%@ should be any subclass of the MKAnnotationView", annotationViewClass]
                               userInfo:nil] raise];
    
    return annotationViewClass;
}

- (void)HK_configureAnnotationView:(MKAnnotationView *)annotationView
{
    if ( _configBlockForAnnotationView[ NSStringFromClass([annotationView.annotation class])] )
        ( (ConfigurationBlockType)_configBlockForAnnotationView[ NSStringFromClass([annotationView.annotation class]) ] )(annotationView, annotationView.annotation);
    if (_configBlockForAllClasses)
        _configBlockForAllClasses(annotationView, annotationView.annotation);
}

- (BOOL)HK_isNoneRegistered
{
    return (![_annotationViewForClass count] && ![_translationBlockForClass count] && !_translationBlockForAllClasses);
}

@end