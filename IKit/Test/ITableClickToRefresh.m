/*
 Copyright (c) 2014 ideawu. All rights reserved.
 Use of this source code is governed by a license that can be
 found in the LICENSE file.
 
 @author:  ideawu
 @website: http://www.cocoaui.com/
 */

#import "ITableClickToRefresh.h"

@interface ITableClickToRefresh ()

@end

@implementation ITableClickToRefresh

- (id)init{
	self = [super init];
	self.navigationItem.title = @"ITableClickToRefresh";
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	
	{
		IView *view = [[IView alloc] init];
		[view.style set:@"height: 1200; background: #fff; margin: 4 10;"];
		{
			IButton *btn = [IButton buttonWithText:@"Click to Refresh(Header)"];
			[view addSubview:btn style:@"float: center; margin-top: 100; padding: 5 8; color: #fff; background: #f36145"];
			
			__weak typeof(self) me = self;
			[btn bindEvent:IEventClick handler:^(IEventType event, IView *view) {
				[me.pullRefresh beginHeaderRefresh];
			}];
		}
		
		{
			IButton *btn = [IButton buttonWithText:@"Click to Refresh(Footer)"];
			[view addSubview:btn style:@"float: center; margin-top: 100; padding: 5 8; color: #fff; background: #f36145"];
			
			__weak typeof(self) me = self;
			[btn bindEvent:IEventClick handler:^(IEventType event, IView *view) {
				[me.pullRefresh beginFooterRefresh];
			}];
		}
		[self addIViewRow:view];
	}

	if(!self.headerRefreshControl){
		IRefreshControl *header = [[IRefreshControl alloc] init];
		self.headerRefreshControl = header;
	}
	if(!self.footerRefreshControl){
		IRefreshControl *footer = [[IRefreshControl alloc] init];
		[footer setStateTextForNone:@"Pull up to load more"
							  maybe:@"Release to load more"
							  begin:@"loading..."];
		[footer.style set:@"top: -40;"];
		self.footerRefreshControl = footer;
	}

	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)onRefresh:(IRefreshControl *)view state:(IRefreshState)state{
	NSString *n = view == self.headerRefreshControl? @"header" : @"footer";
	NSLog(@"%@ %d", n, (int)state);
	[super onRefresh:view state:state];
}

@end
