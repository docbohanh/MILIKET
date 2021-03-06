//
//  ArticleViewController.swift
//  MILIKET
//
//  Created by MILIKET on 1/28/17.
//  Copyright © 2017 Thành Lã. All rights reserved.
//

import UIKit
import SnapKit
import PHExtensions
import PagingMenuController

class ArticleViewController: GeneralViewController {
    fileprivate enum Size: CGFloat {
        case padding15 = 15, padding5 = 5, padding10 = 10, button = 44
    }
    var didSetupContraints = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAllSubviews()
        view.setNeedsUpdateConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func updateViewConstraints() {
        if !didSetupContraints {
            setupAllConstraints()
            didSetupContraints = true
        }
        
        super.updateViewConstraints()
    }
    
}

//------------------------------
//MARK: SELECTOR
//------------------------------
extension ArticleViewController {
    func menu(_ sender: UIBarButtonItem) {
        if let drawerController = navigationController?.parent as? KYDrawerController {
            drawerController.setDrawerState(.opened, animated: true)
        }
        
    }
}

//------------------------------
//MARK: PRIVATE METHOD
//------------------------------
extension ArticleViewController {
    
}

//------------------------------
//MARK: SETUP VIEW
//------------------------------
extension ArticleViewController {
    func setupAllSubviews() {
        
        title = "Live Football Score"
        
        setupLeftBarButton()
                
        setupPagingMenuViewController()
        
    }
    
    func setupAllConstraints() {
        
    }
    
    ///
    fileprivate func setupLeftBarButton() {
        let left = setupBarButton(image: Icon.Nav.Menu, selector: #selector(self.menu(_:)), target: self)
        navigationItem.leftBarButtonItem = left
    }
    
    ///
    func setupPagingMenuViewController() {
        let options = PagingMenuOptions()
        let pagingMenuController = PagingMenuController(options: options)
        
        addChildViewController(pagingMenuController)
        view.addSubview(pagingMenuController.view)
        pagingMenuController.didMove(toParentViewController: self)
    }
    
}

private struct PagingMenuOptions: PagingMenuControllerCustomizable {
    private let news = NewsViewController()
    private let videos = VideosViewController()
    
    fileprivate var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(), pagingControllers: pagingControllers)
    }
    
    fileprivate var pagingControllers: [UIViewController] {
        return [news, videos]
    }
    
    fileprivate struct MenuOptions: MenuViewCustomizable {
        
        let bgColor: UIColor = .main
        
        var displayMode: MenuDisplayMode {
            return .segmentedControl
        }
        
        var focusMode: MenuFocusMode {
            return .underline(height: 3 * onePixel(), color: UIColor.red, horizontalPadding: 0, verticalPadding: 0)
        }
        
        var itemsOptions: [MenuItemViewCustomizable] {
            return [MenuItem(title: "Tin tức"), MenuItem(title: "Videos")]
        }
        
        var backgroundColor: UIColor {
            return bgColor
        }
        
        var selectedBackgroundColor: UIColor {
            return bgColor
        }
        
        var height: CGFloat {
            return 40
        }
    }
    
    fileprivate struct MenuItem: MenuItemViewCustomizable {
        
        var title: String
        
        var displayMode: MenuItemDisplayMode {
            return MenuItemDisplayMode.text(title: MenuItemText(
                text: title,
                color: UIColor.white.alpha(0.9),
                selectedColor: UIColor.white,
                font: UIFont(name: FontType.latoLight.., size: FontSize.normal++)!,
                selectedFont: UIFont(name: FontType.latoSemibold.., size: FontSize.normal++)!)
            )
        }
    }
    
}

