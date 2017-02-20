//
//  SideBarHeaderView.swift
//  MILIKET
//
//  Created by Thành Lã on 2/20/17.
//  Copyright © 2017 Thành Lã. All rights reserved.
//

import UIKit
import PHExtensions

class SideBarHeaderView: UIView {
    
    enum Size: CGFloat {
        case Padding3 = 5, Padding15 = 15, Padding10 = 10, Logo = 100, Label = 40
    }
    
    var logo: UIImageView!
    var name: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
}

extension SideBarHeaderView {
    func setup() {
        
        backgroundColor = .main
        
        name = setupLabel()
        logo = setupLogo()
        
        addSubview(logo)
        addSubview(name)
        
    }
    
    
    func setupLogo() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
    
    
    private func setupLabel(textColor: UIColor = UIColor.darkGray, font: UIFont = UIFont(name: FontType.latoSemibold.., size: FontSize.normal++)!) -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = textColor
        label.font = font
        return label
    }
    
    func viewHeight() -> CGFloat {
        return Size.Padding10.. * 2 + Size.Logo.. + Size.Label.. + Size.Padding10..
    }
}

