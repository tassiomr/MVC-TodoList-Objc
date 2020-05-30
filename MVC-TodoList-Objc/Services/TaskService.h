//
//  TaskService.h
//  MVC-TodoList-Objc
//
//  Created by Tássio Marcos Rocha on 30/05/20.
//  Copyright © 2020 Tássio Marcos Rocha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@interface TaskService : NSObject
-(void) createTask: (Task* ) task;
-(void) deleteTask: (NSString* ) id;
-(void) updateTask: (Task* ) task;
-(NSMutableArray<Task*>*) readTasks;
@end

NS_ASSUME_NONNULL_END
