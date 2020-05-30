//
//  ViewController.h
//  MVC-TodoList-Objc
//
//  Created by Tássio Marcos Rocha on 30/05/20.
//  Copyright © 2020 Tássio Marcos Rocha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "TaskService.h"

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
-(void) getTasks;
@end

