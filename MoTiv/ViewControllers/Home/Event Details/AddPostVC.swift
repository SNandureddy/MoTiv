//
//  AddPostVC.swift
//  MoTiv
//
//  Created by IOS on 30/11/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class AddPostVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var addCommentButton: UIButton!
    
    //MARK: Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Variables
    static var postDict = JSONDictionary()
    var delegate: TabViewDelegate!
    var video1: URL?
    var selectedImage = 1
    var selectedIndex = Int()
    var type: PreviousScreen = .main
    var categoryEventDetailArray = [SearchEventDetail]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customiseUI()
    }
    
    //MARK: Private Methods
    private func customiseUI() {
        setTitle(title: kPosts)
        backView.set(radius: 14.0)
        postImageView.set(radius: 14.0)
        textView.delegate = self
        addCommentButton.set(radius: 14.0)
        addCommentButton.setBackgroundImage(addCommentButton.graidentImage, for: .normal)
    }
    
    func setData() -> JSONDictionary {
        var dict = JSONDictionary()
        dict[APIKeys.kEventID] = type == .search ? categoryEventDetailArray[selectedIndex].eventID : EventVM.shared.eventDetailArray?[selectedIndex].eventID
        dict[APIKeys.kUserType] = DataManager.role
        dict[APIKeys.kText] = textView.text
        dict[APIKeys.kPostMediaType] = 1
//        dict[APIKeys.kImage] = postImageView.image?.imageData
        return dict
    }
    
    func setImageData() -> [String: Data] {
        var imageDict = [String: Data]()
        imageDict[APIKeys.kImage] = postImageView.image?.imageData
        return imageDict
    }

    
    //MARK: IBActions
    @IBAction func addImageButtonAction(_ sender: UIButton) {
        CustomImagePickerView.sharedInstace.delegate = self
        self.showImagePicker(showVideo: true)
    }
    
    @IBAction func addPostAction(_ sender: UIButton) {
        if let message = validateData() {
            self.showAlert(message: message)
            return
        }
        if textView.text == kEnterDescription || textView.text == "" {
            return
        }
        apiToCreatePost()
    }
}

extension AddPostVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        backView.removeShadow()
        iconImageView.image = #imageLiteral(resourceName: "editUnselected")
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.text = textView.text.isEmpty ? kEnterDescription: textView.text
        textView.text == kEnterDescription ? backView.removeShadow(): backView.setShadow()
        iconImageView.image = textView.text == kEnterDescription ? #imageLiteral(resourceName: "editUnselected"): #imageLiteral(resourceName: "editSelected")
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textView.text!.isEmpty ? backView.removeShadow(): backView.setShadow()
        iconImageView.image = textView.text!.isEmpty ? #imageLiteral(resourceName: "editUnselected"): #imageLiteral(resourceName: "editSelected")
    }
}

extension AddPostVC: CustomImagePickerDelegate {
    
    func didImagePickerFinishPicking(_ image: UIImage) {
        video1 = nil
        postImageView.image = image
    }
    
    func didVideoPickerFinishPicking(_ video: URL) {
        let asset = AVURLAsset(url: video)
        let durationInSeconds = asset.duration.seconds
        if durationInSeconds <= 60.0 {
            let image = self.getThumbnailFrom(path: video)
            video1 = video
            postImageView.image = image ?? #imageLiteral(resourceName: "blackImage")
        }
        else {
            self.showAlert(message: kVideoLimt)
        }
    }
}

extension AddPostVC {
    
    func validateData() -> String? {
        if postImageView.image == nil {
            return kImageValidation
        }
        return nil
    }
}


//MARK: - API Calls
extension AddPostVC {
    func apiToCreatePost(){
        EventVM.shared.createPost(dict: setData(), imageDict: setImageData()){ (message, error) in
            if error != nil{
                self.showErrorMessage(error: error)
            } else{
                self.showAlert(title: nil, message: "Post Added Successfully", cancelTitle: nil, cancelAction: nil, okayTitle: kOkay, {
                    self.navigationController?.popViewController(animated: true)
                })
            }
        }
    }
}