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

#import "ManagedObjectMapper.h"

#import <EasyMapping/EasyMapping.h>
#import <MagicalRecord/MagicalRecord.h>

#import "ManagedObjectMappingProvider.h"
#import "ResponseObjectFormatter.h"
#import "NetworkingConstantsHeader.h"

@interface ManagedObjectMapper ()

@property (strong, nonatomic) ManagedObjectMappingProvider *provider;
@property (strong, nonatomic) id<ResponseObjectFormatter> responseFormatter;

@end

@implementation ManagedObjectMapper

#pragma mark - Initialization

- (instancetype)initWithMappingProvider:(ManagedObjectMappingProvider *)mappingProvider
                responseObjectFormatter:(id<ResponseObjectFormatter>)formatter {
    self = [super init];
    if (self) {
        _provider = mappingProvider;
        _responseFormatter = formatter;
    }
    return self;
}

#pragma mark - RCFResponseMapper

- (id)mapServerResponse:(id)response
     withMappingContext:(NSDictionary *)context
                  error:(NSError *__autoreleasing *)error {
    if (self.responseFormatter) {
        response = [self.responseFormatter formatServerResponse:response];
    }
    NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
    EKManagedObjectMapping *mapping = [self retreiveMappingForMappingContext:context];
    NSFetchRequest *request = [self createFetchRequestForMappingContext:context
                                                         managedContext:rootSavingContext];
    
    __block NSArray *result;
    [rootSavingContext performBlockAndWait:^{
        result = [EKManagedObjectMapper syncArrayOfObjectsFromExternalRepresentation:response
                                                                                  withMapping:mapping
                                                                                 fetchRequest:request
                                                                       inManagedObjectContext:rootSavingContext];
        [rootSavingContext MR_saveToPersistentStoreAndWait];
    }];
    
    return result;
}

#pragma mark - Helper Methods

- (EKManagedObjectMapping *)retreiveMappingForMappingContext:(NSDictionary *)mappingContext {
    Class managedObjectClass = NSClassFromString(mappingContext[kMappingContextModelClassKey]);
    EKManagedObjectMapping *mapping = [self.provider mappingForManagedObjectModelClass:managedObjectClass];
    return mapping;
}

- (NSFetchRequest *)createFetchRequestForMappingContext:(NSDictionary *)mappingContext
                                         managedContext:(NSManagedObjectContext *)managedContext {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:mappingContext[kMappingContextModelClassKey]
                                   inManagedObjectContext:managedContext]];
    return request;
}

#pragma mark - Debug Description

- (NSString *)debugDescription {
    return NSStringFromClass([self class]);
}

@end
