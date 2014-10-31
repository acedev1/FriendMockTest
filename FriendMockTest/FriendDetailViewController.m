//
//  FriendDetailViewController.m
//  FriendMockTest
//
//  Created by AnMac on 10/31/14.
//  Copyright (c) 2014 Petr. All rights reserved.
//

#import "FriendDetailViewController.h"
#import "ActivityIndicator.h"

#import "JSON.h"
#import "UIImageView+AFNetworking.h"

@interface FriendDetailViewController ()

@end

@implementation FriendDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[ActivityIndicator currentIndicator] show];
    responseData = [[NSMutableData alloc] init];
    
    NSURL *apiurl = [NSURL URLWithString:@"http://private-5bdb3-friendmock.apiary-mock.com/friends/id"];
    [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:apiurl] delegate:self];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    
    NSDictionary *arr = [[SBJsonParser new] objectWithString:responseString];
    
    NSString* imageUrl = [arr objectForKey:@"img"];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:imageUrl]];
    [req addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    
    [photoImageView setImageWithURLRequest:req placeholderImage:nil
                                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       } failure:nil];
    
    NSString *firstName = [arr objectForKey: @"first_name"];
    NSString *lastName = [arr objectForKey: @"last_name"];
    labelName.text = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    labelNumber.text = [arr objectForKey: @"phone"];
    labelAddress.text = [arr objectForKey: @"address_1"];
    labelCity.text = [arr objectForKey: @"city"];
    labelState.text = [arr objectForKey: @"state"];
    labelZipcode.text = [arr objectForKey: @"zipcode"];
    labelBio.text = [arr objectForKey: @"bio"];
    NSNumber *isAvailable = [arr objectForKey:@"available"];
    if([isAvailable boolValue])
        labelAvailability.text = @"Available";
    else
        labelAvailability.text = @"Not Available";
}
@end
