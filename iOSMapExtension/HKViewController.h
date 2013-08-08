//
//  EPViewController.h
//  iOSMapExtension
//
//  Created by epacces on 5/6/13.
//  Copyright (c) 2013 it.hepakkes. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HKMapViewDelegate;
@class MKMapView;
@class EPAnnotationArray;

@interface HKViewController : UIViewController

@property (nonatomic, strong) HKMapViewDelegate *mapViewDelegate;

@end
