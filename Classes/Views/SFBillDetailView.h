//
//  SFBillDetailView.h
//  Congress
//
//  Created by Daniel Cloud on 12/4/12.
//  Copyright (c) 2012 Sunlight Foundation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFInsetsView.h"

@interface SFBillDetailView : SFInsetsView
{
    UIScrollView *_scrollView;
}

@property (nonatomic, retain) SSLabel *titleLabel;
@property (nonatomic, retain) SSLabel *dateLabel;
@property (nonatomic, retain) SSLabel *summary;
@property (nonatomic, retain) SSLabel *sponsorName;
@property (nonatomic, retain) UIButton *linkOutButton;

@end
