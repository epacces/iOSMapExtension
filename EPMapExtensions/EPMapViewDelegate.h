//
//  EPMapViewDelegate.h
//  iOSMapExtension
//
//  Created by epacces on 5/6/13.
//  Copyright (c) 2013 it.reply. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@protocol EPMapViewDecoratorProtocol;

@interface EPMapViewDelegate : NSObject <MKMapViewDelegate>

@property (nonatomic, weak)  id<EPMapViewDecoratorProtocol> mapViewDecorator;

@end
