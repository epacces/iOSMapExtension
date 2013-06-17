//
//  EPTestAnnotation.h
//  iOSMapExtension
//
//  Created by Eriprando Pacces on 6/17/13.
//  Copyright (c) 2013 it.reply. All rights reserved.
//

#import <MapKit/MapKit.h>

@protocol EPAnnotation

@property (nonatomic, copy)  NSString *telephoneNumber;

@end

@interface EPTestAnnotation : MKPlacemark <EPAnnotation>

@property (nonatomic, copy)  NSString *telephoneNumber;

@end
