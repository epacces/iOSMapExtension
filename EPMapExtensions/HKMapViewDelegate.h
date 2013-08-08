//
//  EPMapViewDelegate.h
//  iOSMapExtension
//
//  Created by epacces on 5/6/13.
//  Copyright (c) 2013 it.hepakkes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@protocol HKMapViewDecoratorProtocol;

@class HKUserPosition;

@interface HKMapViewDelegate : NSObject <MKMapViewDelegate> {
    id<HKMapViewDecoratorProtocol>  _mapViewDecorator;
}

@property (nonatomic, strong)  id<HKMapViewDecoratorProtocol> mapViewDecorator;

- (void)registerNavigationBlock:(void(^)(UIView *sender))block annotationView:(MKAnnotationView *)annotationView;

@property (nonatomic, copy)  void(^positionUpdated)(HKUserPosition *userPosition);

@end
