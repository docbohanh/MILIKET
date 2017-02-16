//
//  PersonalViewController.swift
//  NguoiBA
//
//  Created by Nguyen Duc Nang on 5/16/16.
//  Copyright © 2016 Nguyen Duc Nang. All rights reserved.
//

import UIKit
import PHExtensions
import SwiftyUserDefaults

enum ChangedPasswordStatus: Int {
    case Failed = 0
    case Success = 1

}

class PersonalViewController: UIViewController {
    

    
    @IBOutlet weak var table: UITableView!
    
    private var headerView: PersonalHeaderView!
    @IBOutlet weak var footerView: PersonalFooterView!
    
    
    
    private var dataArray: [Private] = {
        return DatabaseSupport.instance.getAllPrivate()
    }()
    
    /**
     Action Sheet khi chọn ảnh
     */
    var actionSheet: UIActionSheet!
    
    
    private var dateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    //====================================
    // MARK: - CYCLE LIFE
    //====================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = LocalizedString("tab_bar_item_personal", comment: "Cá nhân")
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(self.checkNetworkAndRequestAllUpdate),
                                                         name: Notification.WillUpdateAll..,
                                                         object: nil)
        
        
        setupAllSubviews()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        dataArray = DatabaseSupport.instance.getAllPrivate()
        table.reloadData()
        
        guard Defaults[.WillUpdateAll] else { return }
        checkNetworkAndRequestAllUpdate()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if let identifier = segue.identifier where identifier == Segue.PersonalController.ToChangedPasswordController {
            
            guard let changedPasswordVC = segue.destinationViewController as? ChangedPasswordViewController else { crashApp(message: "Lỗi ChangedPasswordViewController = nil") }

            changedPasswordVC.title = "Đổi mật khẩu"

        }
        
        if let identifier = segue.identifier where identifier == Segue.PersonalController.ToFeedbackController {
            
            guard let feedbackVC = segue.destinationViewController as? FeedbackViewController else { crashApp(message: "Lỗi FeedbackViewController = nil") }
            
            feedbackVC.title = "Góp ý"
            
        }
    }

}

//-------------------------------------------
//  MARK: - ACTION SHEET DELEGATE
//-------------------------------------------

extension PersonalViewController: UIActionSheetDelegate, UINavigationControllerDelegate {
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        let picker = UIImagePickerController()
        picker.delegate = self
        
        switch buttonIndex {
        case 0: // Chọn bỏ qua
            return
            
        case 1: // Chọn thư viện
            picker.sourceType = .PhotoLibrary
            
        case 2: // Chọn Camera
            picker.sourceType = .Camera
            
        default:
            break
        }
        presentViewController(picker, animated: true, completion: nil)
    }
    
    

}

//-------------------------------------------
//  MARK: - SELECTOR
//-------------------------------------------

extension PersonalViewController {
    
    /**
     Chọn ảnh đại diện khác
     */
    func changeAvatar(sender: UITapGestureRecognizer) {
        
        
        //        actionSheet = UIActionSheet(title: LocalizedString("personal_seletion_avatar", comment: "Chọn ảnh đại diện"),
        //                                    delegate: self,
        //                                    cancelButtonTitle: LocalizedString("genenal_button_cancel", comment: "Bỏ qua"),
        //                                    destructiveButtonTitle: nil,
        //                                    otherButtonTitles: LocalizedString("personal_seletion_avatar_in_library", comment: "Thư viện"), LocalizedString("personal_seletion_avatar_in_camera", comment: "Camera"))
        //
        //        actionSheet.showInView(view)
    }
    
