//
//  AddTaskViewController.m
//  MVC-TodoList-Objc
//
//  Created by Tássio Marcos Rocha on 31/05/20.
//  Copyright © 2020 Tássio Marcos Rocha. All rights reserved.
//

#import "AddTaskViewController.h"
#import "Task.h"
#import "TaskService.h"

@interface AddTaskViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UISwitch *toggle;
@property (nullable, nonatomic) Task *task;
@property (nonnull, nonatomic) TaskService *service;
@end

@implementation AddTaskViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view
	self.service = [[TaskService alloc]init];
	[self setup];
}

-(void) setup {
	self.titleTextField.delegate = self;
	self.descriptionTextView.delegate = self;
	
	if(self.task != nil) {
		self.titleTextField.text = self.task.title;
		self.descriptionTextView.text = self.task.subTitle;
		if([self.task.isFinished intValue] == 0) {
			[[self toggle] setOn:FALSE];
		} else {
			[[self toggle] setOn:TRUE];
		}
	}
}

-(IBAction)finishForm:(id)sender {
	NSNumber *isFinished = [NSNumber numberWithInt:0];
	
	if(self.toggle.on) {
		isFinished = [NSNumber numberWithInt:1];
	}
	
	if(self.task == nil) {
		[[self service] createTask:[[Task alloc] initTaskWithTitle:self.titleTextField.text subTitle:self.descriptionTextView.text isFinished:isFinished]];
	} else {
		[[self task] setTitle:self.titleTextField.text];
		[[self task] setSubTitle:self.descriptionTextView.text];
		[[self task] toggle];
		[[self service] updateTask:self.task];
	}
	
	[[self navigationController] popViewControllerAnimated:true];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[[self view] endEditing:TRUE];
	return FALSE;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
	if([text isEqualToString:@"\n"]) {
		[textView resignFirstResponder];
		return FALSE;
	}
	return TRUE;
}

@end
