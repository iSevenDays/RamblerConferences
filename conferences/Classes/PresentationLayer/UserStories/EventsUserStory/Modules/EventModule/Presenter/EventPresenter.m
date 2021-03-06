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

#import "EventPresenter.h"
#import "EventViewInput.h"
#import "EventInteractorInput.h"
#import "EventRouterInput.h"
#import "EventPlainObject.h"
#import "EventPresenterStateStorage.h"

@implementation EventPresenter

#pragma mark - EventModuleInput

- (void)configureCurrentModuleWithEventObjectId:(NSString *)objectId {
    self.presenterStateStorage.eventObjectId = objectId;
}

#pragma mark - EventViewOutput

- (void)setupView {
    [self.interactor obtainEventByObjectId:self.presenterStateStorage.eventObjectId];
}

- (void)didTriggerSignUpButtonTappedEvent {
    
}

- (void)didTriggerSaveToCalendarButtonTappedEvent {
    
}

- (void)didTriggerReadMoreEventDescriptionButtonTappedEvent {
    
}

- (void)didTriggerReadMoreLectureDescriptionButtonTappedEvent {
    
}

- (void)didTriggerCurrentTranslationButtonTapEvent {
    
}

- (void)didTapLectureInfoCellWithLectureObjectIdEvent:(NSString *)lectureObjectId {
    [self.router openLectureModuleWithLectureObjectId:lectureObjectId];
}

#pragma mark - EventInteractorOutput

- (void)didObtainEvent:(EventPlainObject *)event {
    [self.view configureViewWithEvent:event];
}

@end