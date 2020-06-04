//
//  ABContacts.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/3.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "ABContacts.h"
#import "NSString+Extensions.h"

@implementation ABContacts
+(instancetype)contactsWithName:(NSString *)name AndPhone:(NSString *)phone{
    ABContacts *contacts = [[ABContacts alloc]init];
    contacts.name = name;
    contacts.phone = phone;
    return contacts;
}
- (NSString *)index{
    if(!_index){
        _index = [NSString getFirstLetterFromString:_name];
    }
    return _index;
}
@end
