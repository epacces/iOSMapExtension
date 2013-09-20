//
//  EPAnnotationArray.h
//  iOSMapExtension
//
//  Created by epacces on 5/6/13.
//  Copyright (c) 2013 it.hepakkes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

/**
 Annotation Collection class which wraps up a mutable a `NSMutableArray` and contains `MKAnnotation` protocol conform objects
 */

@interface HKAnnotationArray : NSObject <NSFastEnumeration> {
    NSMutableArray        *_annotationArray;
}

///-------------------------------------------------
/// @name  Init collection
///-------------------------------------------------

/** 
 @param annotations Annotation array which contains objects conforming to `MKAnnotation` protocol
 @exception raises exception when any element of the annotation collection is not responding to `MKAnnotation` protocol
 */

- (id)initWithAnnotationArray:(NSArray *)annotations;

///-------------------------------------------------
/// @name  Getting annotation properties
///-------------------------------------------------

/**
 It returns all the annotations in the collection
 */

- (NSArray *)allAnnotations;

/**
 It returns the number of annotations in the collection
 */

- (NSUInteger)count;

///-------------------------------------------------
/// @name  Getting filtered annotation set
///-------------------------------------------------

/**
 @param protocol It's the protocol whose retrieved annotations must adhere to 

 @note all the annotations are conforming to `MKAnnotation` protocol by definition
 */

- (NSArray *)annotationsConformsToProtocol:(Protocol *)protocol;

/**
 @param protocols Array of protocols retrieved annotations must adhere to 
 
 @note all the annotations are conforming to `MKAnnotation` protocol by definition
 */

- (NSArray *)annotationsConformsToProtocols:(NSArray *)protocols;

/**
  @param cls It's the `Class` whose retrieved annotation must subclass 
 */

- (NSArray *)annotationsOfKindOfClass:(Class<MKAnnotation>)cls;

/**
 @param classes Array of `Class`es whose retrieved annotation must subclass
 */

- (NSArray *)annotationsOfKindOfClasses:(NSArray *)classes;

/**
 It returns an array containing annotations within a given region
 
 @param radius The radius of the circular region
 @param center The center of the circular region
 */

- (NSArray *)annotationsWithinRange:(CLLocationDistance)radius center:(CLLocationCoordinate2D)center;

@end

@interface HKAnnotationArray (HKAnnotationMutableArray)

///-------------------------------------------------
/// @name  Mutating collection
///-------------------------------------------------

/**
 Adds annotation to the container
 
 @param annotation An object conforming to the `MKAnnotation` protocol
 @exception raises an exception if annotation is not conforming to `MKAnnotation` protocol
 */

- (void)addAnnotation:(id <MKAnnotation>)annotation;

/**
 Adds annotations to the container
 
 @param annotations An array of objects conforming to the `MKAnnotation` protocol
 @exception raises an exception if annotation is not conforming to `MKAnnotation` protocol
 */

- (void)addAnnotations:(NSArray *)annotations;

/**
 Removes annotations of kind of class from the container
 
 @param cls The class annotations to be removed must extend
 */

- (void)removeAnnotationsOfKindOfClass:(Class <MKAnnotation>)cls;

/**
 Removes annotations of kind of classes from the container
 
 @param classes The array of classes annotations to be removed must extend
 */

- (void)removeAnnotationsOfKindOfClasses:(NSArray *)classes;

/**
 Removes annotations conforming to a given protocol from the container
 
 @param protocol The protocol annotations to be removed must adhere 
 */

- (void)removeAnnotationsConformsToProtocol:(Protocol *)protocol;

/**
 Removes all the annotations conforming to a given set of protocols
 
 @param protocols Array of protocols annotations to be removed must adhere
 */
- (void)removeAnnotationsConformsToProtocols:(NSArray *)protocols;

/**
 Removes a given annotation from the container
 
 @param annotation The annotation to be removed from the collection
 */

- (void)removeAnnotation:(id <MKAnnotation>)annotation;

/**
 Removes given annotations from the collection
 
 @param annotations The array of annotations to be removed
 */

- (void)removeAnnotations:(NSArray *)annotations;

/**
 Removes all the annotations from the container
 */

- (void)removeAllAnnotations;

@end