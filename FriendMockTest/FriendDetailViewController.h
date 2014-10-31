//
//  FriendDetailViewController.h
//  FriendMockTest
//
//  Created by AnMac on 10/31/14.
//  Copyright (c) 2014 Petr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendDetailViewController : UIViewController <NSURLConnectionDelegate> {
    IBOutlet UILabel *labelName;
    IBOutlet UILabel *labelNumber;
    IBOutlet UILabel *labelAddress;
    IBOutlet UILabel *labelCity;
    IBOutlet UILabel *labelState;
    IBOutlet UILabel *labelZipcode;
    IBOutlet UILabel *labelBio;
    IBOutlet UILabel *labelStatus;
    IBOutlet UILabel *labelAvailability;
    
    IBOutlet UIImageView *photoImageView;
    
    NSMutableData *responseData;
}
@end
