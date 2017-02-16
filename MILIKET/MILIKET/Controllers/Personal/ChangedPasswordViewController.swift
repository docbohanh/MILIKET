//
//  ChangedPasswordViewController.swift
//  NguoiBA
//
//  Created by Nguyen Duc Nang on 6/28/16.
//  Copyright © 2016 Nguyen Duc Nang. All rights reserved.
//

import UIKit
import PHExtensions
import SwiftyUserDefaults

class ChangedPasswordViewController: UIViewController {
    
    private enum Size: CGFloat {
        case Padding15 = 15, HeaderSection = 20
    }
    
    let arrayTitle: [String] = ["Mật khẩu hiện tại", "Mật khẩu mới", "Nhập lại mật khẩu mới"]
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var footerView: ChangedPasswordFooterView!
    
    var textFieldOldPassword = UITextField()
    var textFieldNewPassword = UITextField()
    var textFieldReNewPassword = UITextField()
    
    private var scrollHeight: CGFloat = 0
    
    //-------------------------------------------
    // MARK: - NAVIBAR BUTTON
    //-------------------------------------------
    
    /**
     Nút BACK
     */
    private lazy var back: UIBarButtonItem = {
        var button = UIBarButtonItem(image: Icon.Nav.Back, style: .Plain, target: self, action: #selector(self.back(_:)))
        button.tintColor = UIColor.Navigation.tintColor()
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAllSubviews()
    }
}

extension ChangedPasswordViewController {
    
    /**
     Lấy thông tin chiều cao của bàn phím khi hiện lên
     Để sau này tính offset cho các màn hình bé
     
     - parameter sender:
     */
    func keyboardWillShow(sender: NSNotification) {
        
        if let userInfo = sender.userInfo, let keyboardHeight = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue.size.height  {
            
            let scrollPoint = CGPointMake(0.0, scrollHeight + keyboardHeight)
            
            if scrollPoint.y > 0 {
                table.setContentOffset(scrollPoint, animated: true)
            }
        }
    }
    
    func keyboardWillHide(sender: NSNotification) {
        table.setContentOffset(CGPointMake(0.0, 0.0), animated: true)
    }
    
    func back(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func changedPassword(sender: UIButton) {
        
        guard textFieldOldPassword.text == Defaults[.Password] else {
            HUD.showMessage("Sai mật khẩu hiện tại")
            return
        }
        
        guard textFieldNewPassword.text != Defaults[.Password] else {
            HUD.showMessage("Mật khẩu mới và cũ phải khác nhau")
            return
        }
        
        guard textFieldNewPassword.text == textFieldReNewPassword.text else {
            HUD.showMessage("Mật khẩu mới khác nhau")
            return
        }
        
        guard textFieldNewPassword.text?.characters.count > 5 else {
            HUD.showMessage("Mật khẩu mới quá ngắn, vui lòng nhập lại mật khẩu khác.")
            return
        }
        
        self.checkNetworkAndRequestChangedPassword(Defaults[.UserName], oldPassword: textFieldOldPassword.text!, newPassword: textFieldNewPassword.text!)
    }
    
    //-------------------------------------------
    // MARK: - PRIVATE METHOD
    //-------------------------------------------
    
    /**
     Ẩn bàn phím
     */
    func hideKeyboard() {
        textFieldOldPassword.resignFirstResponder()
        textFieldNewPassword.resignFirstResponder()
        textFieldReNewPassword.resignFirstResponder()
    }
}

extension ChangedPasswordViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return arrayTitle.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentify = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentify, forIndexPath: indexPath) as! TextFieldTableViewCell
        configuaCell(cell, indexPath: indexPath)
        return cell
    }
    
    func configuaCell(cell: TextFieldTableViewCell, indexPath: NSIndexPath) {
        cell.seperatorStyle = .Padding(15)
        cell.seperatorRightPadding = 15
        cell.textField.secureTextEntry = true
        cell.textField.tag = indexPath.section
        cell.textField.delegate = self
        
        switch indexPath.section {
        case 0:
            cell.textField.returnKeyType = .Next
            cell.textField.placeholder = "Nhập mật khẩu hiện tại"
            textFieldOldPassword = cell.textField

            
        case 1:
            cell.textField.returnKeyType = .Next
            cell.textField.placeholder = "Nhập mật khẩu mới"
            textFieldNewPassword = cell.textField
            
            
        case 2:
            cell.textField.returnKeyType = .Done
            cell.textField.placeholder = "Nhập lại mật khẩu mới"
            textFieldReNewPassword = cell.textField


            
        default:
            break
        }
        
    }
}

