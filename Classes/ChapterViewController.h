//
//  ChapterViewController.h
//  UPAHandbook
//
//  Created by Ken Cochrane on 3/22/09.
//  Copyright 2009 Zanbow, inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ChapterViewController : UIViewController {
	IBOutlet UITextView *chapterBody;
	IBOutlet UIWebView *chapterBodyHTML;
	NSInteger *chapterIndex;
}

@property (nonatomic,retain) IBOutlet UITextView *chapterBody;
@property (nonatomic,retain) IBOutlet UIWebView *chapterBodyHTML;
@property NSInteger *chapterIndex;

@end
