//
//  SelectCategoryVC.swift
//  MoTiv
//
//  Created by ios2 on 22/11/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//



import UIKit


class SelectCategoryVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var goToHomeButton: UIButton!
    
    //MARk: Variables
    var selectedCategoryArray = [Int]()
    static var musicCategoryArray = [Int]()
    var backView = UIView()
    
    //MARLK: Class Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customiseUI()
        getPublicInterest()
    }
    
    override func rightButtonAction(sender: UIButton) {
        SignupContainerVC.signupDict[APIKeys.kPublicInterest] = ""
        SignupContainerVC.signupDict[APIKeys.kMusicInterest] = ""
        makeSignup()
    }
    
    //MARK: IBActions
    @IBAction func allButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        selectedCategoryArray.removeAll()
        if sender.isSelected {
            selectedCategoryArray = CommonVM.shared.publicArray.map({$0.id})
        }
        collectionView.reloadData()
    }
    
    @IBAction func goToHomeButtonAction(_ sender: Any) {
        SignupContainerVC.signupDict[APIKeys.kPublicInterest] = (selectedCategoryArray.map { String($0) }).joined(separator: ",")
        SignupContainerVC.signupDict[APIKeys.kMusicInterest] = (SelectCategoryVC.musicCategoryArray.map { String($0) }).joined(separator: ",")
        makeSignup()
    }
    
    //MARK: Private Methods
    private func customiseUI( ){
        backView.removeFromSuperview()
        setTitle(title: kHelloUser, showBack: false)
        setRightButton(title: kSkip)
        self.goToHomeButton.setBackgroundImage(self.goToHomeButton.graidentImage, for: .normal)
        self.goToHomeButton.set(radius: 14.0)
    }
    
    private func makeSignup() {
        if SignupContainerVC.userDict.count > 0 && SignupContainerVC.imageDict.count == 0 {
            SignupContainerVC.signupDict[APIKeys.kImage] = (SignupContainerVC.userDict[APIKeys.kImage] as? URL)?.absoluteString
        }
        signup()
    }
}

//MARK: UICollectionViewDataSource
extension SelectCategoryVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CommonVM.shared.publicArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selectCategoryCell", for: indexPath) as! SongAlbumCell
        if indexPath.row == 0 {
            cell.titleLabel.text = "MUSIC"
            cell.albumImageView.image = #imageLiteral(resourceName: "Music01").withRenderingMode(.alwaysTemplate)
            cell.albumImageView.tintColor = SelectCategoryVC.musicCategoryArray.count > 0 ? UIColor.motivColor.baseColor.color(): UIColor.white
            return cell
        }
        cell.titleLabel.text = CommonVM.shared.publicArray[indexPath.row-1].name
        cell.albumImageView.sd_setImage(with: CommonVM.shared.publicArray[indexPath.row-1].image, placeholderImage: #imageLiteral(resourceName: "categoryPlaceholder"), options: .refreshCached) { (image, error, cache, url) in
            cell.albumImageView.image = image?.withRenderingMode(.alwaysTemplate)
        }
        cell.albumImageView.tintColor = selectedCategoryArray.contains(where: {$0 == CommonVM.shared.publicArray[indexPath.row-1].id}) ? UIColor.motivColor.baseColor.color(): UIColor.white
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension SelectCategoryVC: UICollectionViewDelegateFlowLayout {
    
}

//MARK: - UICollectionViewDelegate
extension SelectCategoryVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.collectionView.frame.size.width - 20 ) / 3, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let subcatvc = self.storyboard?.instantiateViewController(withIdentifier: kSubCategoryVC) as! SubCategoryVC
            subcatvc.delegate = self
            subcatvc.modalPresentationStyle = .overCurrentContext
            self.navigationController?.present(subcatvc, animated: true, completion: nil)
        }
        else {
            let cell = collectionView.cellForItem(at: indexPath) as! SongAlbumCell
            if let index = selectedCategoryArray.firstIndex(where: {$0 == CommonVM.shared.publicArray[indexPath.row-1].id}) {
                    selectedCategoryArray.remove(at: index)
                cell.albumImageView.tintColor = UIColor.white
            }
            else {
                selectedCategoryArray.append(CommonVM.shared.publicArray[indexPath.row-1].id)
                cell.albumImageView.image?.withRenderingMode(.alwaysTemplate)
                cell.albumImageView.tintColor = UIColor.motivColor.baseColor.color()
            }
        }
    }
}

extension SelectCategoryVC: CategoryDelegate {
    
    func didGetCategories(array: [Int], type: CategoryType) {
        collectionView.reloadData()
    }
}

extension SelectCategoryVC {
    
    func getPublicInterest() {
        CommonVM.shared.getPublicInterest { (message, error) in
            if error != nil {
                self.showErrorMessage(error: error)
            }
            else {
                self.getMusicInterest()
                self.collectionView.reloadData()
            }
        }
    }
    
    func signup() {
        UserVM.shared.signup(userDetails: SignupContainerVC.signupDict, imageDict: SignupContainerVC.imageDict) { (message, error) in
            if error != nil {
                self.showErrorMessage(error: error)
            }
            else {
                if SignupContainerVC.userDict.count > 0 {
                    self.showAlert(title: kSuccess, message: kSocialSignupSuccess, okayTitle: kOkay, {
                        BaseVC.userType = .user
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: kReferalCodeVC ) as! ReferalCodeVC
                        self.navigationController?.pushViewController(vc, animated: true)
                    })
                }
                else {
                    self.showAlert(title: kSuccess, message: kAllDoneAlert, cancelTitle: kCancel, cancelAction: {
                        self.logout()
                    }, okayTitle: kOpenEmail,  {
                        self.logout()
                        self.openMail()
                    })
                }
            }
        }
    }
    
    func getMusicInterest() {
        CommonVM.shared.getMusicInterest { (message, error) in
            if error != nil {
                self.showErrorMessage(error: error)
            }
            else {
                self.collectionView.reloadData()
            }
        }
    }

}
