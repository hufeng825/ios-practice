//
//  GACapabilityCheck.h
//  GeneralApp
//
//  Created by Denny C. Dai on 7/23/2013.
//  Copyright (c) 2013 Denny C. Dai. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
  Utility object for checking sevice/functionality availability
 **/
@interface GACapabilityCheck : NSObject
+(BOOL)hasMultiTasking; //check if the host supports multitasking and background execution
+(BOOL)isRunningiPad;
+(BOOL)isClassExist:(NSString*)cls; //check if a given class string is present in the system
+(BOOL)isInstanceMethodExist:(SEL)sel ForClass:(Class)cls;//check if an instance method exist on a class
+(NSUInteger)deviceSystemMajorVersion; //check for system version
+(NSString*)deviceSystemVersion;
@end


#define DEVICE_RUN_IOS_SEVEN ([GACapabilityCheck deviceSystemMajorVersion] == 7)
