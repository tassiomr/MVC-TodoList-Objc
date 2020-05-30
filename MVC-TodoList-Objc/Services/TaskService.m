//
//  TaskService.m
//  MVC-TodoList-Objc
//
//  Created by Tássio Marcos Rocha on 30/05/20.
//  Copyright © 2020 Tássio Marcos Rocha. All rights reserved.
//

#import "Task.h"
#import "TaskService.h"
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@implementation TaskService
- (void)createTask:(Task *)task {
	AppDelegate *delegate = [[AppDelegate alloc] init];
	
	NSManagedObjectContext *managedContext = [delegate persistentContainer].viewContext;
	NSEntityDescription *taskEntity = [NSEntityDescription entityForName:@"TaskEntity" inManagedObjectContext:managedContext];
	
	NSManagedObject *taskRaw = [[NSManagedObject alloc] initWithEntity:taskEntity insertIntoManagedObjectContext:managedContext];
	
	[taskRaw setValue:task.id forKey:@"id"];
	[taskRaw setValue:task.title forKey:@"title"];
	[taskRaw setValue:task.subTitle forKey:@"subTitle"];
	[taskRaw setValue:task.createAt forKey:@"createAt"];
	
	NSError *error = nil;
	[managedContext save:&error];
}

- (void)deleteTask:(NSString *)id {
	AppDelegate *delegate = [[AppDelegate alloc] init];
	
	NSManagedObjectContext *managedContext = [delegate persistentContainer].viewContext;
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"id = %@", id]];
	
	NSError *error = nil;
	NSArray *result = [managedContext executeRequest:fetchRequest error:&error];
	
	if(!result) {
		[error userInfo];
		abort();
	} else {
		NSManagedObject *objDelete = (NSManagedObject*) result[0];
		
		[managedContext deleteObject:objDelete];
		[managedContext save:&error];
	}
}


- (NSArray<Task *> *)readTasks {
	AppDelegate *delegate = [[AppDelegate alloc] init];
	NSManagedObjectContext *managedContext = [delegate persistentContainer].viewContext;
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSError *error = nil;
	NSArray *results = [managedContext executeRequest:fetchRequest error:&error];
	NSMutableArray<Task*> *tasks = [[NSMutableArray alloc] init];
	
	if(!results) {
		[error userInfo];
		return tasks;
	}
	
	for(int i = 0; i < results.count; i++) {
		NSManagedObject *object = results[i];
		
		Task *task = [[Task alloc] init];
		[task completeTask:[object valueForKey:@"id"] :[object valueForKey:@"title"] :[object valueForKey:@"subTitle"] :[object valueForKey:@"isFinished"] :[object valueForKey:@"createAt"]];
		
		[tasks addObject:task];
	}
	
	return tasks;
}
@end
