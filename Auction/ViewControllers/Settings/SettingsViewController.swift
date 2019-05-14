//
//  SettingsViewController.swift
//  Auction
//
//  Created by Q on 24/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, SettingsViewProtocol, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topTableViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var customTitle: UILabel!
    @IBOutlet var largeTitlePosY: NSLayoutConstraint!
    
    var presenter: SettingsPresenterProtocol?
    
    var settingsCategoryCell = SettingsCategoryCell()
    var isPopViewController = Bool()
    var defaults = UserDefaults.standard
    var dataArray = [String : Any]()
    var userSettingsModel = UserSettingsResponse(dictionary: [:])
    var topSpaceTableView: CGFloat = 0.0

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "SettingsCategoryCell", bundle: nil), forCellReuseIdentifier: "SettingsCategoryCell")
        
        self.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        isPopViewController = (UserDefaults.standard.object(forKey: "isPopViewController") != nil)
        
        if (!isPopViewController) {
            self.tableView.alpha = 0.0
            self.topTableViewConstraint.constant = 1000.0
        } else {
            customTitle.alpha = 1.0
        }
    
        self.presenter?.interactor?.getUserSettings()
    }
    
    override func viewWillLayoutSubviews() {
        
        switch UIScreen.main.nativeBounds.height {
        case 1136:  //.iPhones_5_5s_5c_SE
            self.customTitle.font =  UIFont(name: "Exo2.0-Medium", size: 42.0)
        case 1334:  //.iPhones_6_6s_7_8
            break
        default:
            topSpaceTableView = 64.0
            largeTitlePosY.constant = 94.0
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            if (!self.isPopViewController) {
                UIView.animate(withDuration: 0.5, animations: {
                    self.topTableViewConstraint.constant = self.topSpaceTableView
                    self.view.layoutSubviews()
                })
            
                UIView.animate(withDuration: 0.8, animations: {
                    self.customTitle.alpha = 1.0
                    self.tableView.alpha = 1.0
                })
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.customTitle.alpha = 0.0
    }

    func setupViews() {
        let navigationBarHeight: CGFloat = UIScreen.main.bounds.height/2.47037037
        let backgroundImage = UIImageView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: navigationBarHeight))
        backgroundImage.image = UIImage.init(named: "ic_background_settings")
        view.addSubview(backgroundImage)
        view.bringSubviewToFront(self.customTitle)
        self.tableView.layer.zPosition = 1000
    }
    
    // MARK: API Calls
    func setUserSettings(userSettings: [String : Any]) {
        userSettingsModel = UserSettingsResponse.init(dictionary: userSettings)
        UserDefaults.standard.set(userSettingsModel.currency, forKey: "userCurrency")
        UserDefaults.standard.set(userSettingsModel.language, forKey: "userLanguage")
        tableView.reloadData()
    }
    
    func hasLogout() {
        UserDefaults.standard.removeObject(forKey: "token")
        let authorizationViewController = AuthorizationRouter.createModule()
        self.navigationController?.pushViewController(authorizationViewController, animated: true)
    }
    
    // MARK: TableView Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 296.0
    }
    
    // MARK: headerView
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 52.0))
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            if (UIScreen.main.nativeBounds.height == 1136) {
                return 124.0
            } else {
                return 160.0
            }
        }
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        settingsCategoryCell = tableView.dequeueReusableCell(withIdentifier: "SettingsCategoryCell") as! SettingsCategoryCell
        settingsCategoryCell.selectionStyle = .none
        
        //add Actions
        settingsCategoryCell.languageButton.addTarget(self,action:#selector(self.languageButtonAction(_:)), for:.touchUpInside)
        settingsCategoryCell.currencyButton.addTarget(self,action:#selector(self.currencyButtonAction(_:)), for:.touchUpInside)
        settingsCategoryCell.logoutButton.addTarget(self,action:#selector(self.logoutButtonAction(_:)), for:.touchUpInside)
 
        if (userSettingsModel.language != "") {
            settingsCategoryCell.languageLabel.text = userSettingsModel.language
        }
        
        if (userSettingsModel.currency != "") {
            settingsCategoryCell.currencyLabel.text = userSettingsModel.currency
        }
        
        return settingsCategoryCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped section number \(indexPath.section).")
    }
    
    //cell Actions
    @objc func languageButtonAction(_ sender: UITapGestureRecognizer) {
        let settingsLanguageViewController = SettingsLanguageRouter.createModule()
        self.navigationController?.pushViewController(settingsLanguageViewController, animated: true)
    }
    
    @objc func currencyButtonAction(_ sender: UITapGestureRecognizer) {
        let settingsCurrencyViewController = SettingsCurrencyRouter.createModule()
        self.navigationController?.pushViewController(settingsCurrencyViewController, animated: true)
    }
    
    @objc func logoutButtonAction(_ sender: UITapGestureRecognizer) {
        self.presenter?.interactor?.removeToken()
    }
}
