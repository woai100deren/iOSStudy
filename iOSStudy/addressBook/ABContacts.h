//
//  ABContacts.h
//  iOSStudy
//
//  Created by dodoca on 2020/6/3.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABContacts : NSObject
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *phone;

+(instancetype)contactsWithName:(NSString *)name AndPhone:(NSString *)phone;
@end