    /**
     Select Button ở Footer
     */
    func buttonFooterSelection(sender: UIGestureRecognizer) {
        
        guard let view = sender.view else { return }
        
        switch view.tag {
        case 0:
            performSegueWithIdentifier(Segue.PersonalController.ToChangedPasswordController, sender: nil)
            
//        case 1:
//            performSegueWithIdentifier(Segue.PersonalController.ToFeedbackController, sender: nil)
            
            
        case 1:
            guard let loginVC = UIStoryboard(name: Storyboard.Login.., bundle: nil).instantiateViewControllerWithIdentifier(ViewController.Login..)
                as? LoginViewController else { crashApp(message: "LoginViewController = nil")}
            
            Defaults[.IsLogin] = false
            Defaults[.TrueName] = ""
            Defaults[.BirthDay] = 0
            Defaults[.UserID] = ""
            let window = UIApplication.sharedApplication().keyWindow
            UIView.transitionWithView(window!,
                                      duration: 0.5,
                                      options: [.TransitionFlipFromLeft],
                                      animations: {
                                        window!.rootViewController = loginVC
                }, completion: { _ in
                    
            })
            
        default:
            break
        }
    }
}

//-------------------------------------------
//  MARK: - IMAGE PICKER DELEGATE
//-------------------------------------------

extension PersonalViewController: UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        dismissViewControllerAnimated(false, completion: nil)
        let croppedImage = cropImage(image, toSize:CGSize(width: 1024, height: 1024))
        
        Utility.saveImageToFile(croppedImage)
        
        headerView.avatar.image = croppedImage
        headerView.avatar.alpha = 0.0
        headerView.avatar.contentMode = .ScaleAspectFill
        UIView.animateWithDuration(0.5.second) {
            self.headerView.avatar.alpha = 1.0
        }
        
    }
    
    private func cropImage(image: UIImage, toSize size: CGSize) -> UIImage {
        
        var newSize: CGSize
        /**
         *  Resize xuống 1024 x 1024
         */
        if image.size.width >= image.size.height { newSize = CGSize(width: 1024, height: 1024 * image.size.height / image.size.width) }
        else { newSize = CGSize(width: 1024 * image.size.width / image.size.height, height: 1024) }
        
        UIGraphicsBeginImageContext(newSize)
        image.drawInRect(CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        /**
         *  Crop to size
         */
        
        let x = (CGImageGetWidth(newImage.CGImage) - Int(size.width)) / 2
        let y = (CGImageGetHeight(newImage.CGImage) - Int(size.height)) / 2
        let cropRect = CGRect(x: x, y: y, width: Int(size.height), height: Int(size.width))
        let imageRef = CGImageCreateWithImageInRect(newImage.CGImage, cropRect)
        
        let cropped = UIImage(CGImage: imageRef!, scale: 0.0, orientation: newImage.imageOrientation)
        return cropped
    }
}


//====================================
// MARK: - TABLE DATASOURCE
//====================================

extension PersonalViewController: UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "CellDefault"
//        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PersonalTableViewCell
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! SeperatorTableViewCell
        configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    private func configureCell(cell: SeperatorTableViewCell, atIndexPath indexPath: NSIndexPath) {
        
//        cell.textLabel?.text = dataArray[indexPath.row].title
//        cell.icon.setImage(dataArray[indexPath.row].image.tint(UIColor.whiteColor()), forState: .Normal)
        
        cell.textLabel?.font = UIFont(name: FontType.LatoRegular.., size: FontSize.Normal++)
        cell.textLabel?.textColor = UIColor.Text.blackMediumColor()
        cell.textLabel?.text = dataArray[indexPath.row].displayName
        cell.textLabel?.numberOfLines = 2
        cell.accessoryType = .DisclosureIndicator
    }
}


//====================================
// MARK: - TABLE DELEGATE
//====================================

extension PersonalViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let privateVC = PrivateViewController()
        privateVC.title = dataArray[indexPath.row].displayName
        
        privateVC.privateInfo = dataArray[indexPath.row]
        navigationController?.pushViewController(privateVC, animated: true)
    
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            return 50
    }
}

// MARK: - REQUEST CHANGED PASSWORD
extension PersonalViewController {
    
