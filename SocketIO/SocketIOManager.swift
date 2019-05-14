//
//  SocketIOManager.swift
//  Auction
//
//  Created by Q on 12/12/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit
import SocketIO

class SocketIOManager: NSObject {
//    static let sharedInstance = SocketIOManager()
//
//    let headers = ["Authorization" : "token \(UserDefaults.standard.object(forKey: "token")!)",
//    "Content-Type" : "application/x-www-form-urlencoded"]
//
//    let socket = SocketIOClient(manager: URLs.startedLots as! SocketManagerSpec, nsp: ["log": false,
//                                                              "reconnects": true,
//                                                              "reconnectAttempts": 1,
//                                                              "reconnectWait": 1,
//                                                              "Authorization": "token \(UserDefaults.standard.object(forKey: "token")!)"
//                                                            x])
//
//    override init() {
//        super.init()
//    }
//
//
//    func establishConnection() {
//        socket.connect()
//    }
//
//
//    func closeConnection() {
//        socket.disconnect()
//    }
//
//
//    func connectToServerWithNickname(nickname: [AnyObject], completionHandler: (_ userList: [[String: AnyObject]]?) -> Void) {
//        socket.emit("connectUser", with: nickname)
//
//        socket.on(event: "userList") { ( dataArray, ack) -> Void in
//            completionHandler(dataArray[0] as! [[String: AnyObject]])
//        }
//
//        listenForOtherMessages()
//    }
//
//
//    func exitChatWithNickname(nickname: [AnyObject], completionHandler: () -> Void) {
//        socket.emit(event: "exitUser", withItems: nickname)
//        completionHandler()
//    }
//
//
//    func sendMessage(message: String, withNickname nickname: String) {
//        socket.emit(event: "chatMessage", withItems, message)
//    }
//
//
//    func getChatMessage(completionHandler: (_ messageInfo: [String: AnyObject]) -> Void) {
//        socket.on(event: "newChatMessage") { (dataArray, socketAck) -> Void in
//            var messageDictionary = [String: AnyObject]()
//            messageDictionary["nickname"] = dataArray[0] as! AnyObject
//            messageDictionary["message"] = dataArray[1] as! AnyObject
//            messageDictionary["date"] = dataArray[2] as! AnyObject
//
//            completionHandler(messageDictionary)
//        }
//    }
//
//
//    private func listenForOtherMessages() {
//        socket.on(event: "userConnectUpdate") { (dataArray, socketAck) -> Void in
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "userWasConnectedNotification"), object: dataArray[0] as! [String: AnyObject])
//        }
//
//        socket.on(event: "userExitUpdate") { (dataArray, socketAck) -> Void in
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "userWasDisconnectedNotification"), object: dataArray[0] as! String)
//        }
//
//        socket.on(event: "userTypingUpdate") { (dataArray, socketAck) -> Void in
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "userTypingNotification"), object: dataArray[0] as? [String: AnyObject])
//        }
//    }
//
//
//    func sendStartTypingMessage(nickname: [AnyObject]) {
//        socket.emit(event: "startType", withItems: nickname)
//    }
//
//
//    func sendStopTypingMessage(nickname: [AnyObject]) {
//        socket.emit(event: "stopType", withItems: nickname)
//    }
}
