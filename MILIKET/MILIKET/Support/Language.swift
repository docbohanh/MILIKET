//
//  Language.swift
//  MILIKET
//
//  Created by Thành Lã on 1/25/17.
//  Copyright © 2017 Thành Lã. All rights reserved.
//

import Foundation

func LocalizedString(_ key: String, comment: String? = nil) -> String {
    return Language.instance.localizedStringForKey(key)
}

class Language {
    static let instance = Language()
    var bundle = Bundle.main
    
    func localizedStringForKey(_ key: String, comment: String? = nil) -> String {
        return bundle.localizedString(forKey: key, value: comment, table: nil)
    }
    
    func setLanguage(_ language: String) {
        let path = Bundle.main.path(forResource: language, ofType: "lproj")
        
        if let path = path {
            if let newBundle = Bundle(path: path) {
                bundle = newBundle
            } else {
                bundle = Bundle.main
            }
        } else {
            bundle = Bundle.main
        }
    }
    
    func setLanguage(_ language: LanguageValue) {
        var lang: String
        switch language {
        case .vietnamese:
            lang = "vi"
        case .english:
            lang = "en"
        }
        setLanguage(lang)
    }
}
