//
//  BaseVC.swift
//  MoTiv
//
//  Created by Apple on 17/09/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit
import AVKit
import Photos
import Popover
import MapKit
import SDWebImage

enum UserType {
    case user
    case organiser
}

@objc protocol  PickerDelegate {
    @objc optional func didSelectPickerViewAtIndex(index: Int)
    @objc optional func didSelectDatePicker(date: Date)
    @objc optional func didClickOnDoneButton()
}

class BaseVC: UIViewController {
    
    //MARK: Variables
    var pickerView = UIPickerView()
    var pickerArray = [String]()
    var pickerDelegate: PickerDelegate?
    var datePickerView = UIDatePicker()
    static var userType: UserType = .user
    
    @IBInspectable var imageForEmptyScreen:UIImage = #imageLiteral(resourceName: "userImageIcon") {
        didSet {
            emptyview.imageView.image = imageForEmptyScreen
        }
    }
    @IBInspectable var titleForEmptyScreen:String = "" {
        didSet {
            emptyview.titleLabel.text = titleForEmptyScreen
        }
    }
    @IBInspectable var descriptionForEmptyScreen:String = "" {
        didSet {
            emptyview.descriptionLabel.text = descriptionForEmptyScreen
        }
    }
    
    
    
    lazy var emptyview:EmptyScreenView = EmptyScreenView(image: self.imageForEmptyScreen, title: self.titleForEmptyScreen, description: self.descriptionForEmptyScreen)

    
    //Transition
    var transition: CATransition {
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 0.2
        return transition
    }


    //MARK: Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: Empty Screen Implementation
    func showEmptyScreen(belowSubview subview: UIView? = nil, superView:UIView? = nil) {
        let baseView: UIView = superView ?? self.view
        emptyview.frame = CGRect(x: 0, y: 0, width: baseView.frame.width, height: baseView.frame.height)
        if let subview = subview {
            baseView.insertSubview(emptyview, belowSubview: subview)
        }
        else {
            baseView.addSubview(emptyview)
        }
    }
    
    func hideEmptyScreen() {
        emptyview.removeFromSuperview()
    }
}

//MARK: Screen Navigations
extension BaseVC {
    
    func navigateToHome() {
        let mainStoryboard = UIStoryboard.storyboard(storyboard: .Main)
        
        var mainVC = UITabBarController()
        if BaseVC.userType == .user {
            if !DataManager.isFirstTime && DataManager.isLoggedIn {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: kReferalCodeVC ) as! ReferalCodeVC
                self.navigationController?.pushViewController(vc, animated: true)
                return
            }
            else {
                mainVC = mainStoryboard.instantiateViewController(withIdentifier: kU_TabbarVC) as! U_TabbarVC
            }
        }
        else {
            mainVC = mainStoryboard.instantiateViewController(withIdentifier: kTabBarVC) as! TabBarVC
        }
        let nav = UINavigationController(rootViewController: mainVC)
        nav.isNavigationBarHidden = true
        appDelegate.window?.layer.add(transition, forKey: kCATransition)
        appDelegate.window?.rootViewController = nav
        appDelegate.window?.makeKeyAndVisible()
    }
    
    func logout() {
        DataManager.accessToken = nil
        DataManager.isFirstTime = false
        DataManager.role = nil
        DataManager.userMusicInterests.removeAll()
        DataManager.userPublicInterests.removeAll()
        let storyboard = UIStoryboard(storyboard: .Main)
        let vc = storyboard.instantiateViewController(withIdentifier: kLoginVC) as! LoginVC
        let navigationController = UINavigationController(rootViewController: vc)
        UIApplication.shared.keyWindow?.rootViewController = navigationController
    }
    
    func openMail() {
        let mailURL = URL(string: "message://")!
        if UIApplication.shared.canOpenURL(mailURL) {
            UIApplication.shared.open(mailURL, options: [:], completionHandler: nil)
        }
    }
    
    //Open location in map.
    @objc func openMapForPlace(lat: Double = 39.047695, long: Double = -95.578568, name: String = "Gove Company, kansas, USA") {
        
        
        if UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!) {
            let alert = UIAlertController(title: "Open In", message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Google Maps", style: .default, handler: { (action) in
                UIApplication.shared.open(URL(string:"comgooglemaps://?center=\(lat),\(long)&zoom=14&views=traffic&q=\(lat),\(long)")!, options: [:], completionHandler: nil)
            }))
            alert.addAction(UIAlertAction(title: "Apple Maps", style: .default, handler: { (action) in
                self.openAppleMaps(lat: lat, long: long, name: name)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            self.openAppleMaps(lat: lat, long: long, name: name)
        }
    }
    
    func openAppleMaps(lat: Double = 39.047695, long: Double = -95.578568, name: String = "Gove Company, kansas, USA") {
        
        let latitude: CLLocationDegrees = lat//39.047695
        let longitude: CLLocationDegrees = long//-95.578568
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name
        mapItem.openInMaps(launchOptions: options)
    }
    
}

