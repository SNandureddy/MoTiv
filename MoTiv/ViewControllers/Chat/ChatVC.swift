//
//  ChatVC.swift
//  KidzWatch
//
//  Created by ios28 on 13/04/18.
//  Copyright © 2018 ios28. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class ChatVC: BaseVC {
    
    //MARK: - IBOutlets
    @IBOutlet weak var messageTextContainer: UIView!
    @IBOutlet weak var messageTextContainerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var sendMessageButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageViewHeightConstraint: NSLayoutConstraint!
    
    
    //MARK: - Class life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customizeUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    //MARK: - Private function
    private func customizeUI() {
        setTitle(title: "USERNAME")
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
//        self.messageTextContainer.addBorder()
//        self.sendMessageButton.addBorder()
//        self.tableView.tableFooterView = UIView()
//        self.messageTextContainer.roundCorner()
//        self.sendMessageButton.roundCorner()
        self.messageTextView.textContainerInset = UIEdgeInsets(top: 7, left: 10, bottom: 0, right: 10)
    }
}

//MARK: - TableView DataSource
extension ChatVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            //sent message
            let cell = tableView.dequeueReusableCell(withIdentifier: kSendMessageCell) as! SendMessageCell
            return cell
        }
        else {
            //received message
            let cell = tableView.dequeueReusableCell(withIdentifier: kReceiveMessageCell) as! ReceiveMessageCell
            return cell
        }
    }
}


//MARK: - TextView delegate
extension ChatVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "ENTER MESSAGE..." {
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "ENTER MESSAGE..."
        }
    }
    
   
}
