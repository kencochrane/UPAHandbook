//
//  CustomCell.h
//  UPAHandbook
//
//  Created by Ken Cochrane on 5/31/09.
//  Copyright 2009 Zanbow, inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomCell : UITableViewCell {
	IBOutlet UILabel *chapterNumber;
	IBOutlet UILabel *chapterTitle;
}

@property (nonatomic,retain) IBOutlet UILabel *chapterNumber;
@property (nonatomic,retain) IBOutlet UILabel *chapterTitle;

@end
