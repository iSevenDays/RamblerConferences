//
//  RamblerLocationModuleAssemblyTests.m
//  Conferences
//
//  Created by Karpushin Artem on 22/11/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <RamblerTyphoonUtils/AssemblyTesting.h>

#import "RamblerLocationModuleAssembly.h"
#import "RamblerLocationModuleAssembly_Testable.h"
#import "RamblerLocationViewController.h"
#import "RamblerLocationInteractor.h"
#import "RamblerLocationPresenter.h"
#import "RamblerLocationRouter.h"
#import "ServiceComponentsAssembly.h"
#import "OperationFactoriesAssembly.h"

#import "TabBarButtonPrototype.h"

@interface RamblerLocationModuleAssemblyTests : RamblerTyphoonAssemblyTests

@property (strong, nonatomic) RamblerLocationModuleAssembly *assembly;

@end

@implementation RamblerLocationModuleAssemblyTests

- (void)setUp {
    [super setUp];
    
    self.assembly = [RamblerLocationModuleAssembly new];
    [self.assembly activateWithCollaboratingAssemblies:@[
                                                         [ServiceComponentsAssembly new],
                                                         [OperationFactoriesAssembly new],
                                                         ]];
}

- (void)tearDown {
    self.assembly = nil;
    
    [super tearDown];
}

- (void)testThatAssemblyCreatesView {
    // given
    Class targetClass = [RamblerLocationViewController class];
    NSArray *dependencies = @[
                              RamblerSelector(output),
                              ];
    // when
    id result = [self.assembly viewRamblerLocation];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesInteractor {
    // given
    Class targetClass = [RamblerLocationInteractor class];
    NSArray *dependencies = @[
                              RamblerSelector(output),
                              ];
    // when
    id result = [self.assembly interactorRamblerLocation];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesPresenter {
    // given
    Class targetClass = [RamblerLocationPresenter class];
    NSArray *dependencies = @[
                              RamblerSelector(view),
                              RamblerSelector(interactor),
                              RamblerSelector(router)
                              ];
    // when
    id result = [self.assembly presenterRamblerLocation];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesRouter {
    // given
    Class targetClass = [RamblerLocationRouter class];
    NSArray *dependencies = @[];
    // when
    id result = [self.assembly routerRamblerLocation];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

- (void)testThatAssemblyCreatesReportListTabBarButtonPrototype {
    // given
    Class targetClass = [TabBarButtonPrototype class];
    NSArray *dependencies = @[
                              // TODO: разкомментить после добавления изображений
                              
                              //RamblerSelector(tabBarButtonIdleStateImage),
                              //RamblerSelector(tabBarButtonSelectedStateImage),
                              RamblerSelector(tabBarButtonTitle),
                              RamblerSelector(tabbarButtonId),
                              RamblerSelector(tabBarControllercontent)
                              ];
    // when
    id result = [self.assembly ramblerLocationTabBarButtonPrototype];
    
    // then
    [self verifyTargetDependency:result withClass:targetClass dependencies:dependencies];
}

@end
