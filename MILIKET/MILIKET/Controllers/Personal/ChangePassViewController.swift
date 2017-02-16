//
//  ChangePassViewController.swift
//  MILIKET
//
//  Created by Thành Lã on 2/16/17.
//  Copyright © 2017 Thành Lã. All rights reserved.
//

import UIKit
import SnapKit
import PHExtensions

class ChangePassViewController: GeneralViewController {
    enum Size: CGFloat {
        case padding15 = 15, button = 44, footer = 54, padding10 = 10, headerSection = 20
    }
    
    fileprivate var tableView: UITableView!
    fileprivate var footerView: ChangedPasswordFooterView!
    
    var textFieldOldPassword = UITextField()
    var textFieldNewPassword = UITextField()
    var textFieldReNewPassword = UITextField()
    
    /**
     Nút BACK
     */
    fileprivate lazy var back: UIBarButtonItem = {
        var button = UIBarButtonItem(image: Icon.Nav.Back, style: .plain, target: self, action: #selector(self.back(_:)))
        button.tintColor = UIColor.white
        return button
    }()
    
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
extension ChangePassViewController {
    func back(_ sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func changedPassword(_ sender: UIButton) {
        
    }
}

//-------------------------------------
// MARK: - PRIVATE METHOD
//-------------------------------------
extension ChangePassViewController {
    
    func keyboardWillShow(_ sender: NSNotification) {
        
        guard let userInfo = (sender as NSNotification).userInfo else { return }
        let keyboardHeight = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size.height
        
        let scrollPoint = CGPoint(x: 0, y: scrollHeight + keyboardHeight)
        
        if scrollPoint.y > 0 {
            tableView.setContentOffset(scrollPoint, animated: true)
        }
    }
    
    func keyboardWillHide(_ sender: NSNotification) {
        tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
}

//-------------------------------------
// MARK: - <#Delegate#> DELEGATE
//-------------------------------------
extension ChangePassViewController {
    
}

//-------------------------------------
// MARK: - SETUP
//-------------------------------------
extension ChangePassViewController {
    func setupAllSubviews() {
        
        navigationItem.leftBarButtonItem = back
        
        setupTable()
        setupFooter()
        setupNotificationObserver()
        
    }
    
    func setupAllConstraints() {
        
        footerView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(view)
            make.height.equalTo(Size.footer..)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalTo(view)
            make.bottom.equalTo(footerView.snp.top)
        }
    }
    
    func setupNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func setupTable() {
        tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor.white
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tableView.addGestureRecognizer(pan)
        tableView.addGestureRecognizer(tap)
    }
    
    func setupFooter() {
        footerView = ChangedPasswordFooterView()
        footerView.buttonLeft.addTarget(self, action: #selector(self.back(_:)), for: .touchUpInside)
        footerView.buttonRight.addTarget(self, action: #selector(self.changedPassword(_:)), for: .touchUpInside)
        
    }
    
    private func setupHeaderViewSection(title: String) -> UIView {
        let label = UILabel(frame: CGRect(x: Size.padding15..,
                                          y: 25,
                                          width: UIScreen.main.bounds.width - Size.padding15.. * 2,
                                          height: Size.headerSection..))
        label.font = UIFont(name: FontType.latoBold.., size: FontSize.small++)
        label.textAlignment = .left
        label.textColor = UIColor.darkGray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = title
        
        let seperator = UIView()
        seperator.backgroundColor = UIColor.lightGray
        seperator.frame = CGRect(x: 0, y: label.frame.maxY , width: UIScreen.main.bounds.width, height: onePixel())
        
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        headerView.addSubview(label)
        //        headerView.addSubview(seperator)
        return headerView
    }
    
}
