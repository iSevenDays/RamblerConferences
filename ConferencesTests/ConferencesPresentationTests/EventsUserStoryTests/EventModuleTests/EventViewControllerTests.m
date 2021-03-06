// Copyright (c) 2015 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <CrutchKit/Proxying/Extensions/UIViewController+CDObserver/UIViewController+CDObserver.h>

#import "EventViewController.h"
#import "EventViewOutput.h"
#import "EventDataDisplayManager.h"
#import "DataDisplayManager.h"
#import "EventTableViewCellActionProtocol.h"
#import "EventPlainObject.h"
#import "EventHeaderView.h"

@interface EventViewControllerTests : XCTestCase

@property (strong, nonatomic) EventViewController <EventTableViewCellActionProtocol> *viewController;
@property (strong, nonatomic) id <EventViewOutput> mockOutput;
@property (strong, nonatomic) EventDataDisplayManager *mockDataDisplayManager;
@property (nonatomic, strong) UITableView *mockTableView;

@end

@implementation EventViewControllerTests

- (void)setUp {
    [super setUp];

    self.viewController = [EventViewController new];
    self.mockOutput = OCMProtocolMock(@protocol(EventViewOutput));
    self.mockDataDisplayManager = OCMClassMock([EventDataDisplayManager class]);
    self.mockTableView = OCMClassMock([UITableView class]);
    
    self.viewController.output = self.mockOutput;
    self.viewController.dataDisplayManager = self.mockDataDisplayManager;
    self.viewController.tableView = self.mockTableView;
}

- (void)tearDown {
    self.viewController = nil;
    self.mockOutput = nil;
    self.mockDataDisplayManager = nil;
    self.mockTableView = nil;
    
    [super tearDown];
}

#pragma mark - Lifecycle

- (void)testSuccessViewDidLoad {
    // given
    EventViewController *partialMockViewController = OCMPartialMock(self.viewController);
    
    // when
    [partialMockViewController viewDidLoad];
    
    // then
    OCMVerify([partialMockViewController cd_startObserveProtocol:@protocol(EventTableViewCellActionProtocol)]);
    OCMVerify([self.mockOutput setupView]);
}

#pragma mark - EventViewInput

- (void)testSuccessConfigureViewWithEvent {
    // given
    EventPlainObject *event = [EventPlainObject new];
    
    id dataSource = OCMProtocolMock(@protocol(UITableViewDataSource));
    id delegate = OCMProtocolMock(@protocol(UITableViewDelegate));
    
    OCMStub([self.mockDataDisplayManager dataSourceForTableView:self.mockTableView]).andReturn(dataSource);
    OCMStub([self.mockDataDisplayManager delegateForTableView:self.mockTableView withBaseDelegate:nil]).andReturn(delegate);
    
    // when
    [self.viewController configureViewWithEvent:event];
    
    // then
    OCMVerify([self.mockTableView setDataSource:dataSource]);
    OCMVerify([self.mockTableView setDelegate:delegate]);
    OCMVerify([self.mockDataDisplayManager configureDataDisplayManagerWithEvent:event]);
}

- (void)testSuccesConfigureHeaderModule {
    // given
    EventPlainObject *event = [EventPlainObject new];
    
    EventHeaderView *mockHeaderView = OCMClassMock([EventHeaderView class]);
    self.viewController.headerView = mockHeaderView;
    
    // when
    [self.viewController configureViewWithEvent:event];
    
    // then
    OCMVerify([mockHeaderView configureModuleWithEvent:event]);
}

#pragma mark - EventTableViewCellActionProtocol

- (void)testSuccessDidTapSignUpButton {
    // given
    
    // when
    [self.viewController didTapSignUpButton:OCMOCK_ANY];
    
    // then
    OCMVerify([self.mockOutput didTriggerSignUpButtonTappedEvent]);
}

- (void)testSuccessdidTapSaveToCalendarButton {
    // given
    
    // when
    [self.viewController didTapSaveToCalendarButton:OCMOCK_ANY];
    
    // then
    OCMVerify([self.mockOutput didTriggerSaveToCalendarButtonTappedEvent]);
}

- (void)testSuccessDidTapReadMoreEventDescriptionButton {
    // given
    
    // when
    [self.viewController didTapReadMoreEventDescriptionButton:OCMOCK_ANY];
    
    // then
    OCMVerify([self.mockOutput didTriggerReadMoreEventDescriptionButtonTappedEvent]);
}

- (void)testSuccessDidTapReadMoreLectureDescriptionButton {
    // given
    
    // when
    [self.viewController didTapReadMoreLectureDescriptionButton:OCMOCK_ANY];
    
    // then
    OCMVerify([self.mockOutput didTriggerReadMoreLectureDescriptionButtonTappedEvent]);
}

- (void)testSuccessDidTapCurrentTranslationButton {
    // given
    
    // when
    [self.viewController didTapCurrentTranslationButton:OCMOCK_ANY];
    
    // then
    OCMVerify([self.mockOutput didTriggerCurrentTranslationButtonTapEvent]);
}

@end