    internal func checkNetworkAndRequestAllUpdate(showHUD: Bool = true) {
        
        /* thông báo cho người dùng không có mạng */
        guard networkReachable() else {
            if !showHUD {
                HUD.showMessage(LocalizedString("notification_no_internet_connection_please_try_agian",
                    comment: "Bạn đang offline, vui lòng kiểm tra lại kết nối."),
                                position: .Center,
                                onView: self.view)
            } else {
                HUD.dismissHUD()
            }
            
            return
        }
        
        guard let userID = Int64(Defaults[.UserID]) else {
            
            HUD.showMessage("Có lỗi xảy ra, vui lòng thử lại sau")
            return
        }
        
        var url = HTTPAPI.Login.AllUpdate.URLString
        url += "/" + String(format: "%.0f", Defaults[.AllUpdateLastTime] + 7.hours )
        url += "/" + String(format: "%d", userID)
        
        if showHUD {
            HUD.showHUD(delay: 0.5.second) {
                HTTPManager.instance.allUpdate
                    .doRequestGet(url)
                    .completionGetHandler { result in
                        
                        switch result {
                        case .Success(let respond):
                            self.updateAllRequestSuccess(respond)
                            
                        case .Failure(let error):
                            self.requestFailed(error)
                            break
                        }
                }
            }
            
        } else {
            
            HTTPManager.instance.allUpdate
                .doRequestGet(url)
                .completionGetHandler { result in
                    
                    switch result {
                    case .Success(let respond):
                        self.updateAllRequestSuccess(respond)
                        
                    case .Failure(let error):
                        self.requestFailed(error)
                        break
                    }
            }
            
            
        }
        
    }
    
    
    /**
     Request cập nhật Article thành công
     */
    func updateAllRequestSuccess(respond: HTTPGetUpdateAll.RespondType) {
        
        print("respond: \(respond)")
        
        HUD.dismissHUD()
        DatabaseSupport.instance.insertArticleList(respond.articleList)
        DatabaseSupport.instance.insertHistoryList(respond.historyList)
        DatabaseSupport.instance.insertNoteBookList(respond.notebookList)
        DatabaseSupport.instance.insertPrivateList(respond.privates)
        Defaults[.AllUpdateLastTime] = NSDate().timeIntervalSince1970
        Defaults[.WillUpdateAll] = false
        
        dataArray = DatabaseSupport.instance.getAllPrivate()
        table.reloadData()


        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
    }
    
    
    
    
    func requestFailed(error: ErrorType) {
        
        print("error: \(error)")
        HUD.showMessage(LocalizedString("notification_login_failed", comment: "Không thể kết nối đến server."), position: .Center, onView: view)
    }
 
}

//====================================
// MARK: - SETUP ALL SUBVIEW
//====================================

extension PersonalViewController {
    private func setupAllSubviews() {
        headerView = setupHeaderView()
        setupFooterView()
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(self.changeAvatar(_:)))
//        headerView.userInteractionEnabled = true
//        headerView.addGestureRecognizer(tap)
        
        headerView.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: headerView.viewHeight())
        setupTable()
        table.tableHeaderView = headerView
        
    }
    
    private func setupTable() {
        table.separatorStyle = .None
        table.registerClass(SeperatorTableViewCell.self, forCellReuseIdentifier: "CellDefault")
    }
    
    private func setupFooterView() {
        footerView.arrayButton.each {
            $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.buttonFooterSelection(_:))))
            $0.button.userInteractionEnabled = false
        }
    }
    
    private func setupHeaderView() -> PersonalHeaderView {
        let headerView = PersonalHeaderView()
        
        let name: String
        if Defaults[.TrueName].characters.count > 0 {
            name = Defaults[.TrueName]
        } else {
            name = Defaults[.NickName]
        }
        
        headerView.name.text = name.uppercaseString
        headerView.avatar.image = Icon.Personal.AvatarDefault
        
        
        if Defaults[.BirthDay] > 0 {
            headerView.date.text = dateFormatter.stringFromDate(NSDate(timeIntervalSince1970: Defaults[.BirthDay]))
        } else {
            headerView.date.text = nil
        }
        
        if let image = Utility.retriveImageFromFile() {
            headerView.avatar.image = image
            return headerView
        }
        

        guard let url = NSURL(string: Defaults[.AvatarLink]) else { return headerView }
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (responseData, responseUrl, error) -> Void in
            guard let data = responseData else { return }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if let image = UIImage(data: data) {
                    self.headerView.avatar.image = image
                    Utility.saveImageToFile(image)
                }
            })
        }
        task.resume()
        
        return headerView
    }
}