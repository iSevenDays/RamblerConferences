//
//  EventPresenterTests.m
//  Conferences
//
//  Created by Karpushin Artem on 05/12/15.
//  Copyright © 2015 Rambler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "EventPresenter.h"
#import "EventInteractorInput.h"
#import "EventViewInput.h"
#import "EventPresenterStateStorage.h"
#import "EventPlainObject.h"

@interface EventPresenterTests : XCTestCase

@property (strong, nonatomic) EventPresenter *presenter;
@property (strong, nonatomic) id <EventInteractorInput> mockInteractor;
@property (strong, nonatomic) id <EventViewInput> mockView;
@property (strong, nonatomic) EventPresenterStateStorage *presenterStateStorage;

@end

@implementation EventPresenterTests

- (void)setUp {
    [super setUp];
    
    self.presenter = [EventPresenter new];
    self.mockInteractor = OCMProtocolMock(@protocol(EventInteractorInput));
    self.mockView = OCMProtocolMock(@protocol(EventViewInput));
    self.presenterStateStorage = [EventPresenterStateStorage new];
    
    self.presenter.interactor = self.mockInteractor;
    self.presenter.view = self.mockView;
    self.presenter.presenterStateStorage = self.presenterStateStorage;
}

- (void)tearDown {
    self.presenter = nil;
    self.mockInteractor = nil;
    self.mockView = nil;
    self.presenterStateStorage = nil;

    [super tearDown];
}

- (void)testSuccessConfigureCurrentModuleWithEventObjectId {
    // given
    NSString *eventObjectId = @"Ds312k7";
    
    // when
    [self.presenter configureCurrentModuleWithEventObjectId:eventObjectId];
    
    // then
    XCTAssertEqualObjects(eventObjectId, self.presenterStateStorage.eventObjectId);
}

- (void)testSuccessSetupView {
    // given
    NSString *eventObjectId = @"Ds312k7";
    
    // when
    [self.presenter configureCurrentModuleWithEventObjectId:eventObjectId];
    [self.presenter setupView];
    
    // then
    OCMVerify([self.mockInteractor obtainEventByObjectId:eventObjectId]);
}

- (void)testSuccessDidTriggerSignUpButtonTappedEvent {
    // given
    
    // when
    [self.presenter didTriggerSignUpButtonTappedEvent];
    
    // then
    #warning Complete test after method get implemented
}

- (void)testSuccessDidTriggerSaveToCalendarButtonTappedEvent {
    // given
    
    // when
    [self.presenter didTriggerSaveToCalendarButtonTappedEvent];
    
    // then
}

- (void)testSuccessDidTriggerReadMoreEventDescriptionButtonTappedEvent {
    // given
    
    // when
    [self.presenter didTriggerReadMoreEventDescriptionButtonTappedEvent];
    
    // then
    #warning Complete test after method get implemented
}

- (void)testSuccessDidTriggerReadMoreLectureDescriptionButtonTappedEvent {
    // given
    
    // when
    [self.presenter didTriggerReadMoreLectureDescriptionButtonTappedEvent];
    
    // then
    #warning Complete test after method get implemented
}

- (void)testSuccessDidTriggerCurrentTranslationButtonTapEvent {
    // given
    
    // when
    [self.presenter didTriggerCurrentTranslationButtonTapEvent];
    
    // then
    #warning Complete test after method get implemented
}

- (void)testSuccessDidObtainEvent {
    // given
    EventPlainObject *event = [EventPlainObject new];
    
    // when
    [self.presenter didObtainEvent:event];
    
    // then
    OCMVerify([self.mockView configureViewWithEvent:event]);
}

@end
