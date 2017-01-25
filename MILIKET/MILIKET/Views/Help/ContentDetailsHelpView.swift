//
//  ContentDetailsHelpView.swift
//  MILIKET
//
//  Created by Thành Lã on 1/25/17.
//  Copyright © 2017 Thành Lã. All rights reserved.
//

import PHExtensions
import UIKit

class ContentDetailsHelpView: UIView {
    
    fileprivate enum Size: CGFloat {
        case padding15 = 15, padding10 = 10, padding5 = 5, button = 38, label = 22, icon = 40
    }
    
    var scroll: UIScrollView!
    var imageView: UIImageView!
    var icon: UIImageView!
    var title: UILabel!
    var content: UILabel!
    
    var iconNumber: UIButton!
    
    
    //-------------------------------------------
    //MARK: INIT SETUP
    //-------------------------------------------
    
    
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
        
        imageView.frame = CGRect(x: Size.padding15..,
                                 y: Size.padding5..,
                                 width: bounds.width - Size.padding15.. * 2,
                                 height: bounds.height / 2 + 30)
        
        scroll.frame = CGRect(x: 0, y: imageView.frame.maxY,
                              width: bounds.width,
                              height: bounds.height - imageView.frame.maxY )
        
        icon.frame = CGRect(x: Size.padding15..,
                            y: Size.padding15..,
                            width: Size.icon..,
                            height: Size.icon..)
        
        iconNumber.frame = CGRect(x: Size.padding15..,
                                  y: Size.padding15..,
                                  width: Size.icon..,
                                  height: Size.icon..)
        
        
        title.frame = CGRect(x: iconNumber.frame.maxX + Size.padding10.. ,
                             y: Size.padding15.. - 5 ,
                             width: bounds.width - iconNumber.frame.maxX - Size.padding15.. * 2,
                             height: Size.icon.. + 10)
        
        var height = bounds.height - Size.padding15.. - (title.frame.maxY + Size.padding15..)
        if let text = content.text {
            height = Utility.shared.heightForView(text: text, font: content.font, width: bounds.width - Size.padding15.. * 2)
        }
        
        content.frame = CGRect(x: Size.padding15..,
                               y: title.frame.maxY + Size.padding15..,
                               width: bounds.width - Size.padding15.. * 2,
                               height: height)
        
        scroll.contentSize = CGSize(width: bounds.width , height: content.frame.maxY )
    }
}


extension ContentDetailsHelpView {
    func setup() {
        
        setupImageView()
        setupScrollView()
        setupIcon()
        setupTitle()
        setupContent()
    }
    
    fileprivate func setupImageView() {
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
    }
    
    fileprivate func setupScrollView() {
        scroll = UIScrollView()
        addSubview(scroll)
    }
    
    fileprivate func setupIcon() {
        icon = UIImageView()
        icon.contentMode = .center
        icon.layer.cornerRadius = 5
        icon.backgroundColor = UIColor.Text.fromAddress
        //        scroll.addSubview(icon)
        
        iconNumber = UIButton()
        //        iconNumber.backgroundColor = UIColor.Text.fromAddressColor()
        iconNumber.layer.cornerRadius = Size.icon.. / 2
        //        iconNumber.setTitleColor(UIColor.Text.whiteNormalColor(), forState: .Normal)
        iconNumber.titleLabel?.font = UIFont(name: FontType.latoBold.., size: FontSize.large..)
        
        
        iconNumber.setTitleColor(UIColor.Navigation.main, for: UIControlState())
        iconNumber.backgroundColor = UIColor.white
        iconNumber.layer.backgroundColor = UIColor.Navigation.main.cgColor
        iconNumber.layer.borderWidth = onePixel()
        
        scroll.addSubview(iconNumber)
    }
    
    fileprivate func setupTitle() {
        title = UILabel()
        title.font = UIFont(name: FontType.latoBold.., size: FontSize.large..)
        title.textAlignment = .left
        title.numberOfLines = 2
        title.lineBreakMode = .byWordWrapping
        title.textColor = UIColor.Text.blackMedium
        scroll.addSubview(title)
    }
    
    fileprivate func setupContent() {
        content = UILabel()
        content.font = UIFont(name: FontType.latoRegular.., size: FontSize.normal--)
        content.textAlignment = .justified
        content.textColor = UIColor.Text.grayMedium
        content.numberOfLines = 0
        content.lineBreakMode = .byWordWrapping
        scroll.addSubview(content)
    }
    
    
}
