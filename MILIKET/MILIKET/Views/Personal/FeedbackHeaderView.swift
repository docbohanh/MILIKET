//
//  FeedbackHeaderView.swift
//  STaxi
//
//  Created by NangND on 5/28/15.
//  Copyright (c) 2015 Hoan Pham. All rights reserved.
//

import UIKit
import PHExtensions

class FeedbackHeaderView: UIView {
    private enum Size: CGFloat {
        case Padding15 = 15, Padding5 = 5
    }
    
    var label: UILabel = {
       var label = UILabel()
        label.textAlignment = .Left
        label.textColor = UIColor.Text.blackMediumColor()
        label.font = UIFont(name: FontType.LatoLight.., size: FontSize.Large--)
        label.numberOfLines = 0
        label.lineBreakMode = .ByWordWrapping
        return label
    }()
    // Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // Setup addSubview
    private func setup() {
        addSubview(label)
    }
    
    // Set Frame
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = CGRect(x: Size.Padding15..,
            y:  Size.Padding5..,
            width: bounds.width - Size.Padding15.. * 2,
            height: bounds.height - Size.Padding5.. * 2 )

    }
 
}
