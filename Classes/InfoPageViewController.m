//
//  InfoPageViewController.m
//  UPAHandbook
//
//  Created by Ken Cochrane on 6/13/09.
//  Copyright 2009 Zanbow, inc. All rights reserved.
//

#import "InfoPageViewController.h"


@implementation InfoPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self)
	{
		// this will appear as the title in the navigation bar
		self.title = NSLocalizedString(@"UPA Handbook",@"Name of the Application");
	}
	
	return self;
}

// Automatically invoked after -loadView
// This is the preferred override point for doing additional setup after -initWithNibName:bundle:
//
- (void)viewDidLoad
{
	self.view.backgroundColor = [UIColor whiteColor];	// use the table view background color
	
	appName.text = NSLocalizedString(@"UPA Handbook \ndeveloped by Ken Cochrane",@"Credit line for application");
    gitHub.text = NSLocalizedString(@"Source Code available at github.com\nPlease Help make the app Better!",@"Source Code Location");
	thankYou.text = NSLocalizedString(@"Field diagram image provided by Chris McCreery",@"Thank you for application");
	
	//add links to UPA and zanbow webpages.
	copyright.text = NSLocalizedString(@"Copyright 2012 Zanbow Inc",@"Copyright line");
}

- (IBAction)dismissAction:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
}

-(IBAction)openZanbow {
	// Lanuch Zanbow.com
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://zanbow.com"]];
}

-(IBAction)openUPA {
	// Lanuch any UPA.org
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://usaultimate.org"]];
}

-(IBAction)emailKen {
	// Fire off an email to Ken
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://ken@zanbow.com"]];
}

-(IBAction)gotoGitHub {
	// Launch gitHub
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/kencochrane/UPAHandbook"]];
}

- (void)viewDidAppear:(BOOL)animated
{
	// do something here as our view re-appears
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
