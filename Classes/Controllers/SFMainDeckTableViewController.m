//
//  SFDeckedTableViewController.m
//  Congress
//
//  Created by Daniel Cloud on 12/6/12.
//  Copyright (c) 2012 Sunlight Foundation. All rights reserved.
//

#import "SFMainDeckTableViewController.h"
#import "IIViewDeckController.h"

@implementation SFMainDeckTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem menuButtonWithTarget:self.viewDeckController action:@selector(toggleLeftView)];
    self.navigationItem.backBarButtonItem = [UIBarButtonItem backButton];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
