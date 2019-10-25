//
//  O_CreateMainVC.swift
//  MoTiv
//
//  Created by IOS on 05/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

protocol TabViewDelegate {
    func didClickTab(tag: Int)
}


class O_CreateMainVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet var markViewCollection: [UIView]!
    
    //MARK: Variables
    var selectedTag = 1
    static var createDict = JSONDictionary()
    static var imageDict = [String: Data]()
    var isUpdate = false
    var selectedIndex = Int()

    //MARK: - ViewController Variables
    private lazy var addImagevc: AddImageVC = {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: kAddImageVC) as! AddImageVC
        vc.selectedIndex = self.selectedIndex
        vc.isUpdate = self.isUpdate
        vc.delegate = self
        return vc
    }()
    private lazy var addNamevc: AddNameVC = {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: kAddNameVC) as! AddNameVC
        vc.selectedIndex = self.selectedIndex
        vc.isUpdate = self.isUpdate
        vc.delegate = self
        return vc
    }()
    private lazy var addLocationvc: AddLocationVC = {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: kAddLocationVC) as! AddLocationVC
        vc.delegate = self
        vc.selectedIndex = self.selectedIndex
        vc.isUpdate = self.isUpdate
        return vc
    }()
    private lazy var addDateTimevc: AddDateTimeVC = {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: kAddDateTimeVC) as! AddDateTimeVC
        vc.delegate = self
        vc.selectedIndex = self.selectedIndex
        vc.isUpdate = self.isUpdate
        return vc
    }()
    private lazy var addDetailsVC: AddDetailsVC = {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: kAddDetailsVC) as! AddDetailsVC
        vc.delegate = self
        vc.selectedIndex = self.selectedIndex
        vc.isUpdate = self.isUpdate
        return vc
    }()
    private lazy var addTicketsvc: AddTicketsVC = {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: kAddTicketsVC) as! AddTicketsVC
        vc.delegate = self
        vc.selectedIndex = self.selectedIndex
        vc.isUpdate = self.isUpdate
        return vc
    }()
    private lazy var descriptionvc: DescriptionVC = {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: kDescriptionVC) as! DescriptionVC
        vc.delegate = self
        vc.selectedIndex = self.selectedIndex
        vc.isUpdate = self.isUpdate
        return vc
    }()
    private lazy var inviteUserVC: InviteUserVC = {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: kInviteUserVC) as! InviteUserVC
        vc.delegate = self
        return vc
    }()

    //MARK: Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customiseUI()
        O_CreateMainVC.createDict[APIKeys.kUserType] = DataManager.role ?? 2
        O_CreateMainVC.createDict[APIKeys.kSubmitBy] = DataManager.role ?? 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTitle(title: kCreateMoTiv)
        if BaseVC.userType == .user && selectedTag == 1 {
            self.hideBackButton()
            self.hideRightButton()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    //MARK: Private Methods
    private func customiseUI() {
        for i in 0 ..< 6 {
            markViewCollection[i].backgroundColor = UIColor.white
            markViewCollection[i].set(radius: 7.0)
        }
        self.changeTab(tag: 1)
        
    }
    
    override func backButtonAction() {
        if selectedTag == 1 {
            self.navigationController?.popViewController(animated: true)
        }
        self.changeTab(tag: selectedTag-1)
        selectedTag -= 1
    }
    
    override func rightButtonAction(sender: UIButton) {
        shareText(message: "My Event \(O_CreateMainVC.createDict[APIKeys.kEventName] as? String ?? "") which is going to be organised at \(O_CreateMainVC.createDict[APIKeys.kLocation] as? String ?? ""). Join now by downloading the MoTiv application: \n https://itunes.apple.com/us/app/discover-your-motiv/id1367825584?ls=1&mt=8")
    }
}

//Set Top View
extension O_CreateMainVC {
    func setTopView(tag: Int) {
        for i in 0 ..< 6 {
            markViewCollection[i].backgroundColor = UIColor.white
        }
        for i in 0 ..< tag {
            markViewCollection[i].backgroundColor = UIColor.motivColor.baseColor.color()
        }
    }
}

//Handle Custom Views
extension O_CreateMainVC {
    
    
    //Change Tab
    private func changeTab(tag: Int) {
        switch tag {
        case 1:
            if BaseVC.userType == .user {
                self.hideBackButton()
            }
            self.add(childVC: addImagevc)
            hideRightButton()
            break
        case 2:
            self.setBackButton()
            self.add(childVC: addNamevc)
            hideRightButton()
            break
        case 3:
            self.add(childVC: addLocationvc)
            hideRightButton()
            break
        case 4:
            self.add(childVC: addDateTimevc)
            
            hideRightButton()
            break
        case 5:
            if BaseVC.userType == .organiser {
                self.add(childVC: addDetailsVC)
                break
            }
            self.add(childVC: descriptionvc)
            hideRightButton()
            break
        case 6:
            if BaseVC.userType == .organiser {
                self.add(childVC: addTicketsvc)
                hideRightButton()
                break
            }
            self.add(childVC: inviteUserVC)
            setRightButton(image: #imageLiteral(resourceName: "Share_with_bg"))
            break
        default:
            break
        }
        setTopView(tag: tag)
    }

    //Add Child View Controller
    func add(childVC: UIViewController) {
        self.removeAll()
        self.addChildViewController(childVC)
        self.containerView.addSubview(childVC.view)
        self.containerView.layer.add(transition, forKey: kCATransition)
        childVC.view.frame = containerView.bounds
        childVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childVC.didMove(toParentViewController: self)
    }
    
    //Remove Child View Controller
    func remove(childVC: UIViewController) {
        childVC.willMove(toParentViewController: nil)
        childVC.view.removeFromSuperview()
        childVC.removeFromParentViewController()
    }
    
    //Remove All Child View Controller
    func removeAll() {
        self.remove(childVC: addImagevc)
        self.remove(childVC: addNamevc)
        self.remove(childVC: addLocationvc)
        self.remove(childVC: addDateTimevc)
        self.remove(childVC: addDetailsVC)
        self.remove(childVC: addTicketsvc)
        self.remove(childVC: descriptionvc)
        self.remove(childVC: inviteUserVC)
    }
    
}

//MARK: TabViewDelegate
extension O_CreateMainVC: TabViewDelegate {
    func didClickTab(tag: Int) {
        self.selectedTag = tag
        self.changeTab(tag: tag)
    }
}
