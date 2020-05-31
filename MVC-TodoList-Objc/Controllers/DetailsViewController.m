//
//  DetailsViewController.m
//  MVC-TodoList-Objc
//
//  Created by Tássio Marcos Rocha on 31/05/20.
//  Copyright © 2020 Tássio Marcos Rocha. All rights reserved.
//

#import "DetailsViewController.h"
#import "Task.h"
#import "TaskService.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *createAtLabel;
@property (weak, nonatomic) IBOutlet UISwitch *isFinished;
@property (nonatomic, nonnull) Task *task;
@property (nonatomic, nonnull) TaskService *service;
@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
		self.service = [[TaskService alloc] init];
    // Do any additional setup after loading the view.
		[self setupController];
}


- (void) setupController {
	[[self descriptionLabel] setText:self.task.subTitle];
	[[self createAtLabel] setText:[NSString stringWithFormat:@"Created at: %@", self.task.createAt]];
	if(self.task.isFinished.intValue == 0) {
		[[self isFinished] setOn:FALSE];
	} else {
		[[self isFinished] setOn:TRUE];
	}
	
	[[self isFinished] setEnabled:FALSE];
	[[self navigationItem] setTitle:self.task.title];
}

//	self.task.toggle()
//	self.service.update(task: task)
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




//@IBOutlet weak var descriptionLabel: UITextView?
//@IBOutlet weak var createAtLabel: UILabel?
//@IBOutlet weak var isFinished: UISwitch?
//
//var task: Task!
//var service: TaskService!
//override func viewDidLoad() {
//	super.viewDidLoad()
//	self.setup()
//	// Do any additional setup after loading the view.
//}
//
//func setup() {
//	service = TaskService()
//	navigationItem.title = task.title
//	if task.description.count > 0 {
//		descriptionLabel?.text = task.description
//	} else {
//		descriptionLabel?.text = "Don't have description"
//	}
//
//	isFinished?.isOn = task.isFinished
//	createAtLabel?.text = "Created at: \(task.create_at)"
//
//	isFinished?.addTarget(self, action: #selector(whenSwicthChangeValue(_:)), for: .valueChanged)
//}
//
//@objc func whenSwicthChangeValue(_ sender:UISwitch!) {
//	self.task.toggle()
//	self.service.update(task: task)
//}

@end
