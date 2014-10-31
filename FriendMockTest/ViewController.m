//
//  ViewController.m
//  FriendMockTest
//
//  Created by AnMac on 10/31/14.
//  Copyright (c) 2014 Petr. All rights reserved.
//

#import "ViewController.h"
#import "ActivityIndicator.h"
#import "FriendTableViewCell.h"

#import "JSON.h"
#import "FriendItem.h"
#import "UIImageView+AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // loading friends...
    friendsList = [[NSMutableArray alloc] init];
    [[ActivityIndicator currentIndicator] show];
    responseData = [[NSMutableData alloc] init];
    
    NSURL *apiurl = [NSURL URLWithString:@"http://private-5bdb3-friendmock.apiary-mock.com/friends"];
    [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:apiurl] delegate:self];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [friendsList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 92;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendTableViewCell *cell = (FriendTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"FriendCell"];
    if (cell == nil) {
        cell = [[FriendTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FriendCell"];
    }
    
    FriendItem *item = [friendsList objectAtIndex:indexPath.row];
    
    cell.fullNameLabel.text = [NSString stringWithFormat:@"%@ %@", item.firstName, item.lastName];
    cell.statusLabel.text = item.status;
    [cell.availableSwitch setOn: item.isAvailable];
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:item.imageUrl]];
    [req addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    
    [cell.logoImageView setImageWithURLRequest:req placeholderImage:nil
                                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       } failure:nil];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark Connection Delegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return YES;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [[ActivityIndicator currentIndicator] hide];
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Cannot connect to server!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [[ActivityIndicator currentIndicator] hide];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    //    NSLog(@"%@", responseString);
    
    NSArray *arr = [[SBJsonParser new] objectWithString:responseString];
    for (int i=0; i<[arr count]; i++) {
        NSDictionary *item = [arr objectAtIndex:i];
        
        FriendItem *friendItem = [[FriendItem alloc] init];
        friendItem.friendId = [item objectForKey:@"id"];
        friendItem.imageUrl = [item objectForKey:@"img"];
        friendItem.firstName = [item objectForKey:@"first_name"];
        friendItem.lastName = [item objectForKey:@"last_name"];
        friendItem.status = [item objectForKey:@"status"];
        
        NSNumber *isAvailable = [item objectForKey:@"available"];
            friendItem.isAvailable = [isAvailable boolValue];
        
        
        
        [friendsList addObject:friendItem];
    }
    
    [friendsTable reloadData];
    
    
}

@end
