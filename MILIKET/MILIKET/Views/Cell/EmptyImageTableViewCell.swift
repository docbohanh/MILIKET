//
//  EmptyImageTableViewCell.swift
//  MILIKET
//
//  Created by Thành Lã on 2/20/17.
//  Copyright © 2017 Thành Lã. All rights reserved.
//

import UIKit
class EmptyImageTableViewCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupImage()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupImage()
    }
    
    func setupImage() {
        imageView?.contentMode = .scaleAspectFit
        backgroundColor =  UIColor.groupTableViewBackground
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame = CGRect(x: bounds.width / 4,
                                  y: 0,
                                  width: bounds.width / 2,
                                  height: bounds.height * 4 / 5)
    }
}

