//
//  UPAHandbookAppDelegate.h
//  UPAHandbook
//
//  Created by Ken Cochrane on 3/22/09.
//  Copyright Zanbow, inc 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h> //Import the sqlite3 database framework

@interface UPAHandbookAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;

	// Database variables
	NSString *databaseName;
	NSString *databasePath;
	
	// Array to store the chapter objects
	NSMutableArray *chapters;
	

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) NSMutableArray *chapters;

-(void) checkAndCreateDatabase;
-(void) readChaptersFromDatabase;

@end

