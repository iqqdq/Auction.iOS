//
//  BiddingHistoryViewController.swift
//  Auction
//
//  Created by Q on 12/01/2019.
//  Copyright © 2019 Oxbee. All rights reserved.
//

import UIKit

class BiddingHistoryViewController: UIViewController, BiddingHistoryViewProtocol, UITableViewDelegate, UITableViewDataSource {

    var presenter: BiddingHistoryPresenterProtocol?

    @IBOutlet var tableView: UITableView!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var backButtonTitle: UILabel!
    
    var biddingHistoryCell = BiddingHistoryCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //init tableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "BiddingHistoryCell", bundle: nil), forCellReuseIdentifier: "BiddingHistoryCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: TableView Delegate & DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 24
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        biddingHistoryCell = tableView.dequeueReusableCell(withIdentifier: "BiddingHistoryCell") as! BiddingHistoryCell
        biddingHistoryCell.selectionStyle = .none
        
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
        return biddingHistoryCell
    }
    
    @IBAction func backButtonGesture(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
