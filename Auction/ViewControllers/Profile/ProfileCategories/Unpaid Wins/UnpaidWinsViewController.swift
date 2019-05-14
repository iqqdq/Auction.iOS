//
//  UnpaidWinsViewController.swift
//  Auction
//
//  Created by Q on 12/01/2019.
//  Copyright © 2019 Oxbee. All rights reserved.
//

import UIKit

class UnpaidWinsViewController: UIViewController, UnpaidWinsViewProtocol, UITableViewDelegate, UITableViewDataSource, BiggerCellButtonDelegate {

    var presenter: UnpaidWinsPresenterProtocol?

    @IBOutlet var tableView: UITableView!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var backButtonTitle: UILabel!
    
    var biggerItemWithButtonCell = BiggerItemWithButtonCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "BiggerItemWithButtonCell", bundle: nil), forCellReuseIdentifier: "BiggerItemWithButtonCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: BiggerCell Delegate
    
    func openBiggerItemPageViewController() {
//        self.presenter?.interactor?.getStartedLot(lotId: "\(lotModel[itemWithButtonCell.button.tag].id!)/")
    }
    
    func biggerCellStarButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
    
    // MARK: TableView Delegate & DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        biggerItemWithButtonCell = tableView.dequeueReusableCell(withIdentifier: "BiggerItemWithButtonCell") as! BiggerItemWithButtonCell
        biggerItemWithButtonCell.delegate = self
        biggerItemWithButtonCell.selectionStyle = .none
        biggerItemWithButtonCell.button.tag = indexPath.row
        biggerItemWithButtonCell.starButton.tag = indexPath.row
        
//        if (lotModel.count > 0) {
//            biggerItemWithButtonCell.title.text = lotModel[indexPath.row].lotName
//            biggerItemWithButtonCell.price.text = lotModel[indexPath.row].startPrice
//            biggerItemWithButtonCell.bets.text = ""
//
//            if (lotModel[indexPath.row].mainImage != "/media/default.png") {
//                let url = URL(string: URLs.baseUrl +  lotModel[indexPath.row].mainImage!)
//                biggerItemWithButtonCell.itemImage.af_setImage(withURL: url!)
//            } else {
//                biggerItemWithButtonCell.itemImage.image = UIImage.init()
//            }
//        }
        return biggerItemWithButtonCell
    }

    @IBAction func backButtonGesture(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
