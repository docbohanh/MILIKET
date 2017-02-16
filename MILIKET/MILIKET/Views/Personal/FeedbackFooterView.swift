//
//  FeedbackFooterView.swift
//  STaxi
//
//  Created by NangND on 5/28/15.
//  Copyright (c) 2015 Hoan Pham. All rights reserved.
//

import UIKit
import PHExtensions


class FeedbackFooterView: UIView {
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
        
        buttonLeft = setupButton(LocalizedString("feedback_footer_button_customer_hot_line", comment: "Hotline"),
                                 titleColor: UIColor.Navigation.subColor(),
                                 bgColor: UIColor.whiteColor())
        buttonLeft.layer.borderWidth = onePixel()
        buttonLeft.layer.borderColor = UIColor.Navigation.subColor().CGColor
        
        buttonRight = setupButton(LocalizedString("feedback_send_feedback", comment: "Gửi góp ý"))
//        addSubview(buttonLeft)
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


extension FeedbackFooterView {
    func setupButton(title: String, titleColor: UIColor = UIColor.Text.whiteNormalColor(), bgColor: UIColor = UIColor.Navigation.mainColor()) -> UIButton {
        let button = UIButton()
        button.setTitleColor(titleColor, forState: .Normal)
        button.setTitle(title.uppercaseString, forState: .Normal)
        button.backgroundColor = bgColor
        button.titleLabel?.font = UIFont(name: FontType.LatoBold.., size: FontSize.Normal--)
        return button
    }
}













