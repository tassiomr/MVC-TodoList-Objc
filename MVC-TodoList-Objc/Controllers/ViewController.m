//
//  ViewController.m
//  MVC-TodoList-Objc
//
//  Created by Tássio Marcos Rocha on 30/05/20.
//  Copyright © 2020 Tássio Marcos Rocha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property TaskService *service;
@property NSMutableArray<Task*> *tasks;
@property (weak, nonatomic) IBOutlet UITableView *uiTableView;
@end

@implementation ViewController
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	Task *task = [self tasks][indexPath.row];
	UITableViewCell *cell = [[UITableViewCell alloc] init];
	cell.textLabel.text = task.title;
	[self uiTableView].delegate = self;
	
	return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.tasks.count;
}


- (void)viewDidLoad {
	[super viewDidLoad];
	[self navigationItem].title = @"Tasks";
	[self navigationController].navigationBar.prefersLargeTitles = true;
	[self setupController];
	self.service = [[TaskService alloc] init];
	[self getTasks];
	// Do any additional setup after loading the view.
}

- (void)getTasks {
	NSMutableArray<Task*> *tasks = [[self service] readTasks];
	self.tasks = tasks;
	[[self uiTableView] reloadData];
}

-(void)setupController {
	UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:nil];
	
	self.navigationItem.leftBarButtonItem = button;
}


- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
	UIContextualAction *edit = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"Edit" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
		return;
	}];
	
	edit.backgroundColor = UIColor.magentaColor;
	
	UIContextualAction *finish = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"Finish" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
		return;
	}];
	
	finish.backgroundColor = UIColor.grayColor;
	
	UIContextualAction *delete = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"Delete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
		return;
	}];
	
	delete.backgroundColor = UIColor.orangeColor;
	
	
	UISwipeActionsConfiguration *swipeActions = [UISwipeActionsConfiguration configurationWithActions:@[delete, finish, edit]];
	swipeActions.performsFirstActionWithFullSwipe = FALSE;
	
	return swipeActions;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 80;
}

@end
