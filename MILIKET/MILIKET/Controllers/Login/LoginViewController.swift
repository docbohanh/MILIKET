//
//  LoginViewController.swift
//  MILIKET
//
//  Created by Thành Lã on 2/16/17.
//  Copyright © 2017 Thành Lã. All rights reserved.
//

import UIKit
import SnapKit
import PHExtensions

class LoginViewController: GeneralViewController {
    enum Size: CGFloat {
        case padding5 = 5, padding10 = 10, padding15 = 15, footer = 30, loginHeight = 195, loginWidth = 290, logo = 240
    }
    
    var bgImageView: UIImageView!
    var logoBA: UIImageView!
    var loginView: LoginView!
    var labelFooter: UILabel!
    var loginViewBottomConstraint: Constraint!
    
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


//---------------------------------------
//MARK: - SELECTOR
//---------------------------------------
extension LoginViewController {
    
    func remember(sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func login(sender: UIButton) {
        dismissKeyboard()
        
        let trimmer = { (text: String?) -> String? in
            return text?.trimmingCharacters(in: .whitespaces)
        }
        
        guard let username = trimmer(loginView.userName.text), username.characters.count > 0,
            let password = trimmer(loginView.password.text), password.characters.count > 0 else {
                
                HUD.showMessage("Bạn vui lòng điền đầy đủ tên tài khoản và mật khẩu!", onView: view)
                return
        }
        
        checkNetworkAndRequestLogin(user: username, pass: password)
                
    }
    
}


//-------------------------------------
// MARK: - PRIVATE METHOD
//-------------------------------------
extension LoginViewController {
    
    fileprivate func checkNetworkAndRequestLogin(user: String, pass: String) {
        
        guard ReachabilitySupport.instance.networkReachable else {
            HUD.showMessage("Bạn đang offline, vui lòng kiểm tra lại kết nối")
            return
        }
        
        let tabBarVC = setupTabBarController()
        let window = UIApplication.shared.keyWindow
        UIView.transition(
            with: window!,
            duration: 0.5,
            options: [.transitionFlipFromLeft],
            animations: {
                
                let oldState = UIView.areAnimationsEnabled
                UIView.setAnimationsEnabled(false)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = tabBarVC
                UIView.setAnimationsEnabled(oldState)
                
        }, completion: nil)
        
    }
    
    /**
     Setup Tabbar
     */
    
    fileprivate func setupTabBarController() -> UITabBarController {
        
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
}


//---------------------
//MARK: - SETUP VIEW
//---------------------
extension LoginViewController {
    
    func setupAllSubviews() {
        
        navigationController?.isNavigationBarHidden = true
        
        setupBackgroundImage()
        setupLoginView()
        setupLabelFooter()
        setupLogo()
        
        view.addSubview(bgImageView)
        view.addSubview(logoBA)
        view.addSubview(loginView)
        view.addSubview(labelFooter)
        
        setupNotificationObserver()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(pan)
        view.addGestureRecognizer(tap)
        
        
    }
    
    func setupAllConstraints() {
        
        bgImageView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        
        loginView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.width.equalTo(Size.loginWidth.. - Size.padding5.. * 2)
            make.height.equalTo(Size.loginHeight..)
            loginViewBottomConstraint = make.bottom.equalTo(view.snp.bottom).inset((view.frame.height - Size.loginHeight..) / 2).constraint
        }
        
        logoBA.snp.makeConstraints { (make) in
            make.width.equalTo(Size.logo..)
            make.height.equalTo(70)
            make.centerX.equalTo(loginView)
            make.bottom.equalTo(loginView.snp.top).offset(-Size.padding15.. * 2)
        }
        
        labelFooter.snp.makeConstraints { (make) in
            make.width.equalTo(view.snp.width).inset(Size.padding5..)
            make.height.equalTo(Size.footer..)
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.snp.bottom)
        }
        
    }
    
    func setupNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(_ sender: Notification) {
        guard let userInfo = (sender as NSNotification).userInfo else { return }
        let height = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size.height
        
        let scrollHeight = height - (view.frame.height - loginView.frame.maxY) - 5
        guard scrollHeight > 0 else { return }
        
        loginViewBottomConstraint.update(offset: -height - 5)
        self.view.layoutIfNeeded()
    }
    
    func keyboardWillHide(_ sender: Notification) {
        loginViewBottomConstraint.update(offset: (-view.frame.height + Size.loginHeight.. + 70) / 2)
        self.view.layoutIfNeeded()
    }
    
    
    fileprivate func setupBackgroundImage() {
        
        bgImageView = UIImageView()
        bgImageView.image = Icon.General.background
        bgImageView.contentMode = .scaleAspectFill
        
    }
    
    fileprivate func setupLogo() {
        logoBA = UIImageView()
        logoBA.image = Icon.General.logo
        logoBA.contentMode = .center
        logoBA.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(self.dismissKeyboard)))
    }
    
    
    fileprivate func setupLoginView() {
        loginView = LoginView()
        loginView.layer.cornerRadius = 5
        loginView.login.addTarget(self, action: #selector(self.login(sender:)), for: .touchUpInside)
        loginView.remember.addTarget(self, action: #selector(self.remember(sender:)), for: .touchUpInside)
        loginView.userName.delegate = self
        loginView.password.delegate = self
        loginView.backgroundColor = UIColor.white.alpha(0.8)
        
        
    }
    
    fileprivate func setupLabelFooter() {
        labelFooter = UILabel()
        labelFooter.font = UIFont(name: FontType.latoRegular.., size: FontSize.small++)
        labelFooter.textColor = .white
//        labelFooter.text = "© Copyright by BinhAnh Electronic Co., Ltd."
        labelFooter.textAlignment = .center
    }
    
}

//MARK: -
extension LoginViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        /**
         *  Name TextField: không cho nhập quá 15 ký tự
         */
        if textField == loginView.userName {
            var newLength =  string.characters.count - range.length
            
            if let name = textField.text {
                newLength += name.characters.count
            }
            
            return (newLength > 15) ? false : true
        }
        return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginView.userName {
            loginView.password.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}
