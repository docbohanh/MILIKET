//
//  MainViewController.swift
//  MILIKET
//
//  Created by Thành Lã on 2/20/17.
//  Copyright © 2017 Thành Lã. All rights reserved.
//

import UIKit
import SnapKit
import PHExtensions

class MainViewController: GeneralViewController {
    enum Size: CGFloat {
        case padding = 15, button = 44, cell = 54, padding10 = 10, padding5 = 5, segment = 30
    }
    
    var scrollView: UIScrollView!
    var segment: FUISegmentedControl!
    
    enum SegmentPosition: Int {
        case first = 0, second
    }
    
    /**
     Array cho segmentedControl | (Số thứ tự, title)
     */
    fileprivate let segmentArray: [(pos: SegmentPosition, title: String)] = [(.first, "Tin tức"), (.second, "Videos")]
    
    
    var postion: SegmentPosition = .first
    
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
extension MainViewController {
    
}

//-------------------------------------
// MARK: - PRIVATE METHOD
//-------------------------------------
extension MainViewController {
    
}

//-------------------------------------
// MARK: - SETUP
//-------------------------------------
extension MainViewController {
    func setupAllSubviews() {
        
        
    }
    
    func setupAllConstraints() {
                
//        segment.snp.makeConstraints { (make) in
//            make.centerX.equalTo(view)
//            make.left.top.right.equalTo(Size.padding5..)
//            make.height.equalTo(Size.segment..)
//        }
//        
//        scrollView.snp.makeConstraints { (make) in
//            make.left.width.bottom.equalTo(view)
//            make.top.equalTo(segment.snp.bottom).inset(Size.padding5..)
//        }
        
    }
    
    
    
}
