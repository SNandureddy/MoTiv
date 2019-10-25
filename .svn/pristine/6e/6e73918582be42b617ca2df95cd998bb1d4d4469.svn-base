//
//  EditProfileVC.swift
//  MoTiv
//
//  Created by ios2 on 05/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class EditProfileVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var profileImageVIew: UIImageView!
    @IBOutlet weak var nameTextField: TextField!
    @IBOutlet weak var emailAddressTextField: TextField!
    @IBOutlet weak var PhoneNumberTextField: TextField!
    @IBOutlet weak var aboutTextView: UITextView!
    @IBOutlet weak var aboutBaseView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var editProfileBUtton: UIButton!
    @IBOutlet weak var editIconImageView: UIImageView!
    
    @IBOutlet weak var interestsView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var interestHeightConstraint: NSLayoutConstraint!

    
    //MARK: - Variables
    
    //MARLK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customiseUI()
    }   
    
    //MARK:- Private func
    func customiseUI() {
        if BaseVC.userType == .organiser {
            interestsView.isHidden = true
            interestHeightConstraint.constant = 0.0
        }
        setTitle(title: kEditProfile)
        nameTextField.set(radius: 14.0)
        nameTextField.setShadow()
        emailAddressTextField.set(radius: 14.0)
        emailAddressTextField.setShadow()
        PhoneNumberTextField.set(radius: 14.0)
        PhoneNumberTextField.setShadow()
        aboutBaseView.set(radius: 14.0)
        aboutBaseView.setShadow()
        self.saveButton.setBackgroundImage(self.saveButton.graidentImage, for: .normal)
        self.saveButton.set(radius: 14.0)
    }
    
    //MARK:- IBAction
    @IBAction func saveButtonAction(_ sender: Any){
        self.showAlert(title: kSuccess, message: kProfileUpdateAlert, cancelTitle: nil, cancelAction: nil, okayTitle: kOkay) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @IBAction func editImageButtonAction(_ sender: UIButton) {
    }
    
    
    
    @IBAction func textDidChange(_ sender: TextField) {
        sender.text!.count > 0 ? sender.setShadow(): sender.removeShadow()
        if sender.tag == 1 { //Name
            sender.rightImage = sender.text!.count > 0 ? #imageLiteral(resourceName: "userImageIcon"): #imageLiteral(resourceName: "userUnselected")
        }
        else if sender.tag == 2 { //Email
            sender.rightImage = sender.text!.count > 0 ? #imageLiteral(resourceName: "mailSelected"): #imageLiteral(resourceName: "mailUnSelected")
        }
        else { //Phone Number
            sender.rightImage = sender.text!.count > 0 ? #imageLiteral(resourceName: "phoneSelected"): #imageLiteral(resourceName: "phoneUnselected")
        }
    }
}

extension EditProfileVC: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        textView.text!.count > 0 ? aboutBaseView.setShadow(): aboutBaseView.removeShadow()
        editIconImageView.image = textView.text!.count > 0 ? #imageLiteral(resourceName: "editSelected"): #imageLiteral(resourceName: "editUnselected")
    }
}


//MARK: - UICollectionViewDataSource
extension EditProfileVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestsCell", for: indexPath) as! SongAlbumCell
        return cell
    }
    
    
}
//MARK: - UiCollectionViewDelegate
extension EditProfileVC : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension  EditProfileVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.width - 80) / 3, height: 90)
    }
}
