//
//  ChapterViewController.m
//  UPAHandbook
//
//  Created by Ken Cochrane on 3/22/09.
//  Copyright 2009 Zanbow, inc. All rights reserved.
//

#import "ChapterViewController.h"
#import "UPAHandbookAppDelegate.h"
#import "Chapter.h"

@implementation ChapterViewController

@synthesize chapterBody,chapterBodyHTML,chapterIndex;


// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    // "Segmented" control to the right
	UISegmentedControl *segmentedControl = [[[UISegmentedControl alloc] initWithItems:
											 [NSArray arrayWithObjects:
											  [UIImage imageNamed:@"up.png"],
											  [UIImage imageNamed:@"down.png"],
											  nil]] autorelease];
	[segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
	segmentedControl.frame = CGRectMake(0, 0, 90, 30.0);
	segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
	segmentedControl.momentary = YES;
	
	UIBarButtonItem *segmentBarItem = [[[UIBarButtonItem alloc] initWithCustomView:segmentedControl] autorelease];
	self.navigationItem.rightBarButtonItem = segmentBarItem;
	
}

- (void)segmentAction:(id)sender
{
	UISegmentedControl* segCtl = sender;
	// the segmented control was clicked, handle it here 
	NSInteger buttonPush = [segCtl selectedSegmentIndex];
	
	UPAHandbookAppDelegate *appDelegate = (UPAHandbookAppDelegate *)[[UIApplication sharedApplication] delegate];

	NSInteger num_chapters = appDelegate.chapters.count;
	
	NSLog(@" num_chapters = %d " , num_chapters); 
	NSLog(@" Chapter Index = %d " , (int)chapterIndex); 
	
	//cycle through the chapters, if we get to the end loop around
	NSInteger index = 0;
	NSInteger pageIndex = (int)chapterIndex - 1;
	if(buttonPush == 0){
		if(pageIndex == 0){
			index = num_chapters - 1;
		}else{
			index = pageIndex - 1;
		}
	}else{
		if (pageIndex == (num_chapters - 1)){
			index = 0;
		}else{
			index = pageIndex + 1;
		}	
	}
	
	NSLog(@" index = %d " , index); 
	
	Chapter *chapter = (Chapter *)[appDelegate.chapters objectAtIndex:index];
	
	NSString *cellTitle = chapter.label;
	cellTitle = [cellTitle stringByAppendingString:@" "];
	cellTitle = [cellTitle stringByAppendingString:chapter.title];
	
	chapterIndex = chapter.numOrder;
    self.navigationItem.title = cellTitle;
    [chapterBodyHTML loadHTMLString:[chapter body] baseURL:nil];
	
	
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait ||
			interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
			interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)willAnimateSecondHalfOfRotationFromInterfaceOrientation:
	(UIInterfaceOrientation)fromInterfaceOrientation duration:(NSTimeInterval)duration {
	UIInterfaceOrientation toOrientation = self.interfaceOrientation;
	
	if(toOrientation == UIInterfaceOrientationPortrait || toOrientation == UIInterfaceOrientationPortraitUpsideDown){
		chapterBodyHTML.frame = CGRectMake(0, 0, 320, 420);
	} else {
		chapterBodyHTML.frame = CGRectMake(0, 0, 480, 280);
	}
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[chapterBodyHTML release];
    [super dealloc];
}


@end
