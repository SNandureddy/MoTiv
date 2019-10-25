//
//  InterestsVC.swift
//  MoTiv
//
//  Created by ios2 on 15/11/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

enum InterestScreen: String {
    case publicInterest = "PUBLIC INTERESTS"
    case musicInterest = "MUSIC INTERESTS"
}

import UIKit

class InterestsVC: BaseVC {
    
    //MARK:- IBOutlets
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    let interestArray = ["ALL","EDUCATION","DANCING","FESTIVALS","FILM & MEDIA","FOOD & DRINK","LGBTQ","MUSIC","RELIGION & SPRITUALITY"]
    var type: InterestScreen = .publicInterest
    
    //MARLK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.customUI()
    }
    
    //MARK:- Private func
    func customUI(){
        setTitle(title: type.rawValue)
        self.doneButton.setBackgroundImage(doneButton.graidentImage, for: .normal)
        self.doneButton.set(radius: 14.0)
    }
    
    //MARK:- IBAction
    @IBAction func doneButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: UITableview Datasource
extension InterestsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interestArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kInterestCell) as! InterestCell
        cell.interestNameLabel.text  = interestArray[indexPath.row]
         cell.tickImageView.isHidden = true
        if indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 3 {
            cell.tickImageView.isHidden = false
        }
        return cell
    }
    
}

//MARK: UItableview Delegates
extension InterestsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let detailvc = self.storyboard?.instantiateViewController(withIdentifier: kEventDetails) as! EventDetailVC
        //        self.navigationController?.show(detailvc, sender: self)
    }
}

