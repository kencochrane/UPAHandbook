//
//  UPAHandbookAppDelegate.m
//  UPAHandbook
//
//  Created by Ken Cochrane on 3/22/09.
//  Copyright Zanbow, inc 2009. All rights reserved.
//

#import "UPAHandbookAppDelegate.h"
#import "RootViewController.h"
#import "Chapter.h" //import the chapter object header
#import "FlurryAnalytics.h"

@implementation UPAHandbookAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize chapters;


void uncaughtExceptionHandler(NSException *exception) {
    [FlurryAnalytics logError:@"Uncaught" message:@"Crash!" exception:exception];
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
	[FlurryAnalytics startSession:@"UDNS7CBWWTRM6XJ3U4PD"];
	
	// Setup some globals
	databaseName = @"UPA_Handbook_0_3.rsd";
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
	
	// Execute the "checkAndCreateDatabase" function
	[self checkAndCreateDatabase];
	
	// Query the database for all chapter records and construct the "chapters" array
	[self readChaptersFromDatabase];
	
	// Configure and show the window
	[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


- (void)dealloc {
	[chapters release];
	[navigationController release];
	[window release];
	[super dealloc];
}

-(void) checkAndCreateDatabase{
	// Check if the SQL database has already been saved to the users phone, if not then copy it over
	BOOL success;
	
	// Create a FileManager object, we will use this to check the status
	// of the database and to copy it over if required
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	// Check if the database has already been created in the users filesystem
	success = [fileManager fileExistsAtPath:databasePath];
	
	// If the database already exists then return without doing anything
	if(success) return;
	
	// If not then proceed to copy the database from the application to the users filesystem
	
	// Get the path to the database in the application package
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
	
	// Copy the database from the package to the users filesystem
	[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
	
	[fileManager release];
}

-(void) readChaptersFromDatabase {
	// Setup the database object
	sqlite3 *database;
	
	// Init the chapters Array
	chapters = [[NSMutableArray alloc] init];
	
	// Lets get the language for the person's phone using the app.
	NSString *preferredLang = [[NSLocale preferredLanguages] objectAtIndex:0];
	const char *langStr = [preferredLang UTF8String];
	// langStr return canonicalized IETFBCP47 language identifier such as “en” or “fr”.
	NSLog(@"Current Locale: %s", langStr);
	
	//Because we only support one language right now, we need to hard code this to en. in the future when we have more then
	//one language we will need to check this value and pass it in.
	langStr = "en";
	
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "select label,title,body,locale,num_order from content where locale = ? order by num_order";
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the chapters array
			NSInteger *c_index = 0;
			
			// bind the current locale language to the sql.
			sqlite3_bind_text(compiledStatement, 1,langStr, -1, SQLITE_TRANSIENT);
			
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
				NSString *aLabel = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
				NSString *aTitle = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
				NSString *aBody = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
				NSString *aLocale = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
				NSInteger *aNumOrder = (int *) sqlite3_column_int(compiledStatement, 4);
				
				// Create a new Chapter object with the data from the database
				Chapter *chapter = [[Chapter alloc] initWithName:aLabel title:aTitle locale:aLocale body:aBody numOrder:aNumOrder];
				
				// Add the chapter object to the chapters Array
				[chapters addObject:chapter];
				
				[chapter release];
				c_index++;
			}
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
	
}


@end
