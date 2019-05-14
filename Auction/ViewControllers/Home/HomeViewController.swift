//
//  HomeViewController.swift
//  Auction
//
//  Created by Q on 18/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit
import Alamofire

protocol SearchTextFieldDelegate: AnyObject {
    func beginSearchByText(text: String)
    func switchItemCellStyle(_ sender: UIButton)
}

class HomeViewController: UIViewController, HomeViewProtocol, UIScrollViewDelegate, UIPageViewControllerDelegate, UIPageViewControllerDataSource, UITextFieldDelegate {

    @IBOutlet weak var containerBarView: UIView!
    @IBOutlet weak var containerBarHeight: NSLayoutConstraint!
    @IBOutlet private weak var btnTab1: UIButton!
    @IBOutlet private weak var btnTab2: UIButton!
    @IBOutlet private weak var btnTab3: UIButton!
    @IBOutlet private weak var viewLine: UIView!
    @IBOutlet weak var btnTab1constantLeft: NSLayoutConstraint!
    @IBOutlet weak var spaceBetweenTabs: NSLayoutConstraint!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var switchStyleButton: UIButton!
    @IBOutlet var searchTextField: UITextField!
    
    var presenter: HomePresenterProtocol?
    
    weak var searchTextFieldDelegate: SearchTextFieldDelegate?
    
    private var pageController: UIPageViewController!
    private var arrVC:[UIViewController] = []
    private var currentPage: Int!
    
    var tab1VC = NewAuctionsRouter.createModule()
    var tab2VC = ClosedAuctionsRouter.createModule()
    var tab3VC = ProfileRouter.createModule()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentPage = 0
        
        createPageViewController()
        
