//
//  ItemPageViewController.swift
//  Auction
//
//  Created by Q on 19/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit
import CountdownLabel
import ImageSlideshow
import SocketIO

class ItemPageViewController: UIViewController, ItemPageViewProtocol, UITableViewDelegate, UITableViewDataSource, CountdownLabelDelegate {

    var presenter: ItemPagePresenterProtocol?
    
    @IBOutlet weak var tableView: UITableView!
    
    var modalView = CustomModalView()
    var itemCell = ItemCell()
    var descriptionCell = DescriptionCell()
    var notificationCell = NotificationCell()
    var emptyCell = EmptyCell()
    var betCell = BetCell()
    var customBarView = CustomBottomBar()
    var countdownLabel = CountdownLabel()
    var middleButton = UIButton()
    var barHeight : CGFloat = 64.0
    var startedLot = [String : Any]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.tintColor = Colours.placeholderTextColor
        
        self.createBottomBar()
        
        self.middleButton.addTarget(self,action:#selector(middleButtonAction(_:)), for:.touchUpInside)
        
        self.modalView.removeFromSuperview()
    
        self.middleButton.tag = 0
        
        if (UserDefaults.standard.object(forKey: "startedLot") != nil) {
            startedLot = UserDefaults.standard.object(forKey: "startedLot") as! [String : Any]
        }
        
        self.tableView.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        self.tableView.tableFooterView = UIView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 52.0))
        self.tableView.tableFooterView?.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //WebSocket Adding
        let manager = SocketManager(socketURL: URL(string: URLs.wsUrl)!, config: [.reconnects(true)])
        let socket = manager.defaultSocket
        
        //addSocketHandlers()
        socket.connect()
        
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        self.tableView.register(UINib(nibName: "DescriptionCell", bundle: nil), forCellReuseIdentifier: "DescriptionCell")
        self.tableView.register(UINib(nibName: "NotificationCell", bundle: nil), forCellReuseIdentifier: "NotificationCell")
        self.tableView.register(UINib(nibName: "EmptyCell", bundle: nil), forCellReuseIdentifier: "EmptyCell")
        self.tableView.register(UINib(nibName: "BetCell", bundle: nil), forCellReuseIdentifier: "BetCell")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        itemCell.timerLabel.text = ""
        itemCell.timerLabel.setCountDownTime(minutes: 0.0)
        self.modalView.removeFromSuperview()
        self.customBarView.removeFromSuperview()
    }
    
    // MARK: Custom bottom bar
    
    func createBottomBar() {
        //To support UI for iPhone X
        if (UIScreen.main.nativeBounds.height > 1500.0) {
            barHeight = 84.0
        }
        
        //Adding Bar
        customBarView = CustomBottomBar(frame:CGRect(x: 0.0,
                                                     y: UIScreen.main.bounds.height - barHeight,
                                                 width: UIScreen.main.bounds.width,
                                                height: barHeight))
        
        middleButton = UIButton(frame: customBarView.middleButton.frame)
        
        self.view.addSubview(middleButton)
        self.view.addSubview(customBarView)
        
        customBarView.isUserInteractionEnabled = false
        middleButton.isUserInteractionEnabled = false
    }
    
    @objc func middleButtonAction(_ sender: UITapGestureRecognizer) {
        middleButton.tag = 2
        
        customBarView.setCircleLayer()
        
        let timerLabelWidth: CGFloat = 37.0
        let timerLabelHeight: CGFloat = 46.0
        
        let countdownLabel = CountdownLabel(frame: CGRect(x: customBarView.middleButton.center.x - timerLabelWidth/2,
                                                          y: customBarView.middleButton.center.y - timerLabelHeight/2,
                                                          width: timerLabelWidth,
                                                          height: timerLabelHeight))
        countdownLabel.font = UIFont(name:"Exo2.0-Medium", size: 32.0)
        countdownLabel.tintColor = Colours.mainBlueColor
        countdownLabel.textAlignment = .center
        countdownLabel.countdownDelegate = self
        countdownLabel.setCountDownTime(minutes: 30)
        countdownLabel.animationType = .Evaporate
        countdownLabel.start()
        countdownLabel.timeFormat = "ss"
        customBarView.addSubview(countdownLabel)
    
        self.tableView.reloadSections([0, 1], with: .automatic)
    }
    
    @IBAction func congratsViewButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: TableView Delegate
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 20))
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 16.0
        default:
            return 0.0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return 1
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 320.0
        case 1:
            if (middleButton.tag == 1) {
                return 108.0
            } else if (middleButton.tag == 2) {
                return 134.0
            } else {
                return 0.0
            }
        default:
            return 220.0
        }
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        itemCell = tableView.dequeueReusableCell(withIdentifier: "ItemCell") as! ItemCell
        itemCell.selectionStyle = .none
        
        //set images to SlideShow
