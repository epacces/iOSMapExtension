//
//  EPMapViewDecorator.h
//  iOSMapExtension
//
//  Created by epacces on 5/6/13.
//  Copyright (c) 2013 it.hepakkes. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


/**
 `EPMapViewDecoratorProtocol` encompasses a subset of `MKMapViewDelegate` MKMapKit protocol.
 */

@protocol HKMapViewDecoratorProtocol <NSObject>
  @required
/**
 @param mapView The map view on which annotations are displayed
 @param annotation The annotation to be displayed
 @result annotation view corresponding to the current annotation
 */
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation;
@end


/**
 `EPMapViewDecorator` deals with the graphical representation of the map annotations. Basically it's designed to map annotation points over `MKMapView` to a set of customized annotation views.
 */

@interface HKMapViewDecorator : NSObject <HKMapViewDecoratorProtocol> {
  @private
    NSMutableDictionary     *_annotationViewForClass;
    NSMutableDictionary     *_configBlockForAnnotationView;
    NSMutableDictionary     *_translationBlockForClass;
    NSString *              (^_translationBlockForAllClasses) (id<MKAnnotation>);
    void                    (^_configBlockForAllClasses) (MKAnnotationView *, id<MKAnnotation>);
    MKAnnotationView        *_defaultAnnotationView;
}

///---------------------------------------
/// @name Accessing the Default and User Annotation Views
///---------------------------------------

/**
 The user location annotation view.
 
 @warning The default value is `nil`
 */

@property (nonatomic, strong)     MKAnnotationView      *userLocationAnnotationView;


/**
 The default annotation view which is drown when no one annotation is registered.
 
 @warning The default value is `nil`
 */

@property (nonatomic, strong)     MKAnnotationView      *defaultAnnotationView;


///---------------------------------------------
/// @name Registering Annotation Views 
///---------------------------------------------

/**
 Registers annotation view associated to any annotation point class responding to `MKAnnotation` protocol.
 
    EPMapViewDecorator *decorator = [[EPMapViewDecorator alloc] init];
    [decorator registerAnnotationViewForClass:[AnnotationClass class] annotationView:@"MKPinAnnotationView"];
 
 @param cls Any class responding to `MKAnnotation` protocol.
 @param annotation An `MKAnnotationView` or any subclass name to be associated to the annotation class
 @param configBlock A config block to customize, e.g, annotation view appearance
 
 @exception NSInvalidArgumentException It is thrown when the annotation param is not matching any `MKAnnotationView` class or its subclass
 */

- (void)registerAnnotationViewForClass:(Class<MKAnnotation>)cls annotationView:(NSString *)annotation
                           configBlock:(void (^)(MKAnnotationView *, id<MKAnnotation>))configBlock;

/**
 Registers annotation view associated to any annotation point class responding to `MKAnnotation` protocol.
 
 @param cls Any class responding to `MKAnnotation` protocol.
 @param annotation An `MKAnnotationView` or any subclass name to be associated to the annotation class
 
 @exception NSInvalidArgumentException It is thrown the annotation param is not matching any `MKAnnotationView` class or its subclass
 */

- (void)registerAnnotationViewForClass:(Class<MKAnnotation>)cls annotationView:(NSString *)annotation;

/**
 Registers annotation view associated to any annotation point class responding to `MKAnnotation` protocol.
 
 @param cls Any class responding to `MKAnnotation` protocol.
 @param annotationToAnnotationView A block that given an annotation returns the name of annotationView class associated with it.
 
 @exception NSInvalidArgumentException It is thrown when the annotation param is not matching any `MKAnnotationView` class or its subclass
 */

- (void)registerAnnotationViewForClass:(Class<MKAnnotation>)cls translationBlock:(NSString * (^)(id<MKAnnotation>))annotationToAnnotationView;

///---------------------------------------------
/// @name Setting Configuration Blocks
///---------------------------------------------


/**
 Sets the mapping between the annotation and the correspondent annotation view.
 
 @param translationBlock A block that given an annotation returns the name of annotationView class associated with it.
 
 */

- (void)setTranslationBlockForAllClasses:(NSString * (^) (id<MKAnnotation>))translationBlock;

/**
 Sets the block to be summoned to configure the annotation Views associated to the annotation class.
 
 @param cls Any class responding to `MKAnnotation` protocol
 @param configBlock A config block to customize, e.g, annotation view appearance
 
 */

- (void)setConfigBlockForClass:(Class<MKAnnotation>)cls block:(void (^)(MKAnnotationView *, id<MKAnnotation>))configBlock;

/**
 Sets the block to be summoned to configure the annotation Views associated to the annotation class.
 
 @param configBlock A config block to customize, e.g, annotation view appearance
 
 */

- (void)setConfigBlockForAllClasses:(void (^)(MKAnnotationView *, id<MKAnnotation>))configBlock;

///---------------------------------------------
/// @name EPMapViewDecoratorProtocol methods
///---------------------------------------------

/**
    @param mapView The map view on which annotations are displayed
    @param annotation The annotation to be displayed
    @return annotation view corresponding to the current annotation 
 */

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation;

@end


