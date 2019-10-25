//
//  ProfileVC.swift
//  MoTiv
//
//  Created by ios2 on 05/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class ProfileVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var myEventsCollectionView: UICollectionView!
    @IBOutlet weak var instagramCollectionView: UICollectionView!
    @IBOutlet weak var editDetailsButton: UIButton!
    
    //MARLK: Class Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customiseUI()
    }
    
    //MARK: Private Methods
    func customiseUI(){
        setTitle(title: "")
        setRightButton(image: #imageLiteral(resourceName: "setting"))
        self.parent?.navigationItem.leftBarButtonItems = nil
        self.editDetailsButton.setBackgroundImage(editDetailsButton.graidentImage, for: .normal)
        self.editDetailsButton.set(radius: 14.0)
    }
    
    override func rightButtonAction(sender: UIButton) {
        let settingvc = self.storyboard?.instantiateViewController(withIdentifier: kSettingVC) as! SettingVC
        self.navigationController?.show(settingvc, sender: self)
    }
    
    //MARK: IBAction
    @IBAction func editDetailsButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func promotionPackagesButtonAction(_ sender: Any) {
    }
}

//MARK: Collectionview Datasource
extension ProfileVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.myEventsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kProfileCell, for: indexPath) as! ProfileCell
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kProfileCell1, for: indexPath) as! ProfileCell
            return cell
        }
    }
}

//MARK: Collectionview data flow layout
extension ProfileVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.myEventsCollectionView.frame.width/3) , height: self.myEventsCollectionView.frame.height)
    }
}
