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
import CleanroomLogger

class MainViewController: GeneralViewController {
    enum Size: CGFloat {
        case padding = 15, button = 44, cell = 54, padding10 = 10, padding5 = 5, segment = 30
    }
    
    var scrollView: UIScrollView!
    var segment: TwicketSegmentedControl!
    
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

///
extension MainViewController: TwicketSegmentedControlDelegate {
    func didSelect(_ segmentIndex: Int) {
        Log.message(.debug, message: "segment: \(segmentIndex)")
    }
}

//-------------------------------------
// MARK: - SETUP
//-------------------------------------
extension MainViewController {
    func setupAllSubviews() {
        view.backgroundColor = UIColor.MKColor.Green.P500
        title = "Home"
        
        segment = setupSegmentControl()
        view.addSubview(segment)
        
    }
    
    func setupAllConstraints() {
        
        
    }
    
    func setupSegmentControl() -> TwicketSegmentedControl {
        let frame = CGRect(x: 5, y: 5, width: view.frame.width - 10, height: 40)
        let segment = TwicketSegmentedControl(frame: frame)
        
        let titles = ["First", "Second", "Third"]
        segment.setSegmentItems(titles)
        segment.delegate = self
        
        segment.sliderBackgroundColor = .main
        
        return segment
    }
    
}
