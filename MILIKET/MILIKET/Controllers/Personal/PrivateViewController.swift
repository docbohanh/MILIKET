//
//  PrivateViewController.swift
//  NguoiBA
//
//  Created by Nguyen Duc Nang on 9/9/16.
//  Copyright © 2016 Nguyen Duc Nang. All rights reserved.
//

import UIKit
import PHExtensions
import SwiftyUserDefaults

class PrivateViewController: UIViewController {
    
    var table: UITableView!
    var refreshControl: UIRefreshControl!
    
    var didSetupAllConstraints: Bool = false
    
    var privateChilds: [PrivateChilds] = []
    
    var privateInfo: Private! {
        didSet {
            privateChilds = privateInfo.childs.sort { $0.order < $1.order }
        }
    }
    
    private var dateFormatter: NSDateFormatter = {
        var formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm dd/MM/yyyy"
        return formatter
    }()
    
    
    /// Bar button
    
    var back: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        privateChilds = privateInfo.childs.sort { $0.order < $1.order }
        
        setupAllSubviews()
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(self.checkNetworkAndRequestAllUpdate),
                                                         name: Notification.WillUpdateAll..,
                                                         object: nil)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        if !didSetupAllConstraints {
            setupAllConstraits()
            didSetupAllConstraints = true
        }
        super.updateViewConstraints()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        guard Defaults[.WillUpdateAll] else { return }
        checkNetworkAndRequestAllUpdate()
        
    }
}

extension PrivateViewController {
    func back(sender: UIBarButtonItem) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func refresh(refreshControl: UIRefreshControl) {
        guard NSDate().timeIntervalSince1970 - Defaults[.AllUpdateLastTime] > 15.seconds else {
            refreshControl.endRefreshing()
            return
        }
        checkNetworkAndRequestAllUpdate(false)
    }
}

extension PrivateViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return articleList.count
        
        return privateInfo.childs.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! SeperatorTableViewCell
        
        configCell(cell, atIndexPath: indexPath)
        
        return cell
    }
    
    func configCell(cell: SeperatorTableViewCell, atIndexPath indexPath: NSIndexPath) {
        
         let article = privateInfo.childs[indexPath.row]
        
        cell.backgroundColor = UIColor.whiteColor()
        cell.textLabel?.textColor = UIColor.Text.blackMediumColor()
        cell.textLabel?.numberOfLines = 2
        cell.textLabel?.font = UIFont(name: FontType.LatoRegular.., size: FontSize.Normal++)
        

        cell.accessoryType = .DisclosureIndicator
        cell.textLabel?.text = article.title
        cell.imageView?.image = UIImage(named: "LogoApp")
        
    }
}

extension PrivateViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let detailVC = DetailArticleViewController()
        
//        if privateInfo.childs[indexPath.row].uri.characters.count > 0 {
//            
//            let url = privateInfo.childs[indexPath.row].uri
//            
//            if url.hasSuffix(".pdf") {
//                detailVC.type = .PDF
//            } else {
//                detailVC.type = .DOC
//            }
//            
//            detailVC.urlString = privateInfo.childs[indexPath.row].uri
//        } else {
            detailVC.urlString = privateInfo.childs[indexPath.row].url
//        }
        
        
        detailVC.title = "Chi tiết"
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
}

//----------------------------------
// MARK: - REQUEST
//----------------------------------
extension PrivateViewController {
    
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
            
            refreshControl.endRefreshing()
            return
        }
        
        guard let userID = Int64(Defaults[.UserID]) else {
            
            HUD.showMessage("Có lỗi xảy ra, vui lòng thử lại sau")
            refreshControl.endRefreshing()
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
                        self.refreshControl.endRefreshing()
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
                    self.refreshControl.endRefreshing()
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
        

        HUD.dismissHUD()
        DatabaseSupport.instance.insertArticleList(respond.articleList)
        DatabaseSupport.instance.insertHistoryList(respond.historyList)
        DatabaseSupport.instance.insertNoteBookList(respond.notebookList)
        DatabaseSupport.instance.insertPrivateList(respond.privates)
        Defaults[.AllUpdateLastTime] = NSDate().timeIntervalSince1970
        Defaults[.WillUpdateAll] = false
        
        DatabaseSupport.instance.getAllPrivate().each {
            if $0.roleID == privateInfo.roleID {
                privateInfo = $0
                table.reloadData()
            }
        }
        
        
        
        
        let string = "Cập nhật lúc " + dateFormatter.stringFromDate(NSDate(timeIntervalSince1970: Defaults[.AllUpdateLastTime]))
        refreshControl.attributedTitle = NSAttributedString(string: string)
        
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
    }
    
    
    
    
    func requestFailed(error: ErrorType) {
        
        print("error: \(error)")
        HUD.showMessage(LocalizedString("notification_login_failed", comment: "Không thể kết nối đến server."), position: .Center, onView: view)
    }
    
}


extension PrivateViewController {
    func setupAllSubviews() {
        
        back = setupBarButton()
        navigationItem.leftBarButtonItem = back
        
        table = setupTableView()
        view.addSubview(table)
        
        refreshControl = setupRefreshView()
        table.addSubview(refreshControl)
    }
    
    func setupAllConstraits() {
        table.snp_makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    
    func setupBarButton() -> UIBarButtonItem {
        let button = UIBarButtonItem(image: Icon.Navigation.Back, style: .Plain, target: self, action: #selector(self.back(_:)))
        button.tintColor = UIColor.whiteColor()
        return button
    }
    
    func setupTableView() -> UITableView {
        let table = UITableView(frame: CGRectZero, style: .Plain)
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .None
//        table.registerClass(ArticleTableViewCell.self, forCellReuseIdentifier: "ArticleCell")
        table.registerClass(SeperatorTableViewCell.self, forCellReuseIdentifier: "Cell")
        return table
    }
    
    func setupRefreshView() -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        
        refreshControl.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 60)
        
        refreshControl.addTarget(self, action: #selector(refresh(_:)), forControlEvents: .ValueChanged)
        
        let string = "Cập nhật lúc " + dateFormatter.stringFromDate(NSDate(timeIntervalSince1970: Defaults[.AllUpdateLastTime]))
        
        refreshControl.attributedTitle = NSAttributedString(string: string)
        
        return refreshControl
    }
}


