//
//  FeedbackViewController.swift
//  NguoiBA
//
//  Created by Nguyen Duc Nang on 7/2/16.
//  Copyright © 2016 Nguyen Duc Nang. All rights reserved.
//

import UIKit
import PHExtensions
import SwiftyUserDefaults

class FeedbackViewController: UIViewController {
    //-------------------------------------------
    // MARK: - ENUM
    //-------------------------------------------
    
    /**
     Enum xác định section
     */
    private enum Section: Int {
        case Title = 0, Content, Support
    }
    
    
    //-------------------------------------------
    // MARK: - NAVIBAR BUTTON
    //-------------------------------------------
    
    /**
     Nút BACK
     */
    private lazy var back: UIBarButtonItem = {
        var button = UIBarButtonItem(image: Icon.Navigation.Back, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(FeedbackViewController.back(_:)))
        button.tintColor = UIColor.Navigation.tintColor()
        return button
    }()
    
    
    //-------------------------------------------
    // MARK: - PROPERTIES STORY BOARD
    //-------------------------------------------
    
    /**
     Table
     */
    @IBOutlet weak var table: UITableView!
    
    /**
     Footer
     */
    @IBOutlet weak var footerView: FeedbackFooterView!
    
    /**
     Header View
     */
    @IBOutlet weak var headerView: FeedbackHeaderView!
    
    
    
    //-------------------------------------------
    //MARK: - PROPERTIES
    //-------------------------------------------
    
    /*      TextField       */
    
    /**
     Title feedback
     */
    private var textFieldTitle: UITextField!
    /*      TextView    */
    
    /**
     Content Feedback
     */
    private var textViewContent: UITextView!
    
    /*      VAR     */
    
    /**
     Chứa content của Feedback
     */
    private var feedbackContent: String?
    
    /**
     Scroll height
     */
    //    private var scrollHeight: CGFloat = 0
    
    
    private var scrollHeight: CGFloat = 0
    
    //-------------------------------------------
    //MARK: - VIEW LIFE CYCLE
    //-------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Default
        title = LocalizedString("feedback_title", comment: "Góp ý")
        navigationItem.leftBarButtonItem = back
        
        // Set Delegate
        //    UserReportManager.instance.feedbackDelegate = self
        
        setupAllSubviews()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //-------------------------------------------
    //MARK: - SELECTOR
    //-------------------------------------------
    
    
    /**
     Lấy thông tin chiều cao của bàn phím khi hiện lên
     Để sau này tính offset cho các màn hình bé
     
     - parameter sender:
     */
    func keyboardWillShow(sender: NSNotification) {
        
        if let userInfo = sender.userInfo, keyboardHeight = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue.size.height  {
            
            let scrollPoint = CGPointMake(0.0, scrollHeight + keyboardHeight)
            
            if scrollPoint.y > 0 {
                table.setContentOffset(scrollPoint, animated: true)
            }
        }
    }
    
    func keyboardWillHide(sender: NSNotification) {
        table.setContentOffset(CGPointMake(0.0, 0.0), animated: true)
    }
    
    /**
     Nút BACK
     
     - parameter sender:
     */
    func back(sender: UIBarButtonItem) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    /**
     Nút Send Feedback
     
     - parameter sender:
     */
    func sendFeedback(sender: UIButton) {
        
        // Check nội dung
        guard let feedbackContent = feedbackContent where feedbackContent.characters.count > 0
            else {
                HUD.showMessage(LocalizedString("notification_content_feedback_nil",
                    comment: "Bạn chưa nhập nội dung góp ý"),
                                onView: view)
                
                return
        }
        
//        // Check mạng
//        guard ReachabilitySupport.instance.networkReachable else {
//            HUD.showMessage(LocalizedString("notification_no_internet_connection_please_try_agian",
//                comment: "Bạn đang offline, vui lòng kiểm tra lại kết nối."),
//                            onView: view)
//            return
//        }
        
        
        HUD.showHUD(delay: 0.5.second) {
            HTTPManager.instance.sendFeedback
                .doRequest(HTTPSendFeedback.RequestType(userName: Defaults[.UserName], title: self.textFieldTitle.text!, content: feedbackContent))
                .completionHandler { result in
                    
                    switch result {
                    case .Success(let respond) where respond.status == .Success :
                        self.sendFeedbackSucceed(respond)
                        
                    case .Success(let respond) where respond.status == .Failed :
                        HUD.showMessage("Gửi góp ý không thành công, bạn vui lòng thử lại", position: .Center, onView: self.view)
                        
                    case .Failure(let error):
                        self.sendFeedbackFailed(error)
                        break
                        
                    default:
                        HUD.dismissHUD()
                    }
            }
            
        }
    }
    
    
    
