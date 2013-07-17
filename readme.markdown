EPMapExtension is an extension library built on the top of [MKMapKit](http://developer.apple.com/library/ios/#documentation/MapKit/Reference/MapKit_Framework_Reference/_index.html) framework.

## How To Get Started

- [Download EPMapExtension]() and try out the included iPhone example app

## Overview

The library architecture is based on the 

## MapViewDecorator
	
MapViewDecorator is an attempt to deal with a considerable amount of customized annotationView spanning over the map without incurring in typical problems relevant to the trivial **switch-case, if-else if**  control structures. In other words, it is a way to treat a good number of annotations and views in a more manageable and maintainable way.

### Registration of Annotations into MapDecorator

#### Example 1
    EPMapViewDecorator *decorator = [[EPMapViewDecorator alloc] init];
    [decorator registerAnnotationViewForClass:[AnnotationClass class] annotationView:@"MKPinAnnotationView"];

### Advanced Configurations

## Customized MapView 
	
This customized MapView adds some useful features on top of the MKMapView class. 

In fact, it enables 

- to get centered region relative to a set to annotations conforming to a protocol or a set of protocols, belonging to a certain class or set of classes

- to get the number of visible annotation conforming to a protocol or a set of protocols or belonging to a certain class or set of classes, within the current visible Map Region.


## User Position

## Annotation Array

  
