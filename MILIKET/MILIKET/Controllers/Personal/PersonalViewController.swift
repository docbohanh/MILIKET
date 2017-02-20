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
    func menu(_ sender: UIBarButtonItem) {
        if let drawerController = navigationController?.parent as? KYDrawerController {
            drawerController.setDrawerState(.opened, animated: true)
        }
        
    }
    
    func didTapCloseButton(_ sender: UIButton) {
        if let drawerController = parent as? KYDrawerController {
            drawerController.setDrawerState(.closed, animated: true)
        }
    }
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
        
        view.backgroundColor = UIColor.white
        title = "Cá nhân"
        
        setupBarBtton()
        
        // Do any additional setup after loading the view.
        let closeButton    = UIButton()
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle("Close", for: UIControlState())
        closeButton.addTarget(self,
                              action: #selector(didTapCloseButton),
                              for: .touchUpInside
        )
        closeButton.sizeToFit()
        closeButton.setTitleColor(UIColor.blue, for: UIControlState())
        view.addSubview(closeButton)
        view.addConstraint(
            NSLayoutConstraint(
                item: closeButton,
                attribute: .centerX,
                relatedBy: .equal,
                toItem: view,
                attribute: .centerX,
                multiplier: 1,
                constant: 0
            )
        )
        view.addConstraint(
            NSLayoutConstraint(
                item: closeButton,
                attribute: .centerY,
                relatedBy: .equal,
                toItem: view,
                attribute: .centerY,
                multiplier: 1,
                constant: 0
            )
        )
        view.backgroundColor = UIColor.white
    }
    
    func setupAllConstraints() {
        
        
    }
    
    func setupBarBtton() {
        let leftBar = setupBarButton(image: Icon.Nav.Menu, selector: #selector(self.menu(_:)), target: self)
        navigationItem.leftBarButtonItem = leftBar
    }
    
    
}
