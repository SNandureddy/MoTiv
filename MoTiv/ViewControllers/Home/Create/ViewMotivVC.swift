//
//  ViewMotivVC.swift
//  MoTiv
//
//  Created by IOS on 05/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class ViewMotivVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var renewLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var userCollectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var inviteLabel: UILabel!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    //MARK: Variables
    var index = 0
    var isUpdate = false
    var selectedIndex = Int()

    //MARK: Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customiseUI()
        setupData()
    }
    
    override func shareText(message: String) {
        let activityViewController = UIActivityViewController(activityItems: [message], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
        activityViewController.completionWithItemsHandler = { activity, completed, items, error in
            self.navigateToHome()
        }
    }

    
    //MARK: Private Methods
    private func customiseUI() {
        if BaseVC.userType == .organiser  {
            userCollectionView.isHidden = true
            nextButton.isHidden = true
            previousButton.isHidden = true
            inviteLabel.isHidden = true
            collectionViewHeightConstraint.constant = 0.0
        }
        else {
            submitButton.setTitle(kCreateMoTiv, for: .normal)
        }
        setTitle(title: kCreateMoTiv)
        submitButton.set(radius: 14.0)
        submitButton.setBackgroundImage(submitButton.graidentImage, for: .normal)
    }
    
    private func setupData() {
        mainImageView.image = UIImage(data: (O_CreateMainVC.imageDict[APIKeys.kEventImageURL] as! Data))
        mainImageView.set(radius: 15.0)
        mainImageView.setShadow()
        mainImageView.contentMode = .scaleAspectFill
    
        let startDate = (O_CreateMainVC.createDict[APIKeys.kEventStartDate] as! String).dateFromString(format: .dateTime, type: .local)
        let endDate = (O_CreateMainVC.createDict[APIKeys.kEventEndDate] as! String).dateFromString(format: .dateTime, type: .local)
        startDateLabel.text = startDate.stringFromDate(format: .motivDateTime, type: .local)
        endDateLabel.text = endDate.stringFromDate(format: .motivDateTime, type: .local)
        eventNameLabel.text = O_CreateMainVC.createDict[APIKeys.kEventName] as? String ?? "N/A"
        renewLabel.text = O_CreateMainVC.createDict[APIKeys.kRenewValue] as? String ?? "N/A"
        urlLabel.text = O_CreateMainVC.createDict[APIKeys.kURL] as? String ?? "N/A"
        phoneLabel.text = O_CreateMainVC.createDict[APIKeys.kContactNumber] as? String ?? "N/A"
        locationLabel.text = O_CreateMainVC.createDict[APIKeys.kLocation] as? String ?? ""
        descriptionLabel.text = O_CreateMainVC.createDict[APIKeys.kEventDetail] as? String ?? "N/A"
        urlLabel.text = urlLabel.text!.isEmpty ? "N/A": urlLabel.text!
        phoneLabel.text = phoneLabel.text!.isEmpty ? "N/A": phoneLabel.text
    }
    
    //MARK: IBActions
    @IBAction func submitButtonAction(_ sender: UIButton) {
        if isUpdate {
            self.updateEvent()
        } else {
            self.createEvent()
        }
    }
    
    @IBAction func previousNextAction(_ sender: UIButton) {
//        if sender.tag == 1 { //Previous
//            if index > 0 {
//                userCollectionView.scrollToItem(at: IndexPath(row: index-1, section: 0), at: .left, animated: true)
//                index -= 1
//            }
//        }
//        else { //Next
//            if index < 6 {
//                userCollectionView.scrollToItem(at: IndexPath(row: index+1, section: 0), at: .right, animated: true)
//                index += 1
//            }
//        }
    }
}


//MARK: CollectionView Datasource
extension ViewMotivVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addUserCell", for: indexPath)
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userCell", for: indexPath)
        return cell
    }
}

extension ViewMotivVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension ViewMotivVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 90)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let indexPaths = userCollectionView.indexPathsForVisibleItems
        index = indexPaths.first?.row ?? 0
    }
}

//MARK: API Methods
extension ViewMotivVC {
    
    func createEvent() {
        EventVM.shared.createEvent(dict: O_CreateMainVC.createDict, imageDict: O_CreateMainVC.imageDict) { (message, error) in
            if error != nil {
                self.showErrorMessage(error: error)
            }
            else {
                if BaseVC.userType == .user {
                    self.showAlert(title: kSuccess, message: kUserCreateMoTivAlert, cancelTitle: kOkay, cancelAction: {
                        self.navigateToHome()
                        
                    }, okayTitle: kShareMotiv) {
                        self.shareText(message: "My Event \(O_CreateMainVC.createDict[APIKeys.kEventName] as? String ?? "") which is going to be organised at \(O_CreateMainVC.createDict[APIKeys.kLocation] as? String ?? ""). Join now by downloading the MoTiv application: \n https://itunes.apple.com/us/app/discover-your-motiv/id1367825584?ls=1&mt=8")
                    }
                    return
                }
                self.showAlert(title: kSuccess, message: kCreateEventAlert, cancelTitle: nil, cancelAction: nil, okayTitle: kOkay) {
                    self.navigateToHome()
                }
            }
        }
    }
    
    func updateEvent() {
        O_CreateMainVC.createDict[APIKeys.kEventID] = EventVM.shared.eventDetailArray?[selectedIndex].eventID
        EventVM.shared.updateEvent(dict: O_CreateMainVC.createDict, imageDict: O_CreateMainVC.imageDict) { (message, error) in
            if error != nil {
                self.showErrorMessage(error: error)
            }
            else {
                self.showAlert(title: kSuccess, message: kEventUpdateAlert, cancelTitle: nil, cancelAction: nil, okayTitle: kOkay) {
                    self.navigateToHome()
                }
            }
        }
    }
}