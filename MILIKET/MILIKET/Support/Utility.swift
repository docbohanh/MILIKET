//
//  Utility.swift
//  P01.TapCounter
//
//  Created by Thành Lã on 12/29/16.
//  Copyright © 2016 Bình Anh Electonics. All rights reserved.
//

import UIKit
import GoogleMaps
import PHExtensions
import CleanroomLogger


public func crashApp(message:String) -> Never  {
    let log = "CRASH - " + message
    Log.message(.error, message: log)
    fatalError(log)
}

public func delay(_ delay: Double, closure:@escaping () -> () ) {
    
    DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: closure)
}

struct Utility {
    static let shared = Utility()
    
        
    /**
     Tính chiều rộng của text
     */
    func widthForView(text: String, font: UIFont, height: CGFloat) -> CGFloat {
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0,  width: CGFloat.greatestFiniteMagnitude, height: height))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.width
    }
    
    /**
     Tính độ cao cho text
     */
    func heightForView(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    
    func getGMSPath(from coordinate: [Coordinate]) -> GMSPath {
        let path = GMSMutablePath()
        coordinate.forEach { path.add($0) }
        return path
    }
    
    /*
     Format khoảng cách
     */
    func stringFromConvertDistanceToText(_ distance: Double, metersAccuracy: Bool = true) -> String {
        if distance < 1000 && metersAccuracy {
            return distance.toString(0) + " " + "m"
        } else {
            return (distance / 1000).toString(1) + " " + "Km"
        }
    }
    
    func stringMinuteFromTimeInterval(_ duration: TimeInterval) -> String {
        
        guard duration >= 0 else { crashApp(message: "duration < 0 : get minute") }
        guard duration > 0 else { return "0" + " " + "phút" }
        guard duration > 30 else { return "Dưới 1 phút"  }
        
        var hour, minute, second: Int
        hour = Int(duration / 1.hour)
        minute = (Int(duration) - (hour * Int(1.hour))) / Int(1.minute)
        second = Int(duration) - (hour * Int(1.hour)) - (minute * Int(1.minute))
        
        if second >= 30 { minute += 1 }
        if minute == 60 { hour += 1; minute = 0 }
        
        
        var stringTime = ""
        if hour > 0 { stringTime += "\(hour) " + (hour > 1 ? "giờ" :"giờ")}
        if minute > 0 { stringTime += " \(minute) " + (minute > 1 ? "phút" : "phút") }
        return stringTime
    }
    
    /*
     Format khoảng cách
     */
    static func stringFromConvertDistanceToText(_ distance: Double, metersAccuracy: Bool = true) -> String {
        if distance < 1000 && metersAccuracy {
            return distance.toString(0) + " " + "m"
        } else {
            return (distance / 1000).toString(1) + " " + "Km"
        }
    }
    
    /**
     Chỉnh lại giao diện navigation bar
     
     - parameter navController:
     */
    func configureAppearance(navigation navController: UINavigationController) {
        
        navController.navigationBar.titleTextAttributes = [
            NSFontAttributeName: UIFont(name: FontType.latoRegular.., size: FontSize.large--)!,
            NSForegroundColorAttributeName: UIColor.white]
        navController.navigationBar.barTintColor = UIColor.main
        
        
        navController.navigationBar.barStyle = .black
        navController.navigationBar.shadowImage = UIImage()
        navController.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        navController.navigationBar.isTranslucent = false
    }
    
    ///
    func setupTabBarController() -> UITabBarController {
        
        let tabbarVC = UITabBarController()
        
        let naviHistoryVC = UINavigationController(rootViewController: HistoryViewController())
        let naviHelpVC    = UINavigationController(rootViewController: HelpViewController())
        let naviArticleVC = UINavigationController(rootViewController: ArticleViewController())
        let naviPersonalVC = UINavigationController(rootViewController: PersonalViewController())
        
        let viewControllers = [naviArticleVC, naviHelpVC, naviHistoryVC, naviPersonalVC]
        
        viewControllers.forEach { Utility.shared.configureAppearance(navigation: $0) }
        
        tabbarVC.viewControllers = viewControllers
        
        tabbarVC.tabBar.barStyle = .default
        tabbarVC.tabBar.backgroundColor = UIColor.Navigation.main
        tabbarVC.tabBar.barTintColor = UIColor.white.alpha(0.8)
        tabbarVC.tabBar.isTranslucent = false
        
        let items: [(title: String, image: UIImage)] = [
            ("Tin tức", Icon.TabBar.article),
            ("Trợ giúp",  Icon.TabBar.noteBook),
            ("Lịch sử", Icon.TabBar.history),
            ("Cá nhân", Icon.TabBar.personal)
        ]
        
        
        for (i, item)  in tabbarVC.tabBar.items!.enumerated() {
            item.selectedImage = items[i].image.tint(UIColor.main)
            item.image = items[i].image.tint(UIColor.lightGray)
            item.title = items[i].title
            
            item.setTitleTextAttributes([
                NSFontAttributeName: UIFont(name: FontType.latoSemibold.., size: FontSize.small++)!], for: .normal)
            
        }
        
        return tabbarVC
    }
    
    func fixtureSectionData() -> [TitleSection] {
        
        return [
            
            TitleSection(titleSection: "",
                         arrayCell: [
                            TitleCell(title: "Tin tức", icon: Icon.TabBar.article)
                            ]),
            
            TitleSection(titleSection: "Giải đấu",
                         arrayCell: [
                            TitleCell(title: "Premier League",   icon: Icon.TabBar.noteBook),
                            TitleCell(title: "La Liga",          icon: Icon.TabBar.noteBook),
                            TitleCell(title: "Bundesliga",       icon: Icon.TabBar.noteBook),
                            TitleCell(title: "Seri A",           icon: Icon.TabBar.noteBook),
                            TitleCell(title: "Champions League", icon: Icon.TabBar.noteBook),
                            
                            ]),
            
            TitleSection(titleSection: "Khác",
                         arrayCell: [
                            TitleCell(title: "About",       icon: Icon.TabBar.history)
                            ])
            
            
        ]
    }

}

struct AppConfig {
    struct Tracking {
        static let BaseTimeMoving: TimeInterval = 0.5.second
        static let BaseTimeRotating: TimeInterval = 0.25.second
        static let BaseTimeStop: TimeInterval = 2.seconds
    }
}

