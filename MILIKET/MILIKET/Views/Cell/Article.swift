//
//  Article.swift
//  MILIKET
//
//  Created by MILIKET on 1/29/17.
//  Copyright © 2017 Thành Lã. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

class Article: Object {
    
    dynamic var ID          : Int = 0
    dynamic var image       : String = ""
    dynamic var time        : Double = 0
    dynamic var title       : String = ""
    dynamic var contentShort: String = ""
    dynamic var isLike      : Bool = true
    dynamic var isComment   : Bool = true
    dynamic var articleImg  : String = ""
    dynamic var order       : Int = 0
    dynamic var queryType   : Int = 0
    dynamic var version     : Int = 0
    
    var url: String {
        return Domain + "/Blog/MDetail/" + ID.toString(0) + "?v=\(version)"
    }
    
    convenience init(ID: Int, image: String, time: Double, title: String, contentShort: String, isLike: Bool, isComment: Bool, articleImg: String, order: Int, queryType: Int = 0, version: Int) {
        self.init()
        self.ID                 = ID
        self.image              = image
        self.time               = time
        self.title              = title
        self.contentShort       = contentShort
        self.isLike             = isLike
        self.isComment          = isComment
        self.articleImg         = articleImg
        self.order              = order
        self.queryType          = queryType
        self.version            = version
    }
    
    override static func primaryKey() -> String? {
        return "ID"
    }
}

