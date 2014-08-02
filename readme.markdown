EPMapExtension is an extension library built on the top of [MKMapKit](http://developer.apple.com/library/ios/#documentation/MapKit/Reference/MapKit_Framework_Reference/_index.html) framework.

## How To Get Started

- [Download EPMapExtension]() and try out the included iPhone example app

## Overview

The library architecture is built on the the top of `MKMapKit Framework`. 

## MapViewDecorator
	
MapViewDecorator is an attempt to deal with a considerable amount of customized `MKAnnotationView`s, spanning over the map without incurring in typical problems relevant to the trivial **switch-case, if-else if**  control structures. In other words, it is a way to treat a good number of annotations and views in a more manageable and maintainable way.

### Registration of Annotations into MapDecorator

In the following way is possible to register the annotationView associated to the annotation

    EPMapViewDecorator *decorator = [[EPMapViewDecorator alloc] init];
    [decorator registerAnnotationViewForClass:[AnnotationClass class] annotationView:@"MKPinAnnotationView"];

### Configuration and Registration of Annotations through the MapDecorator

    EPMapViewDecorator *decorator = [[EPMapViewDecorator alloc] init];
    [_mapDecorator registerAnnotationViewForClass:[AnnotationClass class] annotationView:@"MKPinAnnotationView"
                                      configBlock:^(MKAnnotationView *av, id<MKAnnotation> annotation){
                                          [av setCanShowCallout:YES];
                                      }];


### Registration & Configuration of Multiple AnnotationViews Relevant to an AnnotationClass


    [_mapDecorator registerAnnotationViewForClass:[AnnotationClass class]
                                 translationBlock:^NSString * (id<MKAnnotation> annotation) {
                                     if (![[(AnnotationClass *)annotation name] isEqualToString:@"I'm old"])
                                         return @"YAAnnotationView";
                                     else
                                         return @"YAAAnnotationView";
                                 }];
    [_mapDecorator setConfigBlockForClass:[AnnotationClass class]
                                    block:^(MKAnnotationView *av, id<MKAnnotation> annotation){
                                        if([av class] == [YAAnnotationView class]) {
                                            [av setCanShowCallout:YES];
                                        } else {
                                            [av setCanShowCallout:NO];
                                        }
                                    }];

### Registration & Configuration of AnnotationViews for All Annotation Classes

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


## Customized MapView 
	
This customized MapView adds some useful features on top of the MKMapView class. 

In fact, it enables 

- to get centered regions relative to a set to annotations conforming to a protocol or a set of protocols, belonging to a certain class or set of classes

- to get the number of visible annotation conforming to a protocol or a set of protocols or belonging to a certain class or set of classes, within the current visible Map Region.


## User Position

This class is a helper class to update the user position only within a certain range (it's the minThresholdToUpdatePosition property). It also checks if a valid position has been given.

## Annotation Array

This is an annotation array data structure built on top of the `NSArray` class. It adds some useful features to get, remove, add annotations responding to a particular protocol or class. 

