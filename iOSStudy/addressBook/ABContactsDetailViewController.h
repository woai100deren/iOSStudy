//
//  ABContactsDetailViewController.h
//  iOSStudy
//
//  Created by dodoca on 2020/6/4.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ABContacts;

@interface ABContactsDetailViewController : UIViewController

-(void)setData:(ABContacts *)abContacts inIndex:(long)index;

@end