//MARK: Navigation Bar Methods
extension BaseVC {
    
    func setTitle(title: String, showBack: Bool = true) {
        self.navigationController?.isNavigationBarHidden = false
//        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.white,
             NSAttributedStringKey.font: UIFont.MotivFont.regular.fontWithSize(size: 19.0)]
        
        if let parent = self.parent, parent.isKind(of: UITabBarController.self) {
            self.parent?.title = title
//            self.title = ""
        }
        else {
            self.title = title
        }
        if showBack {
            self.setBackButton()
        }
        else {
             self.navigationItem.hidesBackButton = true
        }
    }
    
    func hideNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func hideBackButton() {
        if self.parent!.isKind(of: UITabBarController.self) {
            self.parent!.navigationItem.leftBarButtonItem = nil
            self.parent!.navigationItem.leftBarButtonItems = nil
            self.parent!.navigationItem.hidesBackButton = true
        }
        else {
            self.navigationItem.leftBarButtonItem = nil
            self.navigationItem.leftBarButtonItems = nil
            self.navigationItem.hidesBackButton = true
        }
    }
    
    func hideRightButton() {
        if let parent = self.parent, parent.isKind(of: UITabBarController.self) {
            self.parent!.navigationItem.rightBarButtonItem = nil
            self.parent!.navigationItem.rightBarButtonItems = nil
        }
        else {
            self.navigationItem.rightBarButtonItem = nil
            self.navigationItem.rightBarButtonItems = nil
        }
    }
    
    //MARK: Back Button
    func setBackButton(image: UIImage = #imageLiteral(resourceName: "backButton")){
        let backButton = UIButton() //Custom back Button
        backButton.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        backButton.setImage(image, for: UIControlState.normal)
        backButton.addTarget(self, action: #selector(self.backButtonAction), for: UIControlEvents.touchUpInside)
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = backButton
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -10;
        
        if let parent = self.parent, parent.isKind(of: UITabBarController.self) {
            self.parent!.navigationItem.setLeftBarButtonItems([negativeSpacer, leftBarButton], animated: false)
        }
        else {
            self.navigationItem.setLeftBarButtonItems([negativeSpacer, leftBarButton], animated: false)
        }
    }
    
    
    @objc func backButtonAction() {
        let navObj = self.navigationController?.popViewController(animated: true)
        if navObj == nil {
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
    
    //MARK: Left button
    func setLeftButton(image: UIImage){
        let backButton = UIButton() //Custom back Button
        backButton.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        backButton.setImage(image, for: UIControlState.normal)
        backButton.addTarget(self, action: #selector(self.leftButtonAction), for: UIControlEvents.touchUpInside)
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = backButton
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -10;
        
        if let parent = self.parent, parent.isKind(of: UITabBarController.self) {
            self.parent!.navigationItem.setLeftBarButtonItems([negativeSpacer, leftBarButton], animated: false)
        }
        else {
            self.navigationItem.setLeftBarButtonItems([negativeSpacer, leftBarButton], animated: false)
        }
    }
    
    @objc func leftButtonAction() {
    }
    
    
    //MARK: Edit Buttton
    func setRightButton(image: UIImage? = nil, title: String? = nil){
        
        let backButton = UIButton() //Custom back Button
        backButton.frame = CGRect(x: 0, y: 0, width: 60, height: 50)
        if title != nil {
            backButton.setTitle(title, for: .normal)
            backButton.setTitleColor(UIColor.motivColor.baseColor.color(), for: .normal)
            backButton.titleLabel?.font = UIFont.MotivFont.regular.fontWithSize(size: 17.0)
        }else {
            backButton.setImage(image, for: UIControlState.normal)
        }
        backButton.addTarget(self, action: #selector(self.rightButtonAction(sender:)), for: UIControlEvents.touchUpInside)
        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = backButton
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -10;
        if let parent = self.parent, parent.isKind(of: UITabBarController.self) {
            self.parent!.navigationItem.setRightBarButtonItems([rightBarButton, negativeSpacer], animated: false)
        }
        else {
            self.navigationItem.setRightBarButtonItems([rightBarButton, negativeSpacer], animated: false)
        }
    }

    
    @objc func rightButtonAction(sender: UIButton) {
    
    }
    
    //MARK: Add Buttton
    func setAddButton(){
        let backButton = UIButton() //Custom back Button
        backButton.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        backButton.setImage(#imageLiteral(resourceName: "addButton"), for: UIControlState.normal)
        backButton.addTarget(self, action: #selector(self.addButtonAction(sender:)), for: UIControlEvents.touchUpInside)
        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = backButton
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -10;
        self.navigationItem.setRightBarButtonItems([rightBarButton, negativeSpacer], animated: false)
    }
    
    @objc func addButtonAction(sender: UIButton) {
        
    }
    
    //MARK: Edit Buttton
    func setTwoRightButtons(image1: UIImage, image2: UIImage){
        
        let backButton1 = UIButton() //Custom back Button
        backButton1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        backButton1.setImage(image1, for: UIControlState.normal)
        backButton1.addTarget(self, action: #selector(self.rightButtonAction(sender:)), for: UIControlEvents.touchUpInside)
        backButton1.tintColor = UIColor.white
        let rightBarButton1 = UIBarButtonItem()
        rightBarButton1.customView = backButton1
        backButton1.tag = 1
//        self.navigationItem.rightBarButtonItem = rightBarButton1
        
        let backButton2 = UIButton() //Custom back Button
        backButton2.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        backButton2.setImage(image2, for: UIControlState.normal)
        backButton2.tintColor = UIColor.white
        backButton2.addTarget(self, action: #selector(self.rightButtonAction(sender:)), for: UIControlEvents.touchUpInside)
        let rightBarButton2 = UIBarButtonItem()
        rightBarButton2.customView = backButton2
        backButton2.tag = 2

        
        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -10;
        if let parent = self.parent, parent.isKind(of: UITabBarController.self) {
            self.parent!.navigationItem.setRightBarButtonItems([rightBarButton1, rightBarButton2, negativeSpacer], animated: false)
        }
        else {
            self.navigationItem.setRightBarButtonItems([rightBarButton1, rightBarButton2, negativeSpacer], animated: false)
        }
    }

}

//MARK: Alert Methods
extension BaseVC {
    
    func showPopover(type: PopoverType = .up, width: CGFloat = 150, height: CGFloat = 50, title: String, sender: UIView) {
        let popUp = PopOver(width: width, height: height, title: title)
//        popUp.translatesAutoresizingMaskIntoConstraints = false
        let options = [
            .type(type),
            .blackOverlayColor(UIColor.clear),
            .popoverColor(UIColor.black),
            .arrowSize(CGSize(width: 20, height: 10)),
            .cornerRadius(7.0)
            ] as [PopoverOption]
        let popover = Popover(options: options, showHandler: nil, dismissHandler: nil)
        popover.show(popUp, fromView: sender)
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            popover.dismiss()
        }
    }
    
    
    
    func showAlert(title:String? = nil, message: String?, cancelTitle: String? = nil,  cancelAction: ButtonAction? = nil, okayTitle: String = "OKAY", _ okayAction: ButtonAction? = nil) {
        let alert = CustomAlert(title: title, message: message, cancelButtonTitle: cancelTitle, doneButtonTitle: okayTitle)
        alert.cancelButton.addTarget {
            cancelAction?()
            alert.remove()
        }
        alert.doneButton.addTarget {
            okayAction?()
            alert.remove()
        }
        alert.show()
    }
    
    func showErrorMessage(error: Error?) {
        /*
         STATUS CODES:
         200: Success (If request sucessfully done and data is also come in response)
         204: No Content (If request successfully done and no data is available for response)
         401: Unautorized (If token got expired)
         402: Block (If User blocked by admin)
         403: Delete (If User deleted by admin)
         406: Not Acceptable (If user is registered with the application but not verified)
         */
        let alert = CustomAlert(title: kError, message: (error as NSError?)?.userInfo[APIKeys.kMessage] as? String ?? kErrorMessage, cancelButtonTitle: nil, doneButtonTitle: kOkay)
        alert.doneButton.addTarget {
            alert.remove()
            let code = (error! as NSError).code
            if code == 401 || code == 402 || code == 403 || code == 406 {
                self.logout()
            }
        }
        alert.show()
    }
    
    func openSettings() {
        guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)")
                })
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

//MARK: Show image picker
extension BaseVC {
    
    func showImagePicker(showVideo: Bool = false) {
        let alert  = UIAlertController(title: "SELECT IMAGE", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "GALLERY", style: .default, handler: {action in
            let photos = PHPhotoLibrary.authorizationStatus()
            if photos == .notDetermined || photos == .denied || photos == .restricted {
                PHPhotoLibrary.requestAuthorization({status in
                    DispatchQueue.main.async {
                        if status == .authorized {
                            CustomImagePickerView.sharedInstace.pickImageUsing(target: self, mode: .gallery, showVideo: showVideo)
                        }
                        else {
                            self.showAlert(message: kGalleryAlert, {
                                self.openSettings()
                            })
                            return
                        }
                    }
                })
            }
            else {
                CustomImagePickerView.sharedInstace.pickImageUsing(target: self, mode: .gallery, showVideo: showVideo)
            }
        }))
        alert.addAction(UIAlertAction(title: "CAMERA", style: .default, handler: {action in
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
                DispatchQueue.main.async {
                    if response {
                        CustomImagePickerView.sharedInstace.pickImageUsing(target: self, mode: .camera, showVideo: showVideo)
                    } else {
                        self.showAlert(message: kCameraAlert, {
                            self.openSettings()
                        })
                        return
                    }
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func openGallery() {
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined || photos == .denied || photos == .restricted {
            PHPhotoLibrary.requestAuthorization({status in
                DispatchQueue.main.async {
                    if status == .authorized {
                        CustomImagePickerView.sharedInstace.pickImageUsing(target: self, mode: .gallery)
                    }
                    else {
                        self.showAlert(message: kGalleryAlert, {
                            self.openSettings()
                        })
                        return
                    }
                }
            })
        }
        else {
            CustomImagePickerView.sharedInstace.pickImageUsing(target: self, mode: .gallery)
        }
    }
    
    func getThumbnailFrom(path: URL) -> UIImage? {
        do {
            let asset = AVURLAsset(url: path , options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)
            return thumbnail
        } catch let error {
            print("*** Error generating thumbnail: \(error.localizedDescription)")
            return nil
        }
    }
    
    @objc func shareText(message: String) {
        let activityViewController = UIActivityViewController(activityItems: [message], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }

}

//MARK: Set Pickers
extension BaseVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: Custom Picker
    func setPicker(textField: UITextField, array: [String] = ["Value1", "Value2", "Value3", "Value4"], defaultIndex: Int = 0) {
        pickerArray = array
        textField.inputView = pickerView
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.reloadAllComponents()
        pickerView.selectRow(defaultIndex, inComponent: 0, animated: false)
    }
        
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerDelegate?.didSelectPickerViewAtIndex?(index: row) //Call Protocol Delegate
    }
    
    //MARK: Custom Date Picker
    func setDatePicker(textField: UITextField, mode: UIDatePickerMode = .dateAndTime, maxdate: Date? = nil, date: Date? = nil, minDate: Date? = nil) {
        datePickerView.datePickerMode = mode
        datePickerView.timeZone = .current
        datePickerView.maximumDate = maxdate
        datePickerView.minimumDate = minDate
        if let date = date {
            datePickerView.date = date
        }
        textField.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.didPickerViewValueChanged(sender:)), for: .valueChanged)
    }
    
    @objc func didPickerViewValueChanged(sender: UIDatePicker) {
        pickerDelegate?.didSelectDatePicker?(date: sender.date)
    }
}

extension BaseVC {
    //Convert JsonArray To String
    func getObjectStringFrom(jsonArray: JSONArray) -> String {
        if let objectData = try? JSONSerialization.data(withJSONObject: jsonArray, options: JSONSerialization.WritingOptions.prettyPrinted) {
            return String(data: objectData, encoding: .utf8) ?? ""
        }
        return ""
    }
}
