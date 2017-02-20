//
//  SideBarMenuViewController.swift
//  MILIKET
//
//  Created by Thành Lã on 2/20/17.
//  Copyright © 2017 Thành Lã. All rights reserved.
//

import UIKit
import SnapKit
import PHExtensions

class SideBarMenuViewController: GeneralViewController {
    enum Size: CGFloat {
        case padding = 15, button = 44, cell = 54, padding10 = 10
    }
    
    fileprivate var tableView: UITableView!
    
    fileprivate var dataArray: [TitleSection] = Utility.shared.fixtureSectionData()
    
    
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
extension SideBarMenuViewController {
    
}

//-------------------------------------
// MARK: - PRIVATE METHOD
//-------------------------------------
extension SideBarMenuViewController {
    
}

//-------------------------------------
// MARK: - TABLE DATASOURE
//-------------------------------------
extension SideBarMenuViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray[section].arrayCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        return cell
    }
}


//-------------------------------------
// MARK: - TABLE DELEGATE
//-------------------------------------
extension SideBarMenuViewController: UITableViewDelegate {
    
}


//-------------------------------------
// MARK: - SETUP
//-------------------------------------
extension SideBarMenuViewController {
    func setupAllSubviews() {
        
        view.backgroundColor = .white
        
        tableView = setupTableView()
        view.addSubview(tableView)
        
    }
    
    func setupAllConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
    }
    
    fileprivate func setupTableView() -> UITableView {
        
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        tableView.register(SeparatorTableViewCell.self, forCellReuseIdentifier: SeparatorTableViewCell.sepaIdentifier)
        
        return tableView
    }
    
}


///
struct TitleSection {
    var titleSection: String!
    var arrayCell: [TitleCell]!
    var visible: Bool = false
    
    init(titleSection: String, arrayCell: [TitleCell]) {
        self.titleSection = titleSection
        self.arrayCell = arrayCell
    }
}

/**
 Thông tin hiển thị của 1 cell gồm Title và Icon
 */
struct TitleCell {
    var title: String!
    var icon: UIImage?
    var selected: Bool!
    
    init(title: String, icon: UIImage?, selected: Bool = false){
        self.title = title
        self.icon = icon
        self.selected = selected
    }
}
