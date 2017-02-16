//
//  PersonalViewController.swift
//  MILIKET
//
//  Created by Thành Lã on 2/16/17.
//  Copyright © 2017 Thành Lã. All rights reserved.
//

import UIKit
import SnapKit
import PHExtensions

class PersonalViewController: GeneralViewController {
    enum Size: CGFloat {
        case padding = 15, button = 44, cell = 54, padding10 = 10
    }
    
    //-------------------------------------
    // MARK: - CYCLE LIFE
    //-------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAllSubviews()
        view.setNeedsUpdateConstraints()
    }
    
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            setupAllConstraints()
            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}


//-------------------------------------
// MARK: - SELECTOR
//-------------------------------------
extension PersonalViewController {
    
}

//-------------------------------------
// MARK: - PRIVATE METHOD
//-------------------------------------
extension PersonalViewController {
    
}


//-------------------------------------
// MARK: - SETUP
//-------------------------------------
extension PersonalViewController {
    func setupAllSubviews() {
        
        
    }
    
    func setupAllConstraints() {
        
        
    }
    
    
    
}
