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

- (void)completeTask:(NSString *)uuid :(NSString *)title :(NSString *)subTitle :(NSString *)createAt :(NSNumber *)isFinished {
	self.id = uuid;
	self.title = title;
	self.subTitle = subTitle;
	self.createAt = createAt;
	self.isFinished = isFinished;
}

- (void)initTask:(NSString *)title :(NSString *)subTitle :(NSNumber *)isFinished {
	NSUUID* uuid = [NSUUID UUID];
	
	NSDate* date = [[NSDate alloc] init];
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setLocalizedDateFormatFromTemplate:@"dd.MM.yyyy"];
	NSString* dating = [dateFormatter stringFromDate:date];
	
	self.id = [uuid UUIDString];
	self.title = title;
	self.subTitle = subTitle;
	self.createAt = dating;
	self.isFinished = isFinished;
}

@end
