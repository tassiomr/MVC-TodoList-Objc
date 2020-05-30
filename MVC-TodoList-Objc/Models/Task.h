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

-(void) completeTask:(NSString*) uuid: (NSString*) title: (NSString*) subTitle: (NSString *) createAt: (NSNumber *) isFinished;
-(void) initTask:(NSString *) title: (NSString *) subTitle: (NSNumber *) isFinished;
@end

NS_ASSUME_NONNULL_END
