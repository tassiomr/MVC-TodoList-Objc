//
//  Task.h
//  MVC-TodoList-Objc
//
//  Created by Tássio Marcos Rocha on 30/05/20.
//  Copyright © 2020 Tássio Marcos Rocha. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Task : NSObject

@property (nullable, nonatomic, readwrite) NSString* id;
@property (nonnull, nonatomic, readwrite) NSString* title;
@property (nullable, nonatomic, readwrite) NSString* subTitle;
@property (nullable, nonatomic, readwrite) NSString* createAt;
@property (nonatomic, readwrite) NSNumber* isFinished;

-(void) completeTaskWith: (NSString* )uuid title: (NSString *) title subTitle: (NSString *) subTitle createAt: (NSString *) createAt isFinished: (NSNumber *) isFinished;
-(void) initTaskWithTitle: (NSString *) title subTitle: (NSString *) subTitle isFinished: (NSNumber *) isFinished;
-(void) toggle;
@end

NS_ASSUME_NONNULL_END
