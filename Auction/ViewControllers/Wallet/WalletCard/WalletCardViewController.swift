//
//  WalletCardViewController.swift
//  Auction
//
//  Created by Q on 26/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit

class WalletCardViewController: UIViewController, WalletCardViewProtocol, UITableViewDelegate, UITableViewDataSource, CardButtonDelegate, ActionCellButtonDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    var presenter: WalletCardPresenterProtocol?
    
    var cardCell = CardCell()
    var actionsCell = ActionsCell()
    let addingCardViewController = AddingCardRouter.createModule()
    
    let defaults = UserDefaults.standard
    var viewDidScrolled = Bool()
    var scrollFromBalance = Bool()
    var topConstraintMovement = CGFloat()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "CardCell", bundle: nil), forCellReuseIdentifier: "CardCell")
        self.tableView.register(UINib(nibName: "ActionsCell", bundle: nil), forCellReuseIdentifier: "ActionsCell")
        self.tableView.register(UINib(nibName: "ActionsCell", bundle: nil), forCellReuseIdentifier: "ActionsCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.tableView.tableFooterView = UIView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 120.0))
        
        viewDidScrolled = (defaults.object(forKey: "viewDidScrolled") != nil)
        scrollFromBalance = (defaults.object(forKey: "scrollFromBalance") != nil)
        
        if (self.viewDidScrolled) {
            tableView.alpha = 1.0
            topConstraint.constant = topConstraintMovement
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
    }

    override func viewDidDisappear(_ animated: Bool) {
        DispatchQueue.main.async {
            if (self.scrollFromBalance) {
                self.tableView.alpha = 0.0
                self.topConstraint.constant = 1000.0
            }
        }
    }
    
    // MARK: CardButtonDelegate method
    func addCardButtonClicked() {
        self.present(addingCardViewController, animated: true, completion: nil)
    }
    
    // MARK: ActionCell button delegate
    
    func replenishButtonClicked() {
        let replenishViewController = ReplenishRouter.createModule()
        self.present(replenishViewController, animated: true, completion: nil)
    }
    
    func changeCardButtonClicked() {
        self.present(addingCardViewController, animated: true, completion: nil)
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
            return 124.0
        default:
            return 44.0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 180.0
        default:
            return 146.0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cardCell = tableView.dequeueReusableCell(withIdentifier: "CardCell") as! CardCell
        cardCell.selectionStyle = .none
        cardCell.delegate = self
        
        actionsCell = tableView.dequeueReusableCell(withIdentifier: "ActionsCell") as! ActionsCell
        actionsCell.selectionStyle = .none
        actionsCell.delegate = self
        
        switch indexPath.section {
        case 1:
            return actionsCell
        default:
            return cardCell
        }
    }
    
    // MARK: TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped section number \(indexPath.section).")
    }
}