    //-------------------------------------------
    // MARK: - PRIVATE METHOD
    //-------------------------------------------
    
    /**
     Ẩn bàn phím
     */
    func hideKeyboard() {
        textFieldTitle.resignFirstResponder()
        textViewContent.resignFirstResponder()
    }
    
    
    /**
     Gọi hotline
     */
    func call(sender: UIButton) {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            log("on simulator - not calling")
        #else
            let tel = "telprompt://" + "18008198"
            UIApplication.sharedApplication().openURL(NSURL(string: tel)!)
        #endif
    }
    
}

extension FeedbackViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        
        if textFieldTitle.isFirstResponder() || textViewContent.isFirstResponder() { return true }
        
        let location = touch.locationInView(view)
        let rectTextField = CGRect(x: 10,
                                   y: headerView.frame.height,
                                   width: view.frame.width - 20,
                                   height: 40) // Độ cao cell
        
        let rectTextView = CGRect(x: 15,
                                  y: headerView.frame.height + 40 + 15, //độ cao text filed + padding 15
            width: view.frame.width - 30,
            height: Device.size() == .Screen3_5Inch ? 90 : 120) //độ cao text view
        
        return !CGRectContainsPoint(rectTextField, location) && !CGRectContainsPoint(rectTextView, location)
    }
    
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}



//-------------------------------------------
//MARK: - TABLE DATA SOURCE
//-------------------------------------------
extension FeedbackViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2 // 2 sectionc
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case Section.Title..:
            let cellIdentifi = "CellTextField"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifi, forIndexPath: indexPath) as! FeedbackTableViewCell
            configureTextFieldCell(cell, atIndexPath: indexPath)
            return cell
        case Section.Content..:
            let cellIdentifi = "CellTextView"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifi, forIndexPath: indexPath) as! TextViewTableViewCell
            configureTextViewCell(cell, atIndexPath: indexPath)
            return cell
        default:
            break
        }
        return UITableViewCell(style: .Default, reuseIdentifier: "Cell")
    }
    
    private func configureTextFieldCell(cell: FeedbackTableViewCell, atIndexPath indexPath: NSIndexPath) {
        
        cell.seperatorStyle = .Hidden
        //        cell.textField.placeholder = LocalizedString("feedback_section_title_default", comment: "Tiêu đề")
        
        cell.textField.attributedPlaceholder = NSAttributedString(string:LocalizedString("feedback_section_title_default", comment: "Tiêu đề"),
                                                                  attributes:[NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        
        cell.textField.delegate = self
        cell.textField.enabled = true
        cell.textField.returnKeyType = .Next
        textFieldTitle = cell.textField
        
    }
    
    private func configureTextViewCell(cell: TextViewTableViewCell, atIndexPath indexPath: NSIndexPath) {
        
        cell.seperatorStyle = .Hidden
        cell.textView.delegate = self
        cell.textView.text = LocalizedString("feedback_content_default", comment: "Nội dung góp ý (*)")
        cell.textView.textColor = UIColor.lightGrayColor()
        cell.textView.font = UIFont(name: FontType.LatoRegular.., size: FontSize.Normal..)
        textViewContent = cell.textView
        
    }
}



//-------------------------------------------
// MARK: - TABLE VIEW DELEGATE
//-------------------------------------------
extension FeedbackViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case Section.Title..:
            return 50
            
        case Section.Content..:
            return  Device.size() == .Screen3_5Inch ? 90 : 120
            
        default:
            return 120
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case Section.Title..:
            return 1
        case Section.Content..:
            return 1
        default:
            return 1
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
}


