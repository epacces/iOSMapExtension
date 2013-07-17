//
//  EPViewController.h
//  iOSMapExtension
//
//  Created by epacces on 5/6/13.
//  Copyright (c) 2013 it.hepakkes. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EPMapViewDelegate;
@class MKMapView;
@class EPAnnotationArray;

@interface EPViewController : UIViewController

@property (nonatomic, strong) EPMapViewDelegate *mapViewDelegate;

@end
