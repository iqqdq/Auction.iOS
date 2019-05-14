//
//  SettingsLanguageViewController.swift
//  Auction
//
//  Created by Q on 25/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit

class SettingsLanguageViewController: UIViewController, SettingsLanguageViewProtocol, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: SettingsLanguagePresenterProtocol?
    
    var defaults = UserDefaults.standard
    var settingSelectionCell = SettingSelectionCell()
    var dataArray = [[String : Any]]()
    var lastSelectedCell = IndexPath()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "SettingSelectionCell", bundle: nil), forCellReuseIdentifier: "SettingSelectionCell")
        self.tableView.tableFooterView = UIView()
        
        self.presenter?.interactor?.getLanguage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = false
        } else {
            // Fallback on earlier versions
        }
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.isTranslucent = false
        //backButton title
        self.navigationController?.navigationBar.topItem?.title = "Language"
        self.navigationController?.navigationBar.tintColor = Colours.placeholderTextColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Exo2.0-Medium", size: 22.0)!,NSAttributedString.Key.foregroundColor : Colours.placeholderTextColor]
        
        if (defaults.object(forKey: "lastSelectedLangRow") == nil) {
            defaults.set(0, forKey: "lastSelectedLangRow")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.set(true, forKey: "isPopViewController")
    }
    
    // MARK: API Calls
    func setLanguage(language: [String : Any]) {
        for (_, value) in language {
            dataArray = value as! [[String : Any]]
        }
        
        tableView.reloadData()
    }
    
    func languageSelected() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: TableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (!dataArray.isEmpty) {
            return dataArray.count
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56.0
    }
    
    // MARK: TableView DataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        settingSelectionCell = tableView.dequeueReusableCell(withIdentifier: "SettingSelectionCell") as! SettingSelectionCell
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = Colours.mainBlueColor
        settingSelectionCell.selectedBackgroundView = bgColorView
        
        if (!dataArray.isEmpty) {
            var languageDict = dataArray[indexPath.row]
            settingSelectionCell.label.text = languageDict["language"] as? String
            
            let lastRow: Int = defaults.object(forKey: "lastSelectedLangRow") as? Int ?? 0
            lastSelectedCell = IndexPath(row: lastRow, section: 0)
            tableView.selectRow(at: lastSelectedCell, animated: false, scrollPosition: .top)
        }
    
        return settingSelectionCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath == lastSelectedCell) {
            settingSelectionCell.label.textColor = .white
        }
    }
    
    // MARK: TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! SettingSelectionCell
        currentCell.label.textColor = .white
        
        defaults.set(indexPath.row, forKey: "lastSelectedLangRow")
        
        guard let currencyParameter = defaults.object(forKey: "userCurrency") else {
            return
        }
        
        guard let languageParameter = currentCell.label.text else {
            return
        }
        
        let language: [String : Any] = ["currency" : currencyParameter,
                                        "language" : languageParameter]
        
        print("send = \(language)")
        self.presenter?.interactor?.setUserLanguage(languageDictionary: language)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! SettingSelectionCell
        currentCell.label.textColor = Colours.placeholderTextColor
    }
}
