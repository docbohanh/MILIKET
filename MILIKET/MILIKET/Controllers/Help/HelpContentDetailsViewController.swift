//
//  HelpContentDetailsViewController.swift
//  MILIKET
//
//  Created by Thành Lã on 1/25/17.
//  Copyright © 2017 Thành Lã. All rights reserved.
//

import UIKit

private enum Size: CGFloat {
    case padding15 = 15.0, button = 40.0, padding20 = 20, padding10 = 10
}

class HelpContentDetailsViewController: GeneralViewController {
    
    var contentView: ContentDetailsHelpView!
    
    var data: (image: String, title: String, content: String)?
    
    var pageIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAllSubviews()
        view.setNeedsUpdateConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func updateViewConstraints() {
        if !didSetupConstraints {
            setupAllConstraints()
            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
}

extension HelpContentDetailsViewController {
    fileprivate func setupAllSubviews() {
        
        view.backgroundColor = .clear
        
        contentView = setupContentView()
        view.addSubview(contentView)
        
        if let data = data {
            contentView.imageView.image = UIImage(named: data.image)
            contentView.title.text = data.title
            
            contentView.content.text = data.content
            contentView.iconNumber.setTitle("\(pageIndex + 1)", for: UIControlState())
            contentView.layoutSubviews()
            
            
            contentView.iconNumber.backgroundColor = UIColor.white
            contentView.iconNumber.layer.borderColor = UIColor.Navigation.main.cgColor
        }
    }
    
    func setupAllConstraints() {
        contentView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(view)
            make.top.equalTo(view.snp.top).inset(20)
        }
    }
    
    func setupContentView() -> ContentDetailsHelpView {
        let view = ContentDetailsHelpView()
        view.backgroundColor = .white
        return view
    }
    
}







