//
//  RootViewController.h
//  UPAHandbook
//
//  Created by Ken Cochrane on 3/22/09.
//  Copyright Zanbow, inc 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChapterViewController.h"

@class InfoPageViewController;

@interface RootViewController : UITableViewController {
	ChapterViewController *chapterView;
	InfoPageViewController	*modalViewController;
}

@property(nonatomic, retain) ChapterViewController *chapterView;

@end
