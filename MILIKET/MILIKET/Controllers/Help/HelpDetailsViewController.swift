//
//  HelpDetailsViewController.swift
//  MILIKET
//
//  Created by Thành Lã on 1/25/17.
//  Copyright © 2017 Thành Lã. All rights reserved.
//

import UIKit
import SnapKit
import PHExtensions

//-------------------------------------------
//MARK: - PROTOCOL
//-------------------------------------------
protocol HelpDetailsControllerDelegate: class {
    func helpDetailsControllerDidFinished()
}

class HelpDetailsViewController: GeneralViewController {
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
extension HelpDetailsViewController {
    
}

//-------------------------------------
// MARK: - PRIVATE METHOD
//-------------------------------------
extension HelpDetailsViewController {
    
}

//-------------------------------------
// MARK: - <#Delegate#> DELEGATE
//-------------------------------------
extension HelpDetailsViewController {
    
}

//-------------------------------------
// MARK: - SETUP
//-------------------------------------
extension HelpDetailsViewController {
    func setupAllSubviews() {
        
        
    }
    
    func setupAllConstraints() {
        
        
    }
    
    
    
}
