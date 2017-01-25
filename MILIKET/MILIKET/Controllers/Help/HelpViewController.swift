//
//  HelpViewController.swift
//  MILIKET
//
//  Created by Thành Lã on 1/25/17.
//  Copyright © 2017 Thành Lã. All rights reserved.
//

import UIKit
import SnapKit
import PHExtensions

class HelpViewController: GeneralViewController {
    enum Size: CGFloat {
        case padding = 15, button = 44, cell = 54, padding10 = 10
    }
    
    fileprivate var back: UIBarButtonItem!
    fileprivate var table: UITableView!
    
    fileprivate let dataArray: [(text: String, image: UIImage)] = [(LocalizedString("terms_title", comment: "Điều khoản sử dụng"), Icon.Help.Terms),
                                                                   (LocalizedString("help_view_tracking", comment: "Xem lộ trình"), Icon.Help.Tracking)]
    
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
extension HelpViewController {
    func back(_ sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
}

//-------------------------------------
// MARK: - PRIVATE METHOD
//-------------------------------------
extension HelpViewController {
    
}

//-------------------------------------------
//MARK: - UITABLEVIEW DATASOURCE
//-------------------------------------------
extension HelpViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SeparatorTableViewCell.sepaIdentifier, for: indexPath) as! SeparatorTableViewCell
        configureCell(cell, indexPath: indexPath)
        return cell
    }
    
    func configureCell(_ cell: SeparatorTableViewCell, indexPath: IndexPath) {
        
        cell.textLabel?.text = dataArray[indexPath.row].text
        cell.imageView?.image = dataArray[indexPath.row].image.tint(UIColor.Navigation.background)
        cell.textLabel?.font = UIFont(name: FontType.latoRegular.., size: FontSize.normal--)
        cell.textLabel?.textColor = UIColor.Text.blackMedium
        cell.accessoryType = .disclosureIndicator
        cell.seperatorRightPadding = 15
        cell.seperatorStyle = .padding(15)
    }
}

//-------------------------------------------
//MARK: - UITABLEVIEW DELEGATE
//-------------------------------------------

extension HelpViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            HUD.showMessage("Chức năng đang cập nhật")
            
        default:
            let helpDetailsVC = HelpDetailsViewController()
            helpDetailsVC.delegate = self
            helpDetailsVC.typeHelp = HelpDetailsViewController.TypeHelp(rawValue: indexPath.row - 1)!
            present(helpDetailsVC, animated: true, completion: nil)
        }
    }
}


extension HelpViewController: HelpDetailsControllerDelegate {
    func helpDetailsControllerDidFinished() {
        dismiss(animated: true, completion: nil)
    }
}

//-------------------------------------
// MARK: - SETUP
//-------------------------------------
extension HelpViewController {
    func setupAllSubviews() {
        
        UIApplication.shared.statusBarStyle = .default
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.isTranslucent = false
        title = "Trợ giúp"
        setupButtonBack()
        
        table = setupTableView()
        view.addSubview(table)
    }
    
    func setupAllConstraints() {
        table.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
    }
    
    fileprivate func setupTableView() -> UITableView {
        
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.register(SeparatorTableViewCell.self, forCellReuseIdentifier: SeparatorTableViewCell.sepaIdentifier)
        tableView.register(EmptyTableViewCell.self, forCellReuseIdentifier: EmptyTableViewCell.emptyIdentifier)
        
        return tableView
    }
    
    fileprivate func setupButtonBack() {
        back = UIBarButtonItem(image: Icon.Nav.Back, style: .plain, target: self, action: #selector(self.back(_:)))
        back.tintColor = UIColor.Navigation.tint
        navigationItem.leftBarButtonItem = back
    }
    
}
