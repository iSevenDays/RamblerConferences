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

#import "EventListTableViewController.h"
#import "EventListViewOutput.h"
#import "DataDisplayManager.h"
#import "EventListDataDisplayManager.h"
#import "EventPlainObject.h"

@interface EventListTableViewController() <EventLIstDataDisplayManagerDelegate>

@property (strong, nonatomic) UIColor *viewBackgroundColor;

@end

@implementation EventListTableViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.output setupView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setScrollViewColor];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

#pragma mark - EventListViewInput

- (void)setupViewWithEventList:(NSArray *)events {
    [self updateViewWithEventList:events];
    self.dataDisplayManager.delegate = self;
    
    self.tableView.dataSource = [self.dataDisplayManager dataSourceForTableView:self.tableView];
    self.tableView.delegate = [self.dataDisplayManager delegateForTableView:self.tableView withBaseDelegate:nil];
}

- (void)updateViewWithEventList:(NSArray *)events {
    EventPlainObject *event = [events firstObject];
    self.viewBackgroundColor = event.backgroundColor;
    [self setScrollViewColor];
    
    [self.dataDisplayManager updateTableViewModelWithEvents:events];
}

#pragma mark - EventListDataDisplayManagerDelegate

- (void)didUpdateTableViewModel {
    self.tableView.dataSource = [self.dataDisplayManager dataSourceForTableView:self.tableView];
    [self.tableView reloadData];
}

- (void)didTapCellWithEvent:(EventPlainObject *)event {
    [self.output didTriggerTapCellWithEvent:event];
}

#pragma mark - Private methods

- (void)setScrollViewColor {
    [[UIScrollView appearance] setBackgroundColor:self.viewBackgroundColor];
}

@end