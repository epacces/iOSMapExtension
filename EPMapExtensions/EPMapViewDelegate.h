//
//  EPMapViewDelegate.h
//  iOSMapExtension
//
//  Created by epacces on 5/6/13.
//  Copyright (c) 2013 it.hepakkes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@protocol EPMapViewDecoratorProtocol;

@class EPUserPosition;

@interface EPMapViewDelegate : NSObject <MKMapViewDelegate> {
    id<EPMapViewDecoratorProtocol>  _mapViewDecorator;
}

@property (nonatomic, strong)  id<EPMapViewDecoratorProtocol> mapViewDecorator;

- (void)registerNavigationBlock:(void(^)(UIView *sender))block annotationView:(MKAnnotationView *)annotationView;

@property (nonatomic, copy)  void(^positionUpdated)(EPUserPosition *userPosition);

@end
