//
//  PersonalFooterView.swift
//  NguoiBA
//
//  Created by Nguyen Duc Nang on 9/11/16.
//  Copyright © 2016 Nguyen Duc Nang. All rights reserved.
//

import UIKit
import PHExtensions

class PersonalFooterView: UIView {
    
    fileprivate enum Size: CGFloat {
        case Padding10 = 10, Button = 44
    }
    
    fileprivate var dataArray: [(title: String, image: UIImage, tag: Int, tintColor: UIColor)] = [
        ("Đổi mật khẩu", Icon.Personal.ChangedPassword, 0, UIColor.main),
                                                                                              //                                                                ("Gửi góp ý", Icon.Personal.Feedback, 1, UIColor.Navigation.mainColor()),
        ("Đăng xuất", Icon.Personal.Logout, 1, UIColor.orange)
    ]
    
    var contentView: UIView!
    var arrayButton: [ButtonItem] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAllSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupAllSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = CGRect(x: Size.Padding10..,
                                   y: 0,
                                   width: bounds.width - Size.Padding10.. * 2,
                                   height: bounds.height)
        
        for (index, button) in arrayButton.enumerated() {
            button.frame = CGRect(x: contentView.frame.width / CGFloat(arrayButton.count) * CGFloat(index),
                                  y: 0,
                                  width: contentView.frame.width / CGFloat(arrayButton.count),
                                  height: contentView.frame.height - Size.Padding10..)
        }
    }
    
    
}


extension PersonalFooterView {
    

    func setupAllSubviews() {
        
        contentView = setupView()
        addSubview(contentView)
        
        arrayButton = dataArray.map {
            self.setupButtonItem($0.title, image: $0.image, tag: $0.tag, tintColor: $0.tintColor)
        }
        arrayButton.forEach { contentView.addSubview($0) }
    }
    
    func setupView(bgColor: UIColor =
        .clear) -> UIView {
        let view = UIView()
        view.backgroundColor = bgColor
        return view
    }
    
    func setupButtonItem(_ title: String, image: UIImage, tag: Int, tintColor: UIColor) -> ButtonItem {
        let button = ButtonItem()
        button.button.setTitle(title, for: .normal)
        button.button.setImage(image.tint(tintColor), for: .normal)
        button.button.layer.borderColor = tintColor.cgColor
        button.button.setTitleColor(tintColor, for: .normal)
        button.tag = tag
        return button
    }
    
//    func setupButtonItem(title: String, image: UIImage, tag: Int) -> ButtonItem {
//        let button = ButtonItem()
//        button.label.text = title
//        button.button.setImage(image.tint(UIColor.Navigation.mainColor()), forState: .Normal)
//        button.tag = tag
//        return button
//    }
}

class ButtonItem: UIView {
    
    var button: UIButton!

    
    private enum Size: CGFloat {
        case Padding10 = 10, Button = 44
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAllSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupAllSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        button.frame = CGRect(x: Size.Padding10.. / 2,
                              y: 0,
                              width: bounds.width - Size.Padding10..,
                              height: Size.Button..)
    }
    
    
    
    
    
    func setupAllSubviews() {
        button = setupButton()

        
        addSubview(button)

    }
    
    
    func setupButton() -> UIButton {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.borderWidth = onePixel()
        button.titleLabel?.font = UIFont(name: FontType.latoSemibold.., size: FontSize.normal--)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
//        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        return button
    }
}


/*

class ButtonItem: UIView {
    
    var button: UIButton!
    var label: UILabel!
    
    private enum Size: CGFloat {
        case Padding10 = 10, Button = 50
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAllSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupAllSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        button.frame = CGRect(x: (bounds.width - Size.Button.. ) / 2,
                              y: 0, width: Size.Button.., height: Size.Button..)
        button.layer.cornerRadius = Size.Button.. / 2
        
        
        label.frame = CGRect(x: Size.Padding10.. / 2,
                             y: button.frame.maxY,
                             width: bounds.width - Size.Padding10..,
                             height: bounds.height - button.frame.maxY)
    }
    
    

    
    
    func setupAllSubviews() {
        button = setupButton()
        label = setupLabel()
        
        addSubview(button)
        addSubview(label)
    }
    
    
    func setupButton() -> UIButton {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.borderColor = UIColor.Navigation.mainColor().CGColor
        button.layer.borderWidth = onePixel()
        return button
    }
    
    func setupLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .Center
        label.numberOfLines = 0
        label.lineBreakMode = .ByWordWrapping
        label.textColor = UIColor.Text.blackMediumColor()
        label.font = UIFont(name: FontType.LatoSemibold.., size: FontSize.Normal--)
        return label
    }
}
*/
