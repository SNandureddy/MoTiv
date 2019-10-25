//
//  MyProfileVC.swift
//  MoTiv
//
//  Created by Deftsoft on 06/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class MyProfileVC: BaseVC {
    // MARK: - IBOutlets
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
//    @IBOutlet weak var albumCollectionView: UICollectionView!
    
    @IBOutlet weak var editDetailButton: UIButton!
     // MARK: - Variables
    let listArray =  [#imageLiteral(resourceName: "cumunity"),#imageLiteral(resourceName: "Networking"),#imageLiteral(resourceName: "lock"),#imageLiteral(resourceName: "social"),#imageLiteral(resourceName: "Music"),#imageLiteral(resourceName: "process"),#imageLiteral(resourceName: "ticket"),#imageLiteral(resourceName: "Computer"),#imageLiteral(resourceName: "Reading_book")]
    
    // MARK: - Class life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.customizeUI()
        getPublicInterest()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    // MARK: - Private functions
    private func customizeUI() {
        setTitle(title: kMyProfile, showBack: false)
        setRightButton(image: #imageLiteral(resourceName: "setting"))
        setLeftButton(image: #imageLiteral(resourceName: "faq"))
        self.editDetailButton.setBackgroundImage(editDetailButton.graidentImage, for: .normal)
        self.editDetailButton.set(radius: 14.0)
    }
    
    override func rightButtonAction(sender: UIButton) {
        let settings = self.storyboard?.instantiateViewController(withIdentifier: kSettingsVC) as! SettingsVC
        self.navigationController?.show(settings, sender: self)
    }

    override func leftButtonAction() {
        let storybaord = UIStoryboard(storyboard: .Profile)
        let faqvc = storybaord.instantiateViewController(withIdentifier: kHelpVC) as! HelpVC
        let nav = UINavigationController(rootViewController: faqvc)
        self.navigationController?.present(nav, animated: true, completion: nil)
    }
    
    // MARK: - IBActions
    
    @IBAction func editProfileButtonAction(_ sender: Any) {
    }
    @IBAction func shareButtonAction(_ sender: Any) {
//        let storyboard = UIStoryboard.init(storyboard: .Main)
//        let vc = storyboard.instantiateViewController(withIdentifier: kUserChangePasswordVC)as!UserChangePasswordVC
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func editDetailButtonAction(_ sender: Any) {
        let editvc = self.storyboard?.instantiateViewController(withIdentifier: kEditProfileVC) as! EditProfileVC
        self.navigationController?.show(editvc, sender: self)
    }
    
    @IBAction func albumButtonsAction(sender: UIButton) {
        switch sender.tag {
        case 101,102:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: kSearchProfileFriendsVC) as! SearchProfileFriendsVC
            self.navigationController?.show(vc, sender: self)
            break
        case 103:
            let storyboard = UIStoryboard(storyboard: .Main)
            let vc = storyboard.instantiateViewController(withIdentifier: kReferralInnerVC) as! ReferalCodeVC
            vc.isFromProfile = true
            self.navigationController?.show(vc, sender: self)
            break
        case 104,105:
            let storyboard = UIStoryboard(storyboard: .Home)
            let subcatvc = storyboard.instantiateViewController(withIdentifier: kAddCategoryVC) as! AddCategoryVC
            subcatvc.modalPresentationStyle = .overCurrentContext
            subcatvc.delegate = self
            subcatvc.categoryArray = sender.tag == 105 ? CommonVM.shared.musicArray: CommonVM.shared.publicArray
            subcatvc.type = sender.tag == 105 ? .musicCategory: .publicCategory
            self.navigationController?.present(subcatvc, animated: true, completion: nil)
            break
        case 106,107,108:
            let storyboard = UIStoryboard(storyboard: .Home)
            let ticketvc = storyboard.instantiateViewController(withIdentifier: kMyTicketsVC) as! MyTicketsVC
            if sender.tag == 107 {
                ticketvc.type = .past
            }
            if sender.tag == 108 {
                ticketvc.type = .invitation
            }
            self.show(ticketvc, sender: self)
        default:
            break
        }
    }
}

//MARK: Category Delegate
extension MyProfileVC: CategoryDelegate {
    
    func didGetCategories(array: [Int], type: CategoryType) {
        if type == .publicCategory {
            var publicArray = [String]()
            for data in CommonVM.shared.publicArray {
                if array.contains(data.id) {
                    publicArray.append(data.name)
                }
            }
        }
        else {
            var musicArray = [String]()
            for data in CommonVM.shared.musicArray {
                if array.contains(data.id) {
                    musicArray.append(data.name)
                }
            }
        }
    }
    
    func getPublicInterest() {
        CommonVM.shared.getPublicInterest { (message, error) in
            if error != nil {
                self.showErrorMessage(error: error)
            }
            else {
                self.getMusicInterest()
            }
        }
    }
    
    func getMusicInterest() {
        CommonVM.shared.getMusicInterest { (message, error) in
            if error != nil {
                self.showErrorMessage(error: error)
            }
            else {
                
            }
        }
    }

}




////MARK: UICollectionView Delegates and Datasources
//extension MyProfileVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return listArray.count
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kSongAlbumCell, for: indexPath)as! SongAlbumCell
//        if indexPath.row == 1{
//            cell.badgeLabel.isHidden = false
//            cell.badgeLabel.layer.cornerRadius = 15.0
//        }else{
//            cell.badgeLabel.isHidden = true
//        }
//        cell.albumImageView.image = listArray[indexPath.row]
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        switch indexPath.row {
//        case 0,1:
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: kSearchProfileFriendsVC) as! SearchProfileFriendsVC
//            self.navigationController?.show(vc, sender: self)
//            break
//        case 2:
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: kBlockedUsersVC) as! BlockedUsersVC
//            self.navigationController?.show(vc, sender: self)
//            break
//        case 3,4:
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: kInterestsVC) as! InterestsVC
//            if indexPath.row == 4 {
//                vc.type = .musicInterest
//            }
//            self.navigationController?.show(vc, sender: self)
//            break
//        case 5:
//            let storyboard = UIStoryboard(storyboard: .Main)
//            let vc = storyboard.instantiateViewController(withIdentifier: kReferralInnerVC) as! ReferalCodeVC
//            vc.isFromProfile = true
//            self.navigationController?.show(vc, sender: self)
//        case 6,7,8:
//            let storyboard = UIStoryboard(storyboard: .Home)
//            let ticketvc = storyboard.instantiateViewController(withIdentifier: kMyTicketsVC) as! MyTicketsVC
//            if indexPath.row == 7 {
//                ticketvc.type = .past
//            }
//            if indexPath.row == 8 {
//                ticketvc.type = .invitation
//            }
//            self.show(ticketvc, sender: self)
//        default:
//            break
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: (collectionView.frame.width - 50)/3, height: (collectionView.frame.width - 50)/3)
//    }
//}