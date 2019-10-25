//
//  BlockedUsersVC.swift
//  MoTiv
//
//  Created by Deftsoft on 06/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class BlockedUsersVC: BaseVC {
    
    //MARK:- IBOutlets
    @IBOutlet weak var searchBaseView: UIView!
    @IBOutlet weak var searchTextField: TextField!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    
    //MARLK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.customUI()
    }
    
    //MARK:- Private func
    func customUI(){
        setTitle(title: kBlockedUsers)
        self.searchBaseView.set(radius: 14.0)
    }
    
    //MARK:- IBAction
    
    @IBAction func textFieldDidChange(_ sender: TextField) {
        switch sender {
        case searchTextField:
            searchTextField.rightImage = searchTextField.text!.count > 0 ? #imageLiteral(resourceName: "searchSelected") : #imageLiteral(resourceName: "searchUnSelected")
            searchTextField.text!.count > 0 ? searchBaseView.setShadow(): searchBaseView.removeShadow()
            break
        default:
            break
        }
    }
    
}

//MARK:- UITableViewDelegate
extension BlockedUsersVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kBlockedUSerTableViewCell) as!BlockedUSerTableViewCell
        return cell
    }
    
}

//MARK:- UITableViewDataSource
extension BlockedUsersVC: UITableViewDataSource {
    

}
