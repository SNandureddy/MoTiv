//
//  ViewProfileVC.swift
//  MoTiv
//
//  Created by Deftsoft on 06/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class ViewProfileVC: BaseVC {
// MARK: - IBOutlets
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var songView: UIView!
    @IBOutlet weak var songsViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var songCollectionView: UICollectionView!
    @IBOutlet weak var aboutUsLabel: UILabel!
    
    @IBOutlet weak var addFriendButton: UIButton!
    
    
    // MARK: - Variables
    
    // MARK: - Class life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.customizeUI()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    // MARK: - Private functions
    private func customizeUI() {
        setTitle(title: kViewProfile)
        self.addFriendButton.setBackgroundImage(addFriendButton.graidentImage, for: .normal)
        self.addFriendButton.set(radius: 14.0)
    }
    
    
    // MARK: - IBActions
    
    @IBAction func previousButtonAction(_ sender: Any) {
    }
    
    
    @IBAction func nextButtonAction(_ sender: Any) {
    }
    
    
    @IBAction func addFriendButtonAction(_ sender: Any) {
        self.showAlert(title: kSuccess, message: kAddFriendSuccessAlert, okayTitle: kOkay) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func messageButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(storyboard: .Chat)
        let vc = storyboard.instantiateViewController(withIdentifier: kChatVC)as!ChatVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func editProfileButtonAction(_ sender: Any) {
    }
    
}

//MARK: UICollectionView Delegates and Datasources
extension ViewProfileVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kSongAlbumCell, for: indexPath)
        return cell
}
    
    
    
}

