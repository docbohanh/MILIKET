//
//  HelpDetailsViewController.swift
//  MILIKET
//
//  Created by Thành Lã on 1/25/17.
//  Copyright © 2017 Thành Lã. All rights reserved.
//

import UIKit
import SnapKit
import PHExtensions

//-------------------------------------------
//MARK: - PROTOCOL
//-------------------------------------------
protocol HelpDetailsControllerDelegate: class {
    func helpDetailsControllerDidFinished()
}

class HelpDetailsViewController: GeneralViewController {
    /**
     Enum size
     */
    fileprivate enum Size: CGFloat {
        case padding10 = 10, button = 36
    }
    
    enum TypeHelp: Int {
        case tracking = 0
    }
    
    /**
     Data Array
     */
    
    
    let trackingArray: [(image: String, title: String, content: String)] = [
        
        (LocalizedString("help_image_booking_1"),
         LocalizedString("help_booking_title_1", comment: "Phóng to, thu nhỏ bản đồ"),
         LocalizedString("help_booking_content_1", comment: nil)),
        (LocalizedString("help_image_booking_2"),
         LocalizedString("help_booking_title_2", comment: "Thông tin theo thời gian thực"),
         LocalizedString("help_booking_content_2", comment: nil)),
        (LocalizedString("help_image_booking_3"),
         LocalizedString("help_booking_title_3", comment: "Sử dụng điều khiển lộ trình"),
         LocalizedString("help_booking_content_3", comment: nil)),
        (LocalizedString("help_image_booking_4"),
         LocalizedString("help_booking_title_4", comment: "Xem thông tin tại một điểm"),
         LocalizedString("help_booking_content_4", comment: nil))
    ]
    
    
    
    var dataArray: [(image: String, title: String, content: String)]!
    
    var typeHelp: TypeHelp = .tracking {
        didSet {
            switch typeHelp {
            case .tracking:
                dataArray = trackingArray
            }
        }
    }
    
    /**
     PageView
     */
    fileprivate var pageViewController:  UIPageViewController!
    
    /**
     Button Done
     */
    fileprivate var done: UIButton!
    
    /**
     Delegate
     */
    weak var delegate: HelpDetailsControllerDelegate?
    
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

//-------------------------------------------
//MARK: - PAGE VIEW DELEGATE
//-------------------------------------------

extension HelpDetailsViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        let index = (pendingViewControllers[0] as! HelpContentDetailsViewController).pageIndex
        animationScaleViewHide(done, hidden: !(index == dataArray.count - 1), completion: nil)
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers else { return }
        let index = (viewControllers[0] as! HelpContentDetailsViewController).pageIndex
        
        /**
         Nếu true = true hoặc false = false
         */
        if done.isHidden == (index == dataArray.count - 1)  {
            animationScaleViewHide(done, hidden: !done.isHidden, completion: nil)
        }
    }
}

//-------------------------------------------
//MARK: - PAGE VIEW DATA SOURCE
//-------------------------------------------
extension HelpDetailsViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? HelpContentDetailsViewController else { crashApp(message: "Help Content Details VC nil") }
        guard viewController.pageIndex != 0 else { return nil }
        return viewcontrollerAtIndex(viewController.pageIndex - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? HelpContentDetailsViewController else { crashApp(message: "Help Content Details VC nil") }
        guard viewController.pageIndex != dataArray.count - 1 else { return nil }
        return viewcontrollerAtIndex(viewController.pageIndex + 1)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return dataArray.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}


//-------------------------------------------
//MARK: - SELECTOR
//-------------------------------------------

extension HelpDetailsViewController {
    func done(_ sender: UIButton) {
        delegate?.helpDetailsControllerDidFinished()
    }
}


//-------------------------------------
// MARK: - SELECTOR
//-------------------------------------
extension HelpDetailsViewController {
    
}

//-------------------------------------------
//MARK: - PRIVATE METHOD
//-------------------------------------------
extension HelpDetailsViewController {
    
    /**
     Khởi tạo Page View
     */
    func viewcontrollerAtIndex(_ index: Int) -> HelpContentDetailsViewController {
        let content = HelpContentDetailsViewController()
        content.data = dataArray[index]
        content.pageIndex = index
        return content
    }
    
    /**
     Scale View
     */
    fileprivate func animationScaleViewHide(_ view: UIView, hidden: Bool, duration: TimeInterval = 0.4, completion: ((Bool) -> Void)? = nil) {
        if !hidden && view.isHidden {
            view.isHidden = false
            view.alpha = 0.0
            view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1).concatenating(CGAffineTransform(translationX: CGFloat(self.dataArray.count * 7), y: 0))
        }
        
        UIView.animate(withDuration: duration, animations: { () -> Void in
            view.alpha = hidden ? 0.0 : 1.0
            view.transform = hidden ? CGAffineTransform(scaleX: 0.1, y: 0.1).concatenating(CGAffineTransform(translationX: CGFloat(self.dataArray.count * 7), y: 0)) : CGAffineTransform.identity
        }, completion: { (finished) -> Void in
            if hidden { view.isHidden = true }
            if let completion = completion {
                completion(true)
            }
        })
    }
    
}


//-------------------------------------
// MARK: - <#Delegate#> DELEGATE
//-------------------------------------
extension HelpDetailsViewController {
    
}

//-------------------------------------
// MARK: - SETUP
//-------------------------------------
extension HelpDetailsViewController {
    func setupAllSubviews() {
        view.backgroundColor = .white
        
        setupPageView()
        setupButton()
        
        let controllers: [UIViewController] = [viewcontrollerAtIndex(0)]
        pageViewController.setViewControllers(controllers, direction: .forward, animated: true, completion: nil)
        
    }
    
    func setupAllConstraints() {
        
        
    }
    
    fileprivate func setupPageView() {
        
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.Navigation.main.alpha(0.45)
        pageControl.currentPageIndicatorTintColor = UIColor.Navigation.main
        
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        pageViewController.didMove(toParentViewController: self)
        view.addSubview(pageViewController.view)
    }
    
    fileprivate func setupButton() {
        done = UIButton()
        done.backgroundColor = UIColor.white
        done.setTitle(LocalizedString("genenal_button_done", comment: "Xong").uppercased(), for: UIControlState())
        done.contentHorizontalAlignment = .center
        done.titleLabel?.font = UIFont(name: FontType.latoBold.., size: FontSize.normal..)
        done.setTitleColor(UIColor.Navigation.main, for: UIControlState())
        done.isHidden = true
        done.addTarget(self, action: #selector(self.done(_:)), for: .touchUpInside)
        view.addSubview(done)
    }
    
    fileprivate func setupFrameAllSubviews() {
        done.frame = CGRect(x: view.frame.width / 4 ,
                            y: view.frame.height - Size.button..,
                            width: view.frame.width / 2,
                            height: Size.button..)
    }
    
}
