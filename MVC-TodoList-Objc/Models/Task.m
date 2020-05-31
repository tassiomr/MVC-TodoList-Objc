//
//  Task.m
//  MVC-TodoList-Objc
//
//  Created by Tássio Marcos Rocha on 30/05/20.
//  Copyright © 2020 Tássio Marcos Rocha. All rights reserved.
//

#import "Task.h"
#import <Foundation/Foundation.h>

@implementation Task

- (instancetype)initCompleteTaskWith:(NSString *)uuid title:(NSString *)title subTitle:(NSString *)subTitle createAt:(NSString *)createAt isFinished:(NSNumber *)isFinished {
	
	if(self = [super init]) {
		self.id = uuid;
		self.title = title;
		self.subTitle = subTitle;
		self.createAt = createAt;
		self.isFinished = isFinished;
	}
	
	return self;
	
}

- (instancetype)initTaskWithTitle:(NSString *)title subTitle:(NSString *)subTitle isFinished:(NSNumber *)isFinished {
	
	if(self = [super init]) {
		
		NSUUID *uuid = [NSUUID UUID];
		NSDate *date = [[NSDate alloc] init];
		NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setLocalizedDateFormatFromTemplate:@"dd.MM.yyyy"];
		NSString* dating = [dateFormatter stringFromDate:date];
		
		_id = [uuid UUIDString];
		_title = title;
		_subTitle = subTitle;
		_createAt = dating;
		_isFinished = isFinished;
	}
	
	return self;;
	
}

- (void)toggle {
	if([self.isFinished intValue] == 0) {
		[self setValue:[NSNumber numberWithInt:1] forKey:@"isFinished"];
		return;
	}
	
	if([self.isFinished intValue] == 1) {
		[self setValue:[NSNumber numberWithInt:0] forKey:@"isFinished"];
		return;
	}
}

@end
