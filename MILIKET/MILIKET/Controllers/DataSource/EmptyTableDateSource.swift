//
//  EmptyTableDateSource.swift
//  MILIKET
//
//  Created by Thành Lã on 2/20/17.
//  Copyright © 2017 Thành Lã. All rights reserved.
//

import Foundation
protocol EmptyTableDataSourceDelegate: class {
    func getEmptyTableCellHeight() -> CGFloat
}


class EmptyTableDateSource: NSObject {
    enum EmptyTableType: Int {
        case news = 0
        case videos
        
    }
    
    var tableType: EmptyTableType?
    weak var delegate: EmptyTableDataSourceDelegate?
    
    func emptyNotifyStringForTable(type: EmptyTableType ) -> String {
        switch type {
        case .news:
            return "Chưa có tin tức nào được ghi"
        case .videos:
            return "Chưa có video nào được ghi"
        
        }
    }
}


//MARK: UITableViewDataSource
extension EmptyTableDateSource: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        
        tableView.backgroundColor = UIColor.groupTableViewBackground
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let type = tableType {
            switch type {
            default:
                let cellIdentifier = "EmptyCell"
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EmptyTableViewCell
                configureCell(cell: cell, atIndexPath: indexPath)
                return cell
                
            }
        }
        return UITableViewCell(style: .default, reuseIdentifier: "Cell")
    }
    
    private func configureCell(cell: EmptyTableViewCell, atIndexPath indexPath: IndexPath) {
        
        cell.textLabel?.text = emptyNotifyStringForTable(type: tableType!)
    }
    
    private func configureEmptyImageCell(cell: EmptyImageTableViewCell, atIndexPath indexPath: IndexPath) {
        cell.imageView?.image = Icon.General.logo
    }
    
}

//MARK: UITableViewDelegate

extension EmptyTableDateSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = delegate?.getEmptyTableCellHeight()
        if height == nil { crashApp(message: "must implement deleagte - không lấy được độ cao của Cell - 11") }
        return height!
    }
}