extension ChangedPasswordViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField.tag == 0 {
            textFieldNewPassword.becomeFirstResponder()
        }
        else if textField.tag == 1 {
            textFieldReNewPassword.becomeFirstResponder()
        }
        else {
            textFieldReNewPassword.resignFirstResponder()
        }
        
        return false
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        scrollHeight = table.rectForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: textField.tag)).maxY - (view.frame.height - 5)
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text where text.characters.count > 0 else { return true }
        return text.characters.count + string.characters.count - range.length <= 256
    }
}


extension ChangedPasswordViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return setupHeaderViewSection(arrayTitle[section])
    }
}


// MARK: - REQUEST CHANGED PASSWORD
extension ChangedPasswordViewController {
    /**
     Request Login
     */
    private func checkNetworkAndRequestChangedPassword(userName: String, oldPassword: String, newPassword: String) {
        
        /* thông báo cho người dùng không có mạng */
        //                guard ReachabilitySupport.instance.networkReachable else {
        //                    HUD.showMessage(LocalizedString("notification_no_internet_connection_please_try_agian",
        //                        comment: "Bạn đang offline, vui lòng kiểm tra lại kết nối."),
        //                                    position: .Center,
        //                                    onView: self.view)
        //                    return
        //                }
        
        
        HUD.showHUD(delay: 0.5.second) {
            HTTPManager.instance.changedPassword
                .doRequest(HTTPChangedPassword.RequestType(userName: userName, oldPassword: oldPassword, newPassword: newPassword))
                .completionHandler { result in
                    
                    switch result {
                    case .Success(let respond) where respond.status == .Success :
                        self.changedPasswordSuccess(respond)
                        
                    case .Success(let respond) where respond.status == .Failed :
                        HUD.showMessage("Sai mật khẩu cũ, bạn vui lòng thử lại", position: .Center, onView: self.view)
                        
                    case .Failure(let error):
                        self.changedPasswordFailed(error)
                        break
                        
                    default:
                        HUD.dismissHUD()
                    }
            }
            
        }
    }
    
    
    /**
     Request đăng nhập thành công
     */
    func changedPasswordSuccess(respond: HTTPChangedPassword.RespondType) {
        
        Defaults[.Password] = textFieldNewPassword.text!
        HUD.showMessage("Đổi mật khẩu thành công", position: .Center, onView: view)
        
        Async.main(after: 1.5.second) {
            self.navigationController?.popViewControllerAnimated(true)
        }
        
    }
    
    
    func changedPasswordFailed(error: ErrorType) {
        HUD.showMessage(LocalizedString("notification_login_failed", comment: "Không thể kết nối đến server."), position: .Center, onView: view)
    }
}


extension ChangedPasswordViewController {
    func setupAllSubviews() {
        
        navigationItem.leftBarButtonItem = back
        
        setupTable()
        setupFooter()
        setupNotificationObserver()
        
    }
    
    private func setupNotificationObserver() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func setupTable() {
        table.separatorStyle = .None
        table.allowsSelection = false
        table.backgroundColor = UIColor.whiteColor()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        table.addGestureRecognizer(pan)
        table.addGestureRecognizer(tap)
    }
    
    func setupFooter() {
        footerView.buttonLeft.addTarget(self, action: #selector(self.back(_:)), forControlEvents: .TouchUpInside)
        footerView.buttonRight.addTarget(self, action: #selector(self.changedPassword(_:)), forControlEvents: .TouchUpInside)
        
    }
    
    private func setupHeaderViewSection(title: String) -> UIView {
        let label = UILabel(frame: CGRect(x: Size.Padding15..,
            y: 25,
            width: UIScreen.mainScreen().bounds.width - Size.Padding15.. * 2,
            height: Size.HeaderSection..))
        label.font = UIFont(name: FontType.LatoBold.., size: FontSize.Small++)
        label.textAlignment = .Left
        label.textColor = UIColor.Text.blackMediumColor()
        label.numberOfLines = 0
        label.lineBreakMode = .ByWordWrapping
        label.text = title
        
        let seperator = UIView()
        seperator.backgroundColor = UIColor.Misc.seperatorColor()
        seperator.frame = CGRect(x: 0, y: label.frame.maxY , width: UIScreen.mainScreen().bounds.width, height: onePixel())
        
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clearColor()
        headerView.addSubview(label)
//        headerView.addSubview(seperator)
        return headerView
    }
}
