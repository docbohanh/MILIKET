//
//  NoteViewController.swift
//  MILIKET
//
//  Created by MILIKET on 1/28/17.
//  Copyright © 2017 Thành Lã. All rights reserved.
//

import UIKit
import SnapKit
import PHExtensions
class NoteViewController: UIViewController {
    fileprivate enum Size: CGFloat {
        case padding15 = 15, padding5 = 5, padding10 = 10, button = 44
    }
    var didSetupContraints = false
    
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
        if !didSetupContraints {
            setupAllConstraints()
            didSetupContraints = true
        }
        
        super.updateViewConstraints()
    }
    
}

//------------------------------
//MARK: SELECTOR
//------------------------------
extension NoteViewController {
    
}

//------------------------------
//MARK: PRIVATE METHOD
//------------------------------
extension NoteViewController {
    
}

//------------------------------
//MARK: SETUP VIEW
//------------------------------
extension NoteViewController {
    func setupAllSubviews() {
        view.backgroundColor = .red
    }
    
    func setupAllConstraints() {
        
    }
}
