//
//  SettingsCurrencyViewController.swift
//  Auction
//
//  Created by Q on 25/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit

class SettingsCurrencyViewController: UIViewController, SettingsCurrencyViewProtocol {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var navigationHeight: NSLayoutConstraint!
    
    var presenter: SettingsCurrencyPresenterProtocol?
    var settingSelectionCell = SettingSelectionCell()
    var dataArray = [[String : Any]]()
    var lastSelectedCell = IndexPath()

    override func viewWillAppear(_ animated: Bool) {
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = false
        } else {
            // Fallback on earlier versions
        }
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationHeight.constant = (navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height
        
        tableView.selectRow(at: IndexPath(row: UserDefaults.standard.integer(forKey: "lastSelectedCurrRow"), section: 0), animated: false, scrollPosition: .none)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SettingSelectionCell", bundle: nil), forCellReuseIdentifier: "SettingSelectionCell")
        tableView.remembersLastFocusedIndexPath = true
        tableView.tableFooterView = UIView()
        
        self.presenter?.interactor?.getCurrency()
    }
    
    // MARK: -
    // MARK: - Presenter Callback
    
    func setCurrency(data: Data) {
        tableView.reloadData()
    }
    
    func currencySelected() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: -
    // MARK: - Method's
    
    func changeCurrency(currency: Int) {
        let language = UserDefaults.standard.integer(forKey: "language")
        let notify = UserDefaults.standard.bool(forKey: "notify")
        
        let settingsUpdateRequest = SettingsUpdateRequest.init(currencyID: currency, languageID: language, notify: notify)
        let dict = try! settingsUpdateRequest.toDictionary()
        
        self.presenter?.interactor?.setUserCurrency(params: dict)
    }
    
    // MARK -
    // MARK - IBAction's
    
    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension SettingsCurrencyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataArray.isEmpty {
            return 2
        } else {
            return dataArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        settingSelectionCell = tableView.dequeueReusableCell(withIdentifier: "SettingSelectionCell") as! SettingSelectionCell
        
        let grView = GRView(frame: settingSelectionCell.bounds)
        grView.startColor = UIColor(red: 0.17, green: 0.4, blue: 0.98, alpha: 1.0)
        grView.endColor = UIColor(red: 0.17, green: 0.4, blue: 0.98, alpha: 1.0)
        grView.horizontalMode = true
        settingSelectionCell.selectedBackgroundView = grView
        
        settingSelectionCell.label?.text = String(indexPath.row)
        settingSelectionCell.label.textColor = .white
        
        tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        
        return settingSelectionCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath == lastSelectedCell {
            settingSelectionCell.label.textColor = .white
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! SettingSelectionCell
        currentCell.label.textColor = .white
        
        UserDefaults.standard.set(indexPath.row, forKey: "lastSelectedCurrRow")
        
        let curr = indexPath.row + 1
        changeCurrency(currency: curr)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! SettingSelectionCell
        currentCell.label.textColor = Colours.placeholderTextColor
    }
}
