//
//  Chapter.h
//  UPAHandbook
//
//  Created by Ken Cochrane on 3/22/09.
//  Copyright 2009 Zanbow, inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Chapter : NSObject {
	NSString *label;
	NSString *title;
	NSString *locale;
	NSString *body;
	NSInteger *numOrder;
}

@property (nonatomic,retain) NSString *label;
@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *locale;
@property (nonatomic,retain) NSString *body;
@property NSInteger *numOrder;

-(id)initWithName:(NSString *)l title:(NSString *)t locale:(NSString *)e body:(NSString *)b numOrder:(NSInteger *)c;


@end
