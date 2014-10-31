//
//  ViewController.h
//  FriendMockTest
//
//  Created by AnMac on 10/31/14.
//  Copyright (c) 2014 Petr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <NSURLConnectionDataDelegate, NSURLConnectionDelegate, UITableViewDataSource, UITableViewDelegate> {
    NSMutableData *responseData;
    NSMutableArray *friendsList;
    
    IBOutlet UITableView *friendsTable;
}


@end

