//
//  FriendItem.h
//  FriendMockTest
//
//  Created by AnMac on 10/31/14.
//  Copyright (c) 2014 Petr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendItem : NSObject

@property (nonatomic, copy) NSString *friendId;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *status;
@property (nonatomic) BOOL isAvailable;

@end
