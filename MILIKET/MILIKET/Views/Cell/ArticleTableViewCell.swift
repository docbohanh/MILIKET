//
//  ArticleTableViewCell.swift
//  MILIKET
//
//  Created by MILIKET on 1/29/17.
//  Copyright © 2017 Thành Lã. All rights reserved.
//
import UIKit
import PHExtensions

class ArticleTableViewCell: UITableViewCell {
    
    enum Size: CGFloat {
        case Padding15 = 15, Padding10 = 10, Label = 20, Image = 60
    }
    
    var seperator: UIView!
    var labelTime: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    override func layoutSubviews() {
        
        contentView.frame = bounds
        
        imageView?.frame = CGRect(x: Size.Padding10.. / 2,
                                  y: Size.Padding10.. / 2,
                                  width: bounds.height  + Size.Padding10.. * 2,
                                  height: bounds.height - Size.Padding10..)
        
        guard let imageView = imageView else { return }
        
        
        textLabel?.frame = CGRect(x: imageView.frame.maxX + Size.Padding10..,
                                  y: Size.Padding10.. / 4,
                                  width: contentView.frame.width - Size.Padding10.. - (imageView.frame.maxX + Size.Padding10..),
                                  height: contentView.frame.height / 2 )
        
        labelTime.frame =  CGRect(x: imageView.frame.maxX + Size.Padding10..,
                                  y: contentView.frame.height  - Size.Label.. - Size.Padding10.. / 4,
                                  width: contentView.frame.width - Size.Padding10.. - (imageView.frame.maxX + Size.Padding10..),
                                  height: Size.Label..)
        
        detailTextLabel?.frame = CGRect(x: imageView.frame.maxX + Size.Padding10..,
                                        y: contentView.frame.height / 2 + Size.Padding10.. / 4,
                                        width: contentView.frame.width - Size.Padding10.. - (imageView.frame.maxX + Size.Padding10..),
                                        height: labelTime.frame.minY - contentView.frame.height / 2 - Size.Padding10.. / 4)
        
        seperator.frame = CGRect(x: imageView.frame.maxX + Size.Padding10..,
                                 y: contentView.frame.height - onePixel(),
                                 width: contentView.frame.width - Size.Padding10.. - (imageView.frame.maxX + Size.Padding10..),
                                 height: onePixel())
        
    }
    
}

extension ArticleTableViewCell {
    
    func setup() {
        setupImageView()
        setupTitle()
        
        labelTime = setupLabel()
        seperator = setupView()
        
        contentView.addSubview(labelTime)
        contentView.addSubview(seperator)
    }
    
    func setupView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }
    
    func setupImageView() {
        
        imageView?.contentMode = .scaleAspectFill
        imageView?.backgroundColor = UIColor.clear
        imageView?.clipsToBounds = true
        
    }
    
    func setupTitle() {
        
        textLabel?.textAlignment = .left
        textLabel?.font = UIFont(name: FontType.latoBold.., size: FontSize.normal..)
        textLabel?.numberOfLines = 2
        textLabel?.textColor = UIColor.Text.blackMedium
        textLabel?.backgroundColor = UIColor.clear
        
        detailTextLabel?.textAlignment = .left
        detailTextLabel?.font = UIFont(name: FontType.latoRegular.., size: FontSize.normal--)
        detailTextLabel?.numberOfLines = 1
        detailTextLabel?.textColor = UIColor.Text.grayMedium
        detailTextLabel?.backgroundColor = UIColor.clear
    }
    
    func setupLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont(name: FontType.latoRegular.., size: FontSize.small..)
        label.numberOfLines = 1
        label.textColor = UIColor.Text.grayMedium
        label.backgroundColor = UIColor.clear
        return label
    }
}

