//
//  EPMapView.h
//  iOSMapExtension
//
//  Created by epacces on 5/6/13.
//  Copyright (c) 2013 it.hepakkes. All rights reserved.
//

#import <MapKit/MapKit.h>

/**
 `EPMapView` inherits from `MKMapView` and adds some services to it such as, e.g., getting a centered region with respect to annotations.
 */

@interface HKMapView : MKMapView

///---------------------------------------------
/// @name Creating maps
///---------------------------------------------

/**
 Creates a new map view which has the same frame size and all the annotations 
 
 @param mapView The map view to initialize the `EPMapView`
 */

- (id)initWithMapView:(MKMapView *)mapView;


///---------------------------------------------
/// @name Getting centered regions
///---------------------------------------------

/**
 Computes the centered region with respect to all annotations presented in the map
 
 @return The centered region 
 @warning If no one annotation is found in the map it returns the current visible map region

 */

- (MKCoordinateRegion)centeredRegion;

/**
 Computes the centered region with respect to all annotations presented in the map conforming to a given protocol
 @param protocol The protocol used to filter annotations
 
 @warning If no one annotation is found in the map it returns the current visible map region
 */

- (MKCoordinateRegion)centeredRegionForAnnotationConformingToProtocol:(Protocol *)protocol;

/**
 Computes the centered region with respect to all annotations presented in the map conforming to an array of protocols
 @param protocols The array of protocols to filter annotations
 
 @warning If no one annotation is found in the map it returns the current visible map region
 */

- (MKCoordinateRegion)centeredRegionForAnnotationConformingToProtocols:(NSArray *)protocols;

/**
 Computes the centered region with respect to all annotations belonging to a given kind of class
 @param cls The kind of class used to filter annotations
 
 @warning If no one annotation is found in the map it returns the current visible map region
 */

- (MKCoordinateRegion)centeredRegionForAnnotationOfKindOfClass:(Class)cls;

/**
 Computes the centered region with respect to all annotations belonging to a given pool of classes
 @param classes Array of classes used to filter the annotations
 
 @warning If no one annotation is found in the EPMapView it returns the **current visible** map region
 */

- (MKCoordinateRegion)centeredRegionForAnnotationOfKindOfClasses:(NSArray *)classes;

///---------------------------------------------
/// @name Getting visible annotations
///---------------------------------------------

/**
 Computes the number of visible annotations displayed over the visible region of the map
 */

- (NSUInteger)visibleAnnotations;

/**
 Computes the number of visible annotations displayed over the visible region of the map conforming to a given protocol
 @param protocol The protocol used to filter annotations
 */

- (NSUInteger)visibleAnnotationsConformingToProtocol:(Protocol *)protocol;

/**
 Computes the number of visible annotations displayed over the visible region of the map conforming to a set of protocols
 @param protocols The array of protocols to filter annotations
 */

- (NSUInteger)visibleAnnotationsConformingToProtocols:(NSArray *)protocols;

/**
 Computes the number of visible annotations displayed over the visible region of the map conforming to a given type of class
 @param cls The class used to filter annotations
 */

- (NSUInteger)visibleAnnotationsOfKindOfClass:(Class)cls;

/**
 Computes the number of visible annotations displayed over the visible region of the map conforming to a given pool of classes
 @param classes The array of classes to filter annotations
 */

- (NSUInteger)visibleAnnotationsOfKindOfClasses:(NSArray *)classes;


///---------------------------------------------
/// @name Resetting annotation
///---------------------------------------------

/**
 Removes all the annotations added into the map
 */

- (void)removeAllAnnotations;

///---------------------------------------------
/// @name Remove/Filter annotation
///---------------------------------------------


/**
 Removes all the annotations conforming to a given protocol from the map
 */

- (void)removeAnnotationsConformingToProtocol:(Protocol *)protocol;

/**
 Removes all the annotations conforming to one of the given array of protocols from the map
 */

- (void)removeAnnotationsConformingToProtocols:(NSArray *)protocols;

/**
 Removes all the annotations of a given kind of class from the map
 */

- (void)removeAnnotationsOfKindOfClass:(Class<MKAnnotation>)cls;

/**
 Removes all the annotations belonging to one of a given array of classes from the map
 */

- (void)removeAnnotationsOfKindOfClasses:(NSArray *)array;


@end
