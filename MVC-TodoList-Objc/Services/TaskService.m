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
	[taskRaw setValue:task.isFinished forKey:@"isFinished"];
	
	NSError *error = nil;
	[managedContext save:&error];
}

- (void)deleteTask:(NSString *)id {
	AppDelegate *delegate = [[AppDelegate alloc] init];
	NSManagedObjectContext *managedContext = [delegate persistentContainer].viewContext;
	
	NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"TaskEntity"];
	[fetchRequest setPredicate: [NSPredicate predicateWithFormat:@"id = %@", id]];
	
	NSError *error = nil;
	NSArray *results = [managedContext executeFetchRequest:fetchRequest error:&error];
	if(!results) {
		[error userInfo];
		abort();
	} else {
		NSManagedObject *objDelete = (NSManagedObject*) results[0];
		
		[managedContext deleteObject:objDelete];
		[managedContext save:&error];
	}
}

- (NSMutableArray<Task *> *)readTasks {
	AppDelegate *appDelegate = [[AppDelegate alloc] init];
	
	NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"TaskEntity"];
	
	NSError *error = nil;
	NSArray *result = [context executeFetchRequest:request error:&error];
	
	NSMutableArray<Task*> *tasks = [[NSMutableArray alloc] init];
	
	if(!result) {
		[error userInfo];
		abort();
		return nil;
	} else {
		for(NSManagedObject *object in result) {
			Task *task = [[Task alloc] initCompleteTaskWith:[object valueForKey:@"id"] title:[object valueForKey:@"title"]  subTitle:[object valueForKey:@"subTitle"] createAt:[object valueForKey:@"createAt"]  isFinished:[object valueForKey:@"isFinished"]];
			[tasks addObject:task];
		}
		
		return tasks;
	}
}

- (void)updateTask:(Task *)task {
	[task toggle];
	AppDelegate *delegate = [[AppDelegate alloc] init];
	NSManagedObjectContext *managedContext = [delegate persistentContainer].viewContext;
	
	NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"TaskEntity"];
	[fetchRequest setPredicate: [NSPredicate predicateWithFormat:@"id = %@", task.id]];
	
	NSError *error = nil;
	NSArray *results = [managedContext executeFetchRequest:fetchRequest error:&error];
	
	if(!results) {
		[error userInfo];
		abort();
	} else {
		NSObject *taskRaw = results[0];
		
		[taskRaw setValue:task.id forKey:@"id"];
		[taskRaw setValue:task.title forKey:@"title"];
		[taskRaw setValue:task.subTitle forKey:@"subTitle"];
		[taskRaw setValue:task.createAt forKey:@"createAt"];
		[taskRaw setValue:task.isFinished forKey:@"isFinished"];
		
		[managedContext save:&error];
	}
}
@end
