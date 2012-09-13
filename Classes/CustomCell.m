//
//  CustomCell.m
//  UPAHandbook
//
//  Created by Ken Cochrane on 5/31/09.
//  Copyright 2009 Zanbow, inc. All rights reserved.
//

#import "CustomCell.h"


@implementation CustomCell
@synthesize chapterNumber;
@synthesize chapterTitle;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


@end
