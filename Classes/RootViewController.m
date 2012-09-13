//
//  RootViewController.m
//  UPAHandbook
//
//  Created by Ken Cochrane on 3/22/09.
//  Copyright Zanbow, inc 2009. All rights reserved.
//

#import "RootViewController.h"
#import "UPAHandbookAppDelegate.h"
#import "Chapter.h"
#import "CustomCell.h"
#import "InfoPageViewController.h"


@implementation RootViewController
@synthesize chapterView;


- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	self.title = NSLocalizedString(@"UPA Handbook",@"Name of the Application");
	
	modalViewController = [[InfoPageViewController alloc] initWithNibName:@"InfoPageViewController" bundle:nil];
	
	// add our custom button to show our modal view controller
	UIButton* modalViewButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
	[modalViewButton addTarget:self action:@selector(modalViewAction:) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *modalButton = [[UIBarButtonItem alloc] initWithCustomView:modalViewButton];
	self.navigationItem.rightBarButtonItem = modalButton;
	[modalViewButton release];
}

// user clicked the "i" button, present info page as modal UIViewController
- (IBAction)modalViewAction:(id)sender
{
	// present info page as a modal child or overlay view
	[[self navigationController] presentModalViewController:modalViewController animated:YES];
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 causes issues with ChapterViewController's auto rotate because ChapterViewController sometimes gets confused.
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait ||
			interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
			interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}
 */


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    UPAHandbookAppDelegate *appDelegate = (UPAHandbookAppDelegate *)[[UIApplication sharedApplication] delegate];
	return appDelegate.chapters.count;

}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	
	static NSString *CustomCellIdentifier = @"CustomCellIdentifier";
	
    CustomCell  *cell = (CustomCell *) [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if (cell == nil) {
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
		cell = [nib objectAtIndex:0];
    }
	
    // Set up the cell
    UPAHandbookAppDelegate *appDelegate = (UPAHandbookAppDelegate *)[[UIApplication sharedApplication] delegate];
	Chapter *chapter = (Chapter *)[appDelegate.chapters objectAtIndex:indexPath.row];
	
	cell.chapterNumber.text = chapter.label;
	cell.chapterTitle.text = chapter.title;
	
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// Navigation logic -- create and push a new view controller
	UPAHandbookAppDelegate *appDelegate = (UPAHandbookAppDelegate *)[[UIApplication sharedApplication] delegate];
	Chapter *chapter = (Chapter *)[appDelegate.chapters objectAtIndex:indexPath.row];
	
	if(self.chapterView == nil) {
		ChapterViewController *viewController = [[ChapterViewController alloc] initWithNibName:@"ChapterViewController" bundle:nil];
		self.chapterView = viewController;
		[viewController release];
	}
	
	// Setup the animation
	[self.navigationController pushViewController:self.chapterView animated:YES];
	// Set the title of the view to the chapter's title
	//TODO make utility method, or part of the Chapter class this is too ugly here.
	NSString *cellTitle = chapter.label;
	cellTitle = [cellTitle stringByAppendingString:@" "];
	cellTitle = [cellTitle stringByAppendingString:chapter.title];
	
	self.chapterView.chapterIndex = chapter.numOrder;
	self.chapterView.title = cellTitle;
    [self.chapterView.chapterBodyHTML loadHTMLString:[chapter body] baseURL:nil];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{	
    return UITableViewCellAccessoryDisclosureIndicator;	
}


- (void)dealloc {
	[modalViewController release];
    [super dealloc];
}


@end

