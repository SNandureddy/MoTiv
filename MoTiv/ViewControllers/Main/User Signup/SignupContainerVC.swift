//
//  SignupContainerVC.swift
//  MoTiv
//
//  Created by ios2 on 29/11/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class SignupContainerVC: BaseVC {
    
    //MARK:  IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet var indicatorButtonCollection: [UIButton]!
    
    //MARK: Variables
    static var signupDict = JSONDictionary()
    static var userDict = JSONDictionary()
    static var imageDict = [String: Data]()
    var index = 0
    
    //MARK: Viewcontroller Variables
    lazy var nameVC: UIViewController = {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: kNameVC) as! NameVC
        return vc
    }()
    
    lazy var userNameVC: UIViewController = {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: kUsernameVC) as! UsernameVC
        return vc
    }()
    
    lazy var emailVC: UIViewController = {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: kEmailVC) as! EmailVC
        return vc
    }()
    
    lazy var profilePictureVC: UIViewController = {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: kProfilePictureVC) as! ProfilePictureVC
        return vc
    }()
    
    lazy var dobVC: UIViewController = {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: kDOBVC) as! dateOfBirthVC
        return vc
    }()
    
    
    //MARK: Class Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        changeVC(index: index)
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customiseUI()
    }
    
    override func backButtonAction() {
        if index > 0 {
            index -= 1
            changeVC(index: index)
        }
        else {
            let navObj = self.navigationController?.popViewController(animated: true)
            if navObj == nil {
                self.navigationController?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    //MARK: IBActions
    @IBAction func nextButtonAction(_ sender: UIButton) {
        switch index {
        case 0: //NameVC
            if let message = self.validateName() {
                self.showAlert(message: message)
                return
            }
            break
        case 1: //User Name VC
            if let message = self.validateUserName() {
                self.showAlert(message: message)
                return
            }
            break
        case 2: //Email VC
            if let message = self.validateEmail() {
                self.showAlert(message: message)
                return
            }
            self.validateEmail(email: SignupContainerVC.signupDict[APIKeys.kEmail] as! String)
            return
        case 4: //DOB VC
            if let message = self.validateDOB() {
                self.showAlert(message: message)
                return
            }
            break
        default: //Profile Picture
            break
        }
        if index < 4 {
            index += 1
            self.changeVC(index: index)
        }
        else {
            if SignupContainerVC.userDict.count > 0 {
                navigateToAbout()
                return
            }
            let passwordvc = self.storyboard?.instantiateViewController(withIdentifier: kPasswordVC) as! PasswordVC
            self.navigationController?.show(passwordvc, sender: self)
        }
    }
    
    private func navigateToAbout() {
        self.showAlert(title: kSuccess, message: kSignUpAlert, cancelTitle: nil, cancelAction: nil, okayTitle: kOkay, {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: kAboutYouVC) as! AboutYouVC
            self.navigationController?.pushViewController(vc, animated: true)
        })
    }

    
    //MARK: Private Methods
    private func customiseUI(){
        setTitle(title: kSignup)
        self.nextButton.setBackgroundImage(nextButton.graidentImage, for: .normal)
        self.nextButton.set(radius: 14.0)
        
    }
    
    private func setupData() {
        SignupContainerVC.signupDict[APIKeys.kSignupType] = SignupContainerVC.userDict.count > 0 ? 2: 1
        SignupContainerVC.signupDict[APIKeys.kUserType] = 2
        SignupContainerVC.signupDict[APIKeys.kSocialId] = SignupContainerVC.userDict[APIKeys.kId]
        SignupContainerVC.signupDict[APIKeys.kSocialSignupType] = SignupContainerVC.userDict[APIKeys.kSocialSignupType]
    }
}

//MARK: Container Setup and Methods
extension SignupContainerVC  {
    
    // update Top color for page change
    private func updatePageTop (index: Int) {
        for i in 0..<indicatorButtonCollection.count {
            if i <= index {
                indicatorButtonCollection[i].backgroundColor = UIColor.motivColor.baseColor.color()//selected color
            }
            else {
                indicatorButtonCollection[i].backgroundColor = UIColor.white// unselected color
            }
        }
    }
    
    //change viewController in container view
    private func changeVC(index: Int) {
        switch index {
        case 0:
            addchildVC(childVC: self.nameVC)
        case 1:
            addchildVC(childVC: self.userNameVC)
        case 2:
            addchildVC(childVC: self.emailVC)
        case 3:
            addchildVC(childVC: self.profilePictureVC)
        case 4:
            addchildVC(childVC: self.dobVC)
        default:
            return
        }
        updatePageTop(index: index)
    }
    
    // add a view controller to containerView
    private func addchildVC(childVC: UIViewController){
        self.removeAllChildVC()
        self.addChildViewController(childVC)
        self.containerView.addSubview(childVC.view)
        self.containerView.layer.add(transition, forKey: kCATransition)
        childVC.view.frame = containerView.bounds
        childVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childVC.didMove(toParentViewController: self)
    }
    
    // remove child viewControllers
    private func removeAllChildVC(){
        self.remove(childVC: self.nameVC)
        self.remove(childVC: self.userNameVC)
        self.remove(childVC: self.emailVC)
        self.remove(childVC: self.profilePictureVC)
        self.remove(childVC: self.dobVC)
    }
    
    // remove a viewcontroller from containerview
    private func remove(childVC: UIViewController){
        childVC.willMove(toParentViewController: nil)
        childVC.view.removeFromSuperview()
        childVC.removeFromParentViewController()
    }
}


//MARK: Validations
extension SignupContainerVC {
    
    func validateName() -> String? { //NameVC validation
        if !(SignupContainerVC.signupDict[APIKeys.kFirstName] as? String ?? "").isValidData {
            return kFirstNameValidation
        }
        if !(SignupContainerVC.signupDict[APIKeys.kLastName] as? String ?? "").isValidData {
            return kLastNameValidation
        }
        return nil
    }
    
    func validateUserName() -> String? { //User Name validation
        if !(SignupContainerVC.signupDict[APIKeys.kUserName] as? String ?? "").isValidData {
            return kUserNameValidation
        }
        return nil
    }
    
    func validateEmail() -> String? { //Email validation
        if !(SignupContainerVC.signupDict[APIKeys.kEmail] as? String ?? "").isValidEmail {
            return kEmailValidation
        }
        return nil
    }
    
    func validateDOB() -> String? { //DOB VC validation
        if !(SignupContainerVC.signupDict[APIKeys.kPhoneNumber] as? String ?? "").isValidPhone && (SignupContainerVC.signupDict[APIKeys.kPhoneNumber] as? String ?? "").count > 0  {
            return kPhoneValidation
        }
        if (SignupContainerVC.signupDict[APIKeys.kAge] as? String ?? "").isEmpty {
            return kDOBValidation
        }
        return nil
    }
}

//MARK: API Methods
extension SignupContainerVC {

    func validateEmail(email: String) {
        UserVM.shared.validateEmail(email: email) { (message, error) in
            if error != nil {
                self.showErrorMessage(error: error)
            }
            else {
                self.index += 1
                self.changeVC(index: self.index)
            }
        }
    }
}
