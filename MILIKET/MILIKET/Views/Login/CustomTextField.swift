//
//  CustomTextField.swift
//  BAPM
//
//  Created by Thành Lã on 12/23/16.
//  Copyright © 2016 Hoan Pham. All rights reserved.
//

import UIKit

class CustomTextField: MKTextField {
    
    private var seperator: UIView!
    var icon: UIImageView!
    
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
        seperator.frame = CGRect(x: 0, y: bounds.height - 3,
                                 width: bounds.width,
                                 height: 1 / UIScreen.main.scale)
        
        icon.frame = CGRect(x: 0, y: 5, width: 30, height: 30)
    }
    
    private func setup() {
        icon = setupIcon()
        seperator = setupSeperator()
        
        addSubview(icon)
        addSubview(seperator)
        
        clearButtonMode = .whileEditing
        autocorrectionType = .no
        autocapitalizationType = .none
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: bounds.width + 35, height: bounds.height).insetBy(dx: 35, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: bounds.width + 15, height: bounds.height).insetBy(dx: 35, dy: 0)
    }
    
    private func setupSeperator() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        return view
    }
    
    private func setupIcon() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .center
        return imageView
    }
}
