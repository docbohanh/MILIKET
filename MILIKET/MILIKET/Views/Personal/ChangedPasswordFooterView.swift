//
//  ChangedPasswordFooterView.swift
//  NguoiBA
//
//  Created by Nguyen Duc Nang on 6/28/16.
//  Copyright © 2016 Nguyen Duc Nang. All rights reserved.
//

import UIKit
import PHExtensions

class ChangedPasswordFooterView: UIView {
    private enum Size: CGFloat {
        case Padding7 = 7, Padding10 = 10, Padding5 = 5, Padding15 = 15, Button = 44, Label = 25
    }
    // buttonRight
    var buttonRight: UIButton!
    
    // buttonLeft
    var buttonLeft: UIButton!
    
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
        
        buttonLeft = setupButton("Bỏ qua", titleColor: UIColor.orange)
        
        buttonRight = setupButton("Đổi mật khẩu")
        
        addSubview(buttonLeft)
        addSubview(buttonRight)
        
    }
    
    // Set Frame
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        buttonLeft.frame =  CGRect(x: Size.Padding15..,
                                   y: bounds.height - Size.Padding7.. - Size.Button..,
                                   width: bounds.width / 2  - Size.Padding15..  - Size.Padding7.. / 2,
                                   height: Size.Button..)
        
        buttonRight.frame =  CGRect(x: bounds.width / 2 + Size.Padding7.. / 2 ,
                                    y: bounds.height - Size.Padding7.. - Size.Button..,
                                    width: bounds.width / 2  - Size.Padding15..  - Size.Padding7.. / 2,
                                    height: Size.Button..)
    }
    
}


extension ChangedPasswordFooterView {
    
    fileprivate func setupButton(_ title: String, titleColor: UIColor = UIColor.main) -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.titleLabel?.font = UIFont(name: FontType.latoBold.., size: FontSize.normal--)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        button.setTitle(title.uppercased(), for: .normal)
        button.layer.borderColor = titleColor.cgColor
        button.layer.borderWidth = onePixel()
        button.setTitleColor(titleColor, for: .normal)
        return button
    }
}
