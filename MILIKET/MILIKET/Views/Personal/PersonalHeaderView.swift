//
//  PersonalHeaderView.swift
//  NguoiBA
//
//  Created by Nguyen Duc Nang on 5/18/16.
//  Copyright © 2016 Nguyen Duc Nang. All rights reserved.
//

import UIKit
import PHExtensions

class PersonalHeaderView: UIView {
    
    fileprivate enum Size: CGFloat {
        case Padding3 = 5, Padding15 = 15, Padding10 = 10, Avatar = 100, Label = 40
    }
    
    fileprivate var shadowAvatar: UIView!
    var avatar: UIImageView!
    var name: UILabel!
    var date: UILabel!
    

    
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
        
        shadowAvatar.frame = CGRect(x: (bounds.width - Size.Avatar.. ) / 2, y: Size.Padding10.., width: Size.Avatar.., height: Size.Avatar..)
//        shadowAvatar.center = CGPoint(x: bounds.width / 2, y: (bounds.height - Size.Label.. ) / 2 )
        shadowAvatar.layer.cornerRadius = Size.Avatar..  / 2
        
        avatar.frame = CGRect(x: 0, y: 0, width: Size.Avatar.. - Size.Padding3.. * 2, height: Size.Avatar.. - Size.Padding3.. * 2)
        avatar.center = CGPoint(x: shadowAvatar.frame.width / 2, y: shadowAvatar.frame.height / 2 )
        avatar.layer.cornerRadius = (Size.Avatar.. - Size.Padding3.. * 2 ) / 2
        
        name.frame = CGRect(x: Size.Padding15..,
                            y: shadowAvatar.frame.maxY + Size.Padding10.. / 2,
                            width: bounds.width - Size.Padding15.. * 2,
                            height: Size.Label..)
        
        date.frame = CGRect(x: Size.Padding15..,
                            y: name.frame.maxY ,
                            width: bounds.width - Size.Padding15.. * 2,
                            height: Size.Label.. / 2)
    }
}

extension PersonalHeaderView {
    fileprivate func setup() {
        
        name = setupLabel()
        date = setupLabel(UIColor.gray, font: UIFont(name: FontType.latoRegular.., size: FontSize.normal--)!)
        
        avatar = setupAvatar()
        shadowAvatar = setupShadowAvatar()
        
        
        shadowAvatar.addSubview(avatar)
        addSubview(shadowAvatar)
        addSubview(name)
        addSubview(date)

    }
    
    
    fileprivate func setupAvatar() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
    
    fileprivate func setupShadowAvatar() -> UIView {
        
        let view = UIView()
        view.clipsToBounds = true
        
        view.backgroundColor = UIColor.white.alpha(0.85)
        view.layer.shadowColor = UIColor.black.alpha(0.6).cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 4.0
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view.clipsToBounds = false
        
        view.layer.borderWidth = onePixel()
        view.layer.borderColor = UIColor.main.cgColor
        return view
    }
    
    fileprivate func setupLabel(_ textColor: UIColor = UIColor.darkGray, font: UIFont = UIFont(name: FontType.latoLight.., size: FontSize.large++)!) -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = textColor
        label.font = font
        return label
    }
    
    func viewHeight() -> CGFloat {
        return Size.Padding10.. + Size.Avatar.. + Size.Padding10.. / 2 + Size.Label.. + Size.Label.. / 2 + Size.Padding10..
    }
}