//        let slideImage = UIImageView()
////        let imageUrl: String = startedLot["mainImage"] as! String
////        if (imageUrl != "/media/default.png") {
////            let url = URL(string: URLs.baseUrl + imageUrl)
////            slideImage.af_setImage(withURL: url!)
////        }
//
//        itemCell.slideShowView.setImageInputs([
//            ImageSource(image: slideImage.image!)
//            //            AlamofireSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080"),
//            //            KingfisherSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080"),
//            //            ParseSource(file: PFFile(name:"image.jpg", data:data))
//            ])
        
        switch middleButton.tag {
        case 0:
            itemCell.timerLabel.countdownDelegate = self
            itemCell.timerLabel.setCountDownTime(minutes: 5)
            itemCell.timerLabel.font = UIFont(name:"Exo2.0-Regular", size: 24.0)
            itemCell.timerLabel.animationType = .Evaporate
            itemCell.timerLabel.start()
        case 1:
            itemCell.timerLabel.cancel()
            itemCell.timerLabel.text = "STARTED"
            itemCell.timerLabel.font = UIFont(name:"Exo2.0-Medium", size: 16.0)
            middleButton.isUserInteractionEnabled = true
        case 2:
            middleButton.isUserInteractionEnabled = false
            itemCell.timerLabel.setCountDownTime(minutes: 30)
            itemCell.timerLabel.timeFormat = "ss"
            //itemCell.timerLabel.countdownAttributedText = CountdownAttributedText(text: "HERE sec.", replacement: "HERE")
            itemCell.timerLabel.animationType = .Evaporate
            itemCell.timerLabel.start()
            
            betCell = tableView.dequeueReusableCell(withIdentifier: "BetCell") as! BetCell
            betCell.selectionStyle = .none
        default:
            break
        }
        
        descriptionCell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell") as! DescriptionCell
        descriptionCell.selectionStyle = .none
        
        notificationCell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell") as! NotificationCell
        notificationCell.selectionStyle = .none
        
        emptyCell = tableView.dequeueReusableCell(withIdentifier: "EmptyCell") as! EmptyCell
        emptyCell.selectionStyle = .none
        
        switch indexPath.section {
        case 0:
            return itemCell
        case 1:
            if (middleButton.tag == 1) {
                return notificationCell
            } else if (middleButton.tag == 2) {
                return betCell
            } else {
                return emptyCell
            }
        case 2:
            return descriptionCell
        default:
            return emptyCell
        }
    }
    
    @objc func modalViewButtonAction(_ sender: UITapGestureRecognizer) {
        self.modalView.removeFromSuperview()
        
        self.navigationController?.popViewController(animated: true)
    }
    
    //Timer Finished
    func countdownFinished() {
        switch middleButton.tag {
        case 0:
            middleButton.tag = 1
            
            customBarView.setMiddleButtonBlue()

            self.tableView.reloadRows(at: [NSIndexPath(row: 0, section: 1) as IndexPath], with: .automatic)
        case 1:
            middleButton.isUserInteractionEnabled = true
            
            countdownLabel.cancel()
            
            customBarView.setMiddleButtonBlue()
            
            self.tableView.reloadRows(at: [NSIndexPath(row: 0, section: 0) as IndexPath], with: .automatic)
        default:
            itemCell.timerLabel.cancel()
            
            self.customBarView.isHidden = true
            
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            //Call modalView
            self.modalView = .init(frame: UIScreen.main.bounds)
            self.modalView.button.addTarget(self,action:#selector(self.modalViewButtonAction(_:)), for:.touchUpInside)
            self.view.addSubview(self.modalView)
        }
    }
}

