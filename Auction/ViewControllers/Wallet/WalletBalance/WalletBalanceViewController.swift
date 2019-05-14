//
//  WalletBalanceViewController.swift
//  Auction
//
//  Created by Q on 26/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit

class WalletBalanceViewController: UIViewController, WalletBalanceViewProtocol, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    var presenter: WalletBalancePresenterProtocol?
    
    var balanceCell = BalanceCell()
    var historyCell = HistoryCell()
    var noPurchaseCell = NoPurchaseCell()
    let defaults = UserDefaults.standard
    var viewDidScrolled = Bool()
    var topConstraintMovement = CGFloat()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "BalanceCell", bundle: nil), forCellReuseIdentifier: "BalanceCell")
        self.tableView.register(UINib(nibName: "HistoryCell", bundle: nil), forCellReuseIdentifier: "HistoryCell")
        self.tableView.register(UINib(nibName: "NoPurchaseCell", bundle: nil), forCellReuseIdentifier: "NoPurchaseCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.tableView.tableFooterView = UIView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 52.0))
        
        viewDidScrolled = (defaults.object(forKey: "viewDidScrolled") != nil)
        
        if (!viewDidScrolled) {
            self.tableView.alpha = 0.0
            self.topConstraint.constant = 1000.0
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        switch UIScreen.main.nativeBounds.height {
        case 1136: //.iPhone_5s_SE
            topConstraintMovement = 0.0
        case 1334: //.iPhones_6_6s_7_8
            topConstraintMovement = 50.0
        case 1920, 2208: //.iPhones_6Plus_6sPlus_7Plus_8Plus
            topConstraintMovement = 50.0
        default:
            topConstraintMovement = 90.0
        }
        
        DispatchQueue.main.async {
            if (!self.viewDidScrolled) {
                UIView.animate(withDuration: 0.5, animations: {
                    self.topConstraint.constant = self.topConstraintMovement
                    self.view.layoutSubviews()
                })
                
                UIView.animate(withDuration: 0.8, animations: {
                    self.tableView.alpha = 1.0
                })
            }
        }
        defaults.set(true, forKey: "viewDidScrolled")
        defaults.set(true, forKey: "scrollFromBalance")
    }
    
    // MARK: UITableView DataSource

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 52.0))
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 162.0
        case 1:
            return 38.0
        default:
            return 20.0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 110.0
        default:
            return 98.0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        balanceCell = tableView.dequeueReusableCell(withIdentifier: "BalanceCell") as! BalanceCell
        balanceCell.selectionStyle = .none
    
        historyCell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell") as! HistoryCell
        historyCell.selectionStyle = .none
        
        noPurchaseCell = tableView.dequeueReusableCell(withIdentifier: "NoPurchaseCell") as! NoPurchaseCell
        noPurchaseCell.selectionStyle = .none
        
        switch indexPath.section {
        case 1:
            return historyCell
        case 2:
            return noPurchaseCell
        default:
            return balanceCell
        }
    }
    
    // MARK: TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped section number \(indexPath.section).")
    }
}
