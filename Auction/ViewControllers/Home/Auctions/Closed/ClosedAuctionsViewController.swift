//
//  ClosedAuctionsViewController.swift
//  Auction
//
//  Created by Q on 21/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit

class ClosedAuctionsViewController: UIViewController, ClosedAuctionsViewProtocol, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
     var presenter: ClosedAuctionsPresenterProtocol?
    
    var largeTitleCell = LargeTitleCell()
    var itemWithButtonCell = ItemWithButtonCell()
    var closedLotModel = [ClosedLotResponse]()
    
    override func viewWillLayoutSubviews() {
        self.tableView.tableFooterView = UIView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 52.0))
        self.tableView.tableFooterView?.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "LargeTitleCell", bundle: nil), forCellReuseIdentifier: "LargeTitleCell")
        self.tableView.register(UINib(nibName: "ItemWithButtonCell", bundle: nil), forCellReuseIdentifier: "ItemWithButtonCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.presenter?.interactor?.getClosedLots()
    }
    
    // MARK: API Call
    func updateClosedTokens(closedLots: NSArray) {
        for dict in closedLots {
            closedLotModel.append(ClosedLotResponse.init(dictionary: dict as! [String : Any]))
        }
        tableView.reloadSections(IndexSet(integer: 1), with: .bottom)
    }
    
    func showEmptyLotsError() {
        
    }
    
    // MARK: TableView Delegate
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 20))
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return 1//closedLotModel.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 1:
            return 145.0
        default:
            return 120.0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            return 20.0
        default:
            return 0.0
        }
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        largeTitleCell = tableView.dequeueReusableCell(withIdentifier: "LargeTitleCell") as! LargeTitleCell
        largeTitleCell.selectionStyle = .none
        
        itemWithButtonCell = tableView.dequeueReusableCell(withIdentifier: "ItemWithButtonCell") as! ItemWithButtonCell
        itemWithButtonCell.selectionStyle = .none
        itemWithButtonCell.button.backgroundColor = .white
        itemWithButtonCell.button.setTitleColor(Colours.mainBlueColor, for: .normal)
        itemWithButtonCell.button.titleLabel?.adjustsFontSizeToFitWidth = true
        itemWithButtonCell.button.titleLabel?.numberOfLines = 2
        itemWithButtonCell.button.titleLabel?.textAlignment = .center
        itemWithButtonCell.itemImage.image = UIImage.init(named: "bid1")
        itemWithButtonCell.itemImage.contentMode = .scaleAspectFill

        if (closedLotModel.count > 0) {
            var buttonTitle: String = "Closed: \(closedLotModel[indexPath.row].startTime!)"
            buttonTitle = buttonTitle.replacingOccurrences(of: "T", with: "\n", options: NSString.CompareOptions.literal, range:nil)
            buttonTitle = buttonTitle.replacingOccurrences(of: "Z", with: "", options: NSString.CompareOptions.literal, range:nil)
            itemWithButtonCell.button.setTitle(buttonTitle, for: .normal)
            itemWithButtonCell.title.text = closedLotModel[indexPath.row].lotName
            itemWithButtonCell.price.text = closedLotModel[indexPath.row].startPrice
            
            if (closedLotModel[indexPath.row].mainImage != "/media/default.png") {
                let url = URL(string: URLs.baseUrl + closedLotModel[indexPath.row].mainImage!)
                itemWithButtonCell.itemImage.af_setImage(withURL: url!)
            } else {
                //FAKE
                //itemWithButtonCell.itemImage.image = UIImage.init()
            }
        }
        
        switch indexPath.section {
        case 1:
            return itemWithButtonCell
        default:
            return largeTitleCell
        }
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped section number \(indexPath.section).")
    }
}

