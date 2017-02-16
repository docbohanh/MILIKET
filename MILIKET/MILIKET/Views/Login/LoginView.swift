//
//  LoginView.swift
//  BAPM
//
//  Created by Thành Lã on 12/23/16.
//  Copyright © 2016 Hoan Pham. All rights reserved.
//

import UIKit
import PHExtensions

class LoginView: UIView {
    
    private enum Size: CGFloat {
        case padding10 = 10, padding5 = 5, padding15 = 15, button = 44, textField = 40
    }
    
    var userName: CustomTextField!
    var password: CustomTextField!
    var remember: UIButton!
    var login: UIButton!
    
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
        
        userName.frame = CGRect(x: Size.padding10..,
                                y: Size.padding10..,
                                width: bounds.width - Size.padding10.. * 2,
                                height: Size.textField..)
        
        password.frame = CGRect(x: Size.padding10..,
                                y: userName.frame.maxY + Size.padding5..,
                                width: bounds.width - Size.padding10.. * 2,
                                height: Size.textField..)
        
        login.frame = CGRect(x: Size.padding10..,
                             y: bounds.height - Size.button.. - Size.padding10..,
                             width: bounds.width - Size.padding10.. * 2,
                             height: Size.button..)
        
        remember.frame = CGRect(x: Size.padding10..,
                                y: login.frame.minY - Size.button.. - Size.padding5.. / 2,
                                width: bounds.width - Size.padding10.. * 2,
                                height: Size.button..)
    }
    
    
    ///
    private func setup() {
        userName = setupTextField(placeholder: "Tên đăng nhập", icon: Icon.Login.Person.tint(.gray))
        password = setupTextField(placeholder: "Mật khẩu", icon: Icon.Login.Key.tint(.gray), securityTextEntry: true)
        login    = setupButtonLogin(title: "Đăng nhập")
        remember = setupButtonRemember(title: "Ghi nhớ đăng nhập")
        
        addSubview(userName)
        addSubview(password)
        addSubview(login)
        addSubview(remember)
    }
    
    private func setupTextField(placeholder: String, icon: UIImage, securityTextEntry: Bool = false) -> CustomTextField {
        let textField = CustomTextField()
        textField.icon.image = icon
        textField.floatingPlaceholderEnabled = true
        textField.placeholder = placeholder
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = securityTextEntry
        textField.clearButtonMode = .whileEditing
        textField.font = UIFont(name: FontType.latoRegular.., size: FontSize.normal++)
        textField.textColor = .darkGray
        
        
        if securityTextEntry {
            textField.returnKeyType = .done
        } else {
            textField.returnKeyType = .next
        }
        
        return textField
    }
    
    private func setupButtonRemember(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        button.titleLabel?.font = UIFont(name: FontType.latoSemibold.., size: FontSize.normal..)
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 13, bottom: 0, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
        button.setImage(Icon.Login.UncheckBox, for: .normal)
        button.setImage(Icon.Login.CheckBox.tint(.main), for: .selected)
        return button
    }
    
    private func setupButtonLogin(title: String, titleColor: UIColor = .white, bgColor: UIColor = .orange) -> UIButton {
        let button = UIButton()
        button.setTitle(title.uppercased(), for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = UIFont(name: FontType.latoBold.., size: FontSize.normal++)
        button.layer.cornerRadius = 3
        button.backgroundColor = .main
        return button
    }
    
    
}
