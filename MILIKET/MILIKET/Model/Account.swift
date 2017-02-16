//
//  Account.swift
//  MILIKET
//
//  Created by Thành Lã on 2/16/17.
//  Copyright © 2017 Thành Lã. All rights reserved.
//

import Foundation

struct Account {
    var id: String
    var name: String
    var email: String
    var gender: String
    var timezone: String
    var friend: String
    
    func convertToRealmType() -> RealmAccount {
        return RealmAccount(account: self)
    }
    
}
