//
//  EPMapView.h
//  iOSMapExtension
//
//  Created by epacces on 5/6/13.
//  Copyright (c) 2013 it.reply. All rights reserved.
//

#import <MapKit/MapKit.h>

/**
 `EPMapView` inherits from `MKMapView` and adds some services to it such as, e.g., getting a centered region with respect to annotations.
 */

@interface EPMapView : MKMapView

///---------------------------------------------
/// @name Creating maps
///---------------------------------------------

/**
 Creates a map view
 @param mapView The map view to initialize
 */

- (id)initWithMapView:(MKMapView *)mapView;


///---------------------------------------------
/// @name Getting centered regions
///---------------------------------------------

/**
 Computes the centered region with respect to all annotations presented in the map
 */

- (MKCoordinateRegion)centeredRegion;

/**
 Computes the centered region with respect to all annotations presented in the map conforming to a given protocol
 @param protocol The protocol used to filter annotations
 */

- (MKCoordinateRegion)centeredRegionForAnnotationConformingToProtocol:(Protocol *)protocol;

/**
 Computes the centered region with respect to all annotations presented in the map conforming to an array of protocols
 @param protocols The array of protocols to filter annotations
 */

- (MKCoordinateRegion)centeredRegionForAnnotationConformingToProtocols:(NSArray *)protocols;

/**
 Computes the centered region with respect to all annotations belonging to a given kind of class
 @param cls The kind of class used to filter annotations
 */

- (MKCoordinateRegion)centeredRegionForAnnotationOfKindOfClass:(Class)cls;

/**
 Computes the centered region with respect to all annotations belonging to a given pool of classes
 @param classes Array of classes used to filter the annotations
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

@end
