//
//  RealmAccount.swift
//  MILIKET
//
//  Created by Thành Lã on 2/16/17.
//  Copyright © 2017 Thành Lã. All rights reserved.
//

import RealmSwift
import UIKit

//["fields":"id,interested_in,gender,birthday,email,age_range,name,picture.width(480).height(480)"])
//email,id,name,gender,timezone,friends

class RealmAccount: Object {
    dynamic var id: String = ""
    dynamic var name: String = ""
    dynamic var email: String = ""
    dynamic var gender: String = ""
    dynamic var timezone: String = ""
    dynamic var friend: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(account: Account) {
        self.init()
        self.id = account.id
        self.name = account.name
        self.email = account.email
        self.gender = account.gender
        self.timezone = account.timezone
        self.friend = account.friend
    }
}

extension RealmAccount {
    func convertToSyncType() -> Account {
        return Account(id: self.id,
                       name: self.name,
                       email: self.email,
                       gender: self.gender,
                       timezone: self.timezone,
                       friend: self.friend)
    }
}