//-------------------------------------------
//MARK: - TEXT FIELD DELEGATE
//-------------------------------------------
extension FeedbackViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textViewContent.becomeFirstResponder()
        return false
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        scrollHeight = table.rectForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: Section.Title..)).maxY - (view.frame.height - 5) + headerView.frame.height
        return true
    }
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        // Text field tiêu đề
        
        if let string = textField.text where string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).characters.count == 0 {
            textField.text = nil
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text where text.characters.count > 0 else { return true }
        return text.characters.count + string.characters.count - range.length <= 200
    }
}


//-------------------------------------------
//MARK: - TEXT VIEW DELEGATE
//-------------------------------------------
extension FeedbackViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        scrollHeight = table.rectForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: Section.Content..)).maxY - (view.frame.height - 5) + headerView.frame.height
        
        if feedbackContent == nil {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
        return true
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        
        
        let note = textView.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if note.characters.count == 0 {
            textView.text = LocalizedString("feedback_content_default", comment: "Nội dung góp ý (*)")
            textView.textColor = UIColor.lightGrayColor()
            feedbackContent = nil
        } else {
            feedbackContent = note
        }
        
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        return textView.text.characters.count + text.characters.count - range.length <= 200
    }
    
}


//-------------------------------------------
//MARK: - USER FEEDBACK DELEGATE
//-------------------------------------------

extension FeedbackViewController {
    func sendFeedbackSucceed(response: HTTPSendFeedback.RespondType) {
        HUD.showMessage(LocalizedString("notification_send_feedback_success",
            comment: "Góp ý của bạn đã được gửi tới Ba Sao Taxi, cảm ơn bạn đã sử dụng dịch vụ!"),
                        onView: view,
                        disableUserInteraction: true)
        
        // Reset
        
        textFieldTitle.text = nil
        feedbackContent = nil
        table.reloadData()
    }
    
    
    func sendFeedbackFailed(error: ErrorType) {
        HUD.showMessage(LocalizedString("notification_send_feedback_failed",
            comment: "Có lỗi trong quá trình gửi. Bạn vui lòng gửi lại hoặc gọi trực tiếp cho Ba Sao Taxi."),
                        onView: view,
                        disableUserInteraction: true)
    }
}



//-------------------------------------------
//MARK: - SETUP VIEWS
//-------------------------------------------

extension FeedbackViewController {
    
    func setupAllSubviews() {
        // Set View
        setupHeader()
        setupFooter()
        setupTable()
        setupNotificationObserver()
        
        navigationController?.navigationBarHidden = false
    }
    
    /**
     Setup Table
     */
    private func setupTable() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(FeedbackViewController.hideKeyboard))
        let pan = UIPanGestureRecognizer(target: self, action: #selector(FeedbackViewController.hideKeyboard))
        tap.delegate = self
        pan.delegate = self
        table.addGestureRecognizer(pan)
        table.addGestureRecognizer(tap)
    }
    
    private func setupNotificationObserver() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FeedbackViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FeedbackViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    /**
     Setup Header View
     */
    private func setupHeader() {
        headerView.label.text = LocalizedString("feedback_header_view_title", comment: "Góp ý của bạn sẽ giúp Ba Sao Taxi phục vụ bạn ngày càng tốt hơn")
        
        //        var tap = UITapGestureRecognizer(target: self, action: "hideKeyboard")
        //        var pan = UIPanGestureRecognizer(target: self, action: "hideKeyboard")
        //        tap.delegate = self
        //        pan.delegate = self
        //        headerView.addGestureRecognizer(pan)
        //        headerView.addGestureRecognizer(tap)
    }
    
    /**
     Setup Footer
     */
    private func setupFooter() {
        
        footerView.buttonRight.addTarget(self, action: #selector(FeedbackViewController.sendFeedback(_:)), forControlEvents: .TouchUpInside)
        footerView.buttonLeft.addTarget(self, action: #selector(FeedbackViewController.call(_:)), forControlEvents: .TouchUpInside)
    }
    
}
