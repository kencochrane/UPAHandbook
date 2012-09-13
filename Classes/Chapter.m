//
//  Chapter.m
//  UPAHandbook
//
//  Created by Ken Cochrane on 3/22/09.
//  Copyright 2009 Zanbow, inc. All rights reserved.
//

#import "Chapter.h"


@implementation Chapter
@synthesize label,title,body,locale,numOrder;

-(id)initWithName:(NSString *)l title:(NSString *)t locale:(NSString *)e body:(NSString *)b numOrder:(NSInteger *)c {
	self.label = l;
	self.title = t;
	self.locale = e;
	self.body = b;
	self.numOrder = c;
	return self;
}

@end
