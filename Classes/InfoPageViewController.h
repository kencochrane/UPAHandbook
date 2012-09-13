//
//  InfoPageViewController.h
//  UPAHandbook
//
//  Created by Ken Cochrane on 6/13/09.
//  Copyright 2009 Zanbow, inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InfoPageViewController : UIViewController {

	IBOutlet UILabel *appName;
    IBOutlet UILabel *gitHub;
	IBOutlet UILabel *thankYou;
	IBOutlet UILabel *copyright;
}

- (IBAction)dismissAction:(id)sender;
- (IBAction)openZanbow;
- (IBAction)openUPA;
- (IBAction)emailKen;
- (IBAction)gotoGitHub;

@end
