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

#import "LectureInfoTableViewCellObject.h"
#import "LectureInfoTableViewCell.h"
#import "LecturePlainObject.h"
#import "SpeakerPlainObject.h"

@interface LectureInfoTableViewCellObject ()

@property (strong, nonatomic, readwrite) NSString *speakerName;
@property (strong, nonatomic, readwrite) NSString *speakerCompanyName;
@property (strong, nonatomic, readwrite) NSString *lectureDescription;
@property (strong, nonatomic, readwrite) NSString *lectureTitle;
@property (strong, nonatomic, readwrite) NSURL *speakerImageUrl;
@property (strong, nonatomic, readwrite) NSString *lectureObjectId;

@end

@implementation LectureInfoTableViewCellObject

#pragma mark - Initialization

- (instancetype)initWithLecture:(LecturePlainObject *)lecture {
    self = [super init];
    if (self) {
        _lectureDescription = lecture.lectureDescription;
        _lectureTitle = lecture.name;
        _lectureObjectId = lecture.objectId;
        
        // TODO: реализовать отображение нескольких докладчиков у одного доклада
        SpeakerPlainObject *speaker = [lecture.speakers firstObject];
        _speakerName = speaker.name;
        _speakerCompanyName = speaker.companyName;
        _speakerImageUrl = speaker.imageUrl;
    }
    return self;
}

+ (instancetype)objectWithLecture:(LecturePlainObject *)lecture {
    return [[self alloc] initWithLecture:lecture];
}

#pragma mark - NICellObject methods

- (Class)cellClass {
    return [LectureInfoTableViewCell class];
}

- (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([LectureInfoTableViewCell class]) bundle:[NSBundle mainBundle]];
}

@end
