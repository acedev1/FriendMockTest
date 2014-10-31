//
//  FriendTableViewCell.h
//  FriendMockTest
//
//  Created by AnMac on 10/31/14.
//  Copyright (c) 2014 Petr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendTableViewCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UIImageView *logoImageView;
@property (nonatomic, retain) IBOutlet UILabel *fullNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *statusLabel;
@property (nonatomic, retain) IBOutlet UISwitch *availableSwitch;

@end
