//
//  testIOSTests.m
//  testIOSTests
//
//  Created by Denny C. Dai on 8/14/2013.
//  Copyright (c) 2013 Denny C. Dai. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "dpRCRecptionist.h"
#import "dpObject.h"
#import "dpMyObject.h"
#import "MonthArray.h"
#import "ValidatingArray.h"


@interface testIOSTests : XCTestCase

@end

@implementation testIOSTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


//REF https://developer.apple.com/library/ios/documentation/General/Conceptual/CocoaEncyclopedia/Target-Action/Target-Action.html
/**
 Cocoa uses the target-action mechanism for communication between a control and another object. This mechanism allows the control and, in OS X its cell or cells, to encapsulate the information necessary to send an application-specific instruction to the appropriate object. The receiving object—typically an instance of a custom class—is called the target. The action is the message that the control sends to the target. The object that is interested in the user event—the target—is the one that imparts significance to it, and this significance is usually reflected in the name it gives to the action.
 
 **/
-(void)testTargetAction
{
    //Control objects do not (and should not) retain their targets.
    
    //An action is the message a control sends to the target or, from the perspective of the target,
    //the method the target implements to respond to the action message.
    // A control stores an action as an instance variable of type SEL.
    
    //An action message must have a simple, distinct signature. The method it invokes returns nothing and usually has a sole parameter of type id. This parameter, by convention, is named sender.
    
    //- (IBAction)capitalizeWord:(id)sender;
    
    //Many of the control classes in UIKit are implemented to generate certain control events; for example, instances of the UISlider class generate a UIControlEventValueChanged control event, which you can use to send an action message to a target object.
    
    
}

//TODO - check KVO and return back here 
-(void)testReceptionist
{
    RCTaskBlock task = ^(NSString *keyPath, id object, NSDictionary *change) {
        NSLog(@"property %@ changed %@", keyPath, change);
//        NSView *viewForModel = [modelToViewMap objectForKey:model];
//        NSColor *newColor = [change objectForKey:NSKeyValueChangeNewKey];
//        [[[viewForModel subviews] objectAtIndex:0] setFillColor:newColor];
        
    };
    
    
    TestObject* obj = [TestObject new];
    
    [dpRCRecptionist receptionistForKeyPath:@"value"
                                                                     object:obj
                                                                      queue:[NSOperationQueue mainQueue]
                                                                       task:task];

    //make some changes to obj
    obj.value = @"dennycd";
}

/**
  REF https://developer.apple.com/library/ios/documentation/General/Conceptual/CocoaEncyclopedia/ObjectMutability/ObjectMutability.html
 
 Performance is also a reason for immutable versions of objects representing things such as strings and dictionaries. Mutable objects for basic entities such as strings and dictionaries bring some overhead with them. Because they must dynamically manage a changeable backing store—allocating and deallocating chunks of memory as needed—mutable objects can be less efficient than their immutable counterparts.
 **/
-(void)testObjectMutability
{
    //defensive programming practices
    
    //Use a mutable variant of an object when you need to modify its contents frequently and incrementally after it has been created
    //Sometimes it’s preferable to replace one immutable object with another; for example,  NSString
    //Rely on the return type for indications of mutability.
    //
    
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused"
    NSMutableDictionary *mutDict = [[NSMutableDictionary alloc] init];
    NSMutableArray *mutArray = [NSMutableArray arrayWithCapacity:10];
    NSMutableSet *mutSet = [NSMutableSet set];
    NSMutableSet *mutSetCopy = [mutSet mutableCopy];
    NSSet* set = [mutSet copy];  //immutable copy
#pragma GCC diagnostic pop
    
    //So don’t make an assumption about object mutability based on what introspection tells you about an object. Treat objects as mutable or not based on what you are handed at the API boundaries (that is, based on the return type).
    
    
    //Mutable Objects in Collections
//    Storing mutable objects in collection objects can cause problems. Certain collections can become invalid or even corrupt if objects they contain mutate because, by mutating, these objects can affect the way they are placed in the collection. First, the properties of objects that are keys in hashing collections such as NSDictionary objects or NSSet objects will, if changed, corrupt the collection if the changed properties affect the results of the object’s hash or isEqual: methods.
}

//REF https://developer.apple.com/library/ios/documentation/General/Conceptual/CocoaEncyclopedia/ObjectAllocation/ObjectAllocation.html#//apple_ref/doc/uid/TP40010810-CH7-SW1
//REF https://developer.apple.com/library/ios/documentation/General/Conceptual/CocoaEncyclopedia/Initialization/Initialization.html
-(void)testObjectAllocInit
{
    //A zone is a page-aligned area of memory for holding related objects and data allocated by an application

    //a bad practice as init may return a different object than alloc
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused"
    id obj = [dpObject alloc];
    [obj init];
    //[obj someotherFunc]
#pragma GCC diagnostic pop
     
}

//REF https://developer.apple.com/library/ios/documentation/General/Conceptual/CocoaEncyclopedia/Introspection/Introspection.html#//apple_ref/doc/uid/TP40010810-CH9-SW1
//Introspection refers to the capability of objects to divulge details about themselves as objects at runtime.
// - places in the inheritance chain
// - responde to certain message
// - conforms to specific protocol
-(void)testIntrospection
{
    id obj = [[dpObject alloc] init];
    id myobj = [[dpMyObject alloc] init];
    
    XCTAssert([myobj superclass]==[obj class], @"class equality");
    
    
    XCTAssert( [obj isKindOfClass:[dpObject class]] , @"");
    XCTAssert([myobj isKindOfClass:[dpObject class]], @""); //belongs to the class, or belong to a subclass of that class
    XCTAssert(![myobj isMemberOfClass:[dpObject class]], @"");  //no inheritance suport, just the most concrete one
    
    
    //Protocol Test
    XCTAssert([obj conformsToProtocol:@protocol(dpProtocol)], @"");
    XCTAssert([obj respondsToSelector:@selector(dummyfunc)], @"");
    
    //Run-time Messaging
    [obj performSelector:@selector(dummyfunc)];
}


-(void)testObjectEquality
{
    //The hash method must be implemented to return an integer that can be used as a table address in a hash table structure. If two objects are equal (as determined by the isEqual: method), they must have the same hash value.
    
    // If your object could be included in collections such as NSSet objects, you need to define hash and verify the invariant that if two objects are equal, they return the same hash value.
    
    //The default NSObject implementation of isEqual: simply checks for pointer equality.
}


-(void)testDelegation
{
    //A delegate is an object that acts on behalf of, or in coordination with, another object when that object encounters an event in a program.
    //The delegating object in a Cocoa or Cocoa Touch application is often a responder object
    //Delegating objects do not (and should not) retain their delegates.
}


-(void)testClassCluster
{
    id num = [NSNumber numberWithBool:YES];
    NSLog(@"%@", NSStringFromClass([num class]));  //__NSCFBoolean
    
    
    id arr = [MonthArray monthArray];
    NSLog(@"%@",arr);
    
}

@end