        switchStyleButton.setImage(UIImage.init(named: "ic_switch_style2_button"), for: .selected)
        searchButton.setImage(UIImage.init(named: "ic_search_button_active"), for: .selected)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillLayoutSubviews() {
        let tabSpace = (UIScreen.main.bounds.width - (btnTab1.frame.width + btnTab2.frame.width + btnTab3.frame.width)) / 3
        btnTab1constantLeft.constant = tabSpace
        spaceBetweenTabs.constant = tabSpace
        
        switch UIScreen.main.nativeBounds.height {
        case 1136:  //.iPhones_5_5s_5c_SE
            break
        case 1334:  //.iPhones_6_6s_7_8
            break
        case 1792:  //.iPhone_XR
            self.containerBarHeight.constant = 126.0
            self.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 34)
            break
        case 1920, 2208:  //.iPhones_6Plus_6sPlus_7Plus_8Plus
            break
        case 2436:  //.iPhones_X_XS
            self.containerBarHeight.constant = 126.0
            self.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 34)
            break
        case 2688://.iPhone_XSMax
            self.containerBarHeight.constant = 126.0
            self.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 34)
            break
        default:
            break
        }
    }
    
    //MARK: - Custom Methods
    private func selectedButton(btn: UIButton) {
        btn.setTitleColor(Colours.placeholderTextColor, for: .normal)

        UIView.animate(withDuration: 0.3, animations: {
            self.viewLine.center.x = btn.center.x
            self.view.layoutSubviews()
        })
    }
    
    private func unSelectedButton(btn: UIButton) {
        btn.setTitleColor(UIColor.lightGray, for: UIControl.State.normal)
    }
    
    //MARK: - IBaction Methods
    @IBAction private func btnOptionClicked(btn: UIButton) {
        pageController.setViewControllers([arrVC[btn.tag]], direction: UIPageViewController.NavigationDirection.reverse, animated: false, completion: {(Bool) -> Void in
        })
    
        resetTabBarForTag(tag: btn.tag)
    }
    
    @IBAction func searchButtonAction(_ sender: Any) {
        if (searchButton.tag == 0) {
            UIView.animate(withDuration: 0.3, animations: {
                self.searchButton.center.x = self.switchStyleButton.center.x
                self.searchButton.isSelected = true
                self.switchStyleButton.alpha = 0.0

                self.view.layoutSubviews()
            })
            searchButton.tag = 1

            searchTextField.becomeFirstResponder()
        } else {
            searchButton.tag = 0
            endEditingGesture(sender)
        }
    }
    
    @IBAction func switchButtonAction(_ sender: UIButton) {
        if (switchStyleButton.tag == 0) {
            switchStyleButton.isSelected = true
            switchStyleButton.tag = 1
        } else {
            switchStyleButton.isSelected = false
            switchStyleButton.tag = 0
        }
        searchTextFieldDelegate?.switchItemCellStyle(sender)
    }
    
    @IBAction func endEditingGesture(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.searchButton.frame.origin.x = self.switchStyleButton.frame.origin.x - self.searchButton.frame.width - 18.0
            self.searchButton.isSelected = false
            self.switchStyleButton.alpha = 1.0
            
            self.view.layoutSubviews()
        })
        
        self.view.endEditing(true)
    }
    
    //MARK: - CreatePagination
    private func createPageViewController() {
        pageController = UIPageViewController.init(transitionStyle: UIPageViewController.TransitionStyle.scroll, navigationOrientation: UIPageViewController.NavigationOrientation.horizontal, options: nil)
        
        pageController.view.backgroundColor = UIColor.clear
        pageController.delegate = self
        pageController.dataSource = self
        
        for svScroll in pageController.view.subviews as! [UIScrollView] {
            svScroll.delegate = self
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.pageController.view.frame = CGRect(x: 0, y: self.containerBarView.frame.size.height, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - self.containerBarView.frame.size.height - 64.0)
        }
        
        let newAuctionsViewController = NewAuctionsRouter.createModule()
        let closedAuctionsViewController = ClosedAuctionsRouter.createModule()
        let profileViewController = ProfileRouter.createModule()

        tab1VC = newAuctionsViewController
        tab2VC = closedAuctionsViewController
        tab3VC = profileViewController

        arrVC = [tab1VC, tab2VC, tab3VC]
        
        pageController.setViewControllers([tab1VC], direction: UIPageViewController.NavigationDirection.forward, animated: false, completion: nil)
        
        self.addChild(pageController)
        self.view.addSubview(pageController.view)
        self.view.layoutSubviews()
        pageController.didMove(toParent: self)
    }
    
    
    private func indexofviewController(viewCOntroller: UIViewController) -> Int {
        if(arrVC .contains(viewCOntroller)) {
            return arrVC.index(of: viewCOntroller)!
        }
        
        return -1
    }
    
    //MARK: - Pagination Delegate Methods
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = indexofviewController(viewCOntroller: viewController)
        
        if(index != -1) {
            index = index - 1
        }
        
        if(index < 0) {
            return nil
        }
        else {
            return arrVC[index]
        }
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = indexofviewController(viewCOntroller: viewController)
        
        if(index != -1) {
            index = index + 1
        }
        
        if(index >= arrVC.count) {
            return nil
        }
        else {
            return arrVC[index]
        }
        
    }
    
    func pageViewController(_ pageViewController1: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if(completed) {
            currentPage = arrVC.index(of: (pageViewController1.viewControllers?.last)!)
            
            resetTabBarForTag(tag: currentPage)
        }
    }
    
    //MARK: - Set Top bar after selecting Option from Top Tabbar
    private func resetTabBarForTag(tag: Int) {
        
        var sender: UIButton!
        
        if(tag == 0) {
            sender = btnTab1
        }
        else if(tag == 1) {
            sender = btnTab2
        }
        else if(tag == 2) {
            sender = btnTab3
        }
        
        currentPage = tag
        
        unSelectedButton(btn: btnTab1)
        unSelectedButton(btn: btnTab2)
        unSelectedButton(btn: btnTab3)
        
        selectedButton(btn: sender)
    }
    
    // UITextField Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        searchTextFieldDelegate?.beginSearchByText(text: textField.text ?? "")
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.placeholder = "    Search"
    }
}
