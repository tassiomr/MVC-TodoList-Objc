#import "ViewController.h"
#import "AddTaskViewController.h"
#import "DetailsViewController.h"

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
	
	
	if([task.isFinished intValue] == 0) {
		cell.backgroundColor = UIColor.redColor;
	} else {
		cell.backgroundColor = UIColor.greenColor;
	}
	
	return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.tasks.count;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated {
	[self setupController];
	[self getTasks];
	[[self uiTableView] reloadData];
}

- (void)getTasks {
	NSMutableArray<Task*> *tasks = [[self service] readTasks];
	self.tasks = tasks;
	[[self uiTableView] reloadData];
}

-(void) goToPage {
	AddTaskViewController *controller = [[self storyboard] instantiateViewControllerWithIdentifier:@"addViewController"];
	[[self navigationController] pushViewController:controller animated:TRUE];
}

-(void)setupController {
	[self navigationItem].title = @"Tasks";
	[self navigationController].navigationBar.prefersLargeTitles = true;
	UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(goToPage)];
	self.service = [[TaskService alloc] init];
	self.navigationItem.leftBarButtonItem = button;
	
	self.uiTableView.delegate = self;
}

-(UIContextualAction*) createActionWithStyle: (UIContextualActionStyle) contextStyle title: (NSString*) title bgColor: (UIColor*) bgColor handler: (void (^)(void)) handler {
	
	UIContextualAction *action = [UIContextualAction contextualActionWithStyle:contextStyle title:title handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
		handler();
		completionHandler(true);
	}];
	
	action.backgroundColor = bgColor;
	
	return action;
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
	UIContextualAction *delete = [self createActionWithStyle:UIContextualActionStyleDestructive title:@"Delete" bgColor:UIColor.orangeColor handler:^{
		Task *task = self.tasks[indexPath.row];
		[[self service] deleteTask:task.id];
		[[self tasks] removeObject:task];
		[tableView reloadData];
		return;
	}];
	
	UIContextualAction *edit = [self createActionWithStyle:UIContextualActionStyleDestructive title:@"Edit" bgColor:UIColor.magentaColor handler:^{
		AddTaskViewController *controller = [[self storyboard] instantiateViewControllerWithIdentifier:@"addViewController"];
		[controller setValue: self.tasks[indexPath.row] forKey:@"task"];
		[[self navigationController] pushViewController:controller animated:TRUE];
		return;
	}];
	
	UIContextualAction *finish = [self createActionWithStyle:UIContextualActionStyleDestructive title:@"Finish" bgColor:UIColor.grayColor handler:^{
		Task *task = self.tasks[indexPath.row];
		[[self service] updateTask:task];
		[self getTasks];
		[tableView reloadData];
		
		return;
	}];
	
	UISwipeActionsConfiguration *swipeActions = [UISwipeActionsConfiguration configurationWithActions:@[delete, finish, edit]];
	swipeActions.performsFirstActionWithFullSwipe = FALSE;
	return swipeActions;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	DetailsViewController *controller = [[self storyboard] instantiateViewControllerWithIdentifier:@"datailsViewController"];
	[controller setValue: self.tasks[indexPath.row] forKey:@"task"];
	[[self navigationController] pushViewController:controller animated:true];
	[tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 60;
}

@end
