//
//  NewsViewController.swift
//  MILIKET
//
//  Created by MILIKET on 2/20/17.
//  Copyright © 2017 Thành Lã. All rights reserved.
//

import UIKit
import SnapKit
import PHExtensions

class NewsViewController: GeneralViewController {
    fileprivate enum Size: CGFloat {
        case padding15 = 15, padding5 = 5, padding10 = 10, button = 44
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAllSubviews()
        view.setNeedsUpdateConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            setupAllConstraints()
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
}

//------------------------------
//MARK: SELECTOR
//------------------------------
extension NewsViewController {
    
}

//------------------------------
//MARK: PRIVATE METHOD
//------------------------------
extension NewsViewController {
    
}

//------------------------------
//MARK: SETUP VIEW
//------------------------------
extension NewsViewController {
    func setupAllSubviews() {
        view.backgroundColor = .white
    }
    
    func setupAllConstraints() {
        
    }
}

