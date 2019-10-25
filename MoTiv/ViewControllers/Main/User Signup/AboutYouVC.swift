//
//  AboutYouVC.swift
//  MoTiv
//
//  Created by ios2 on 03/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class AboutYouVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var textBaseView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    
    //MARK: Class Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.customiseUI()
    }
    
    override func rightButtonAction(sender: UIButton) {
        SignupContainerVC.signupDict[APIKeys.kAboutMe] = ""
        navigateToCategory()
    }
    
    //MARK: Private Methods
    private func customiseUI(){
        setTitle(title: kHelloUser, showBack: false)
        setRightButton(title: kSkip)
        self.textBaseView.set(radius: 14.0)
        self.nextButton.set(radius: 14.0)
        nextButton.setBackgroundImage(nextButton.graidentImage, for: .normal)
        setuptextField()
    }
    
    private func setuptextField() {
        textView.text!.count > 0 ? textBaseView.setShadow(): textBaseView.removeShadow()
    }
    
    private func navigateToCategory() {
        showAlert(title: kSuccess, message: kAboutYouAlert, cancelTitle: nil, cancelAction: nil, okayTitle: kOkay, {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: kSelectCategoryVC) as! SelectCategoryVC
            self.navigationController?.pushViewController(vc, animated: true)
        })
    }
    
    //MARK: IBActions
    @IBAction func signUpButtonAction(_ sender: Any) {
        SignupContainerVC.signupDict[APIKeys.kAboutMe] = textView.text!
        navigateToCategory()
    }
}

//MARK: Textview Delegates
extension AboutYouVC: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        setuptextField()
    }
}
