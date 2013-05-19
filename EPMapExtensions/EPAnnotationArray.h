//
//  EPAnnotationArray.h
//  iOSMapExtension
//
//  Created by epacces on 5/6/13.
//  Copyright (c) 2013 it.reply. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface EPAnnotationArray : NSObject <NSFastEnumeration> {
    NSMutableArray        *_annotationArray;
}

- (void)addAnnotation:(id <MKAnnotation>)annotation;
- (void)addAnnotations:(NSArray *)annotations;

- (NSArray *)allAnnotations;

- (void)removeAnnotation:(id <MKAnnotation>)annotation;
- (void)removeAnnotations:(NSArray *)annotations;
- (void)removeAllAnnotations;

- (void)removeAnnotationsConformsToProtocol:(Protocol *)protocol;
- (void)removeAnnotationsConformsToProtocols:(NSArray *)protocols;

- (NSArray *)annotationsConformsToProtocol:(Protocol *)protocol;
- (NSArray *)annotationsConformsToProtocols:(NSArray *)protocols;

- (NSArray *)annotationsWithinRange:(CLLocationDistance)radius center:(CLLocationCoordinate2D)center;

- (NSUInteger)count;

@end