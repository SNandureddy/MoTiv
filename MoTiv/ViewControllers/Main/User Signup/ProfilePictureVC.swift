
//
//  ProfilePictureVC.swift
//  MoTiv
//
//  Created by ios2 on 03/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit
import SDWebImage

class ProfilePictureVC: BaseVC {

    //MARK: IBOutlets
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet var logoImage: UIImageView!
    
    //MARK: Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customiseUI()
    }
    
    //MARK: Private Methods
    private func customiseUI() {
        userImageView.set(radius: 60)
//        let circle = UIView(frame: CGRect(x: UIScreen.main.bounds.midX - 76, y: 10, width: logoImage.frame.width, height: logoImage.frame.height))
//
//        circle.layoutIfNeeded()
//
//        var progressCircle = CAShapeLayer()
//
//        let centerPoint = CGPoint (x: circle.bounds.width / 2 - 2, y: circle.bounds.width / 2 - 14)
//        let circleRadius : CGFloat = circle.bounds.width / 2 * 0.70
//
//        let circlePath = UIBezierPath(arcCenter: centerPoint, radius: circleRadius, startAngle: CGFloat(0.23 * .pi), endAngle: CGFloat(2.73 * .pi), clockwise: true)
//
//        progressCircle = CAShapeLayer ()
//        progressCircle.path = circlePath.cgPath
//        progressCircle.strokeColor = UIColor(red: 220/255, green: 203/255, blue: 125/255, alpha: 1.0).cgColor
//        progressCircle.fillColor = UIColor.clear.cgColor
//        progressCircle.lineWidth = 8
//        progressCircle.strokeStart = 0.25
//        progressCircle.strokeEnd = 0.78
//        circle.layer.addSublayer(progressCircle)
//
//
//        let animation = CABasicAnimation(keyPath: "strokeEnd")
//        animation.fromValue = 0.25
//        animation.toValue = 0.78
//        animation.duration = 2
//        animation.fillMode = kCAFillModeForwards
//        animation.isRemovedOnCompletion = true
//        progressCircle.add(animation, forKey: "ani")
//
//        self.view.addSubview(circle)
    }
    
    private func setupData() {
        userImageView.sd_setImage(with: SignupContainerVC.userDict[APIKeys.kImage] as? URL, placeholderImage: #imageLiteral(resourceName: "userImagePlaceholder"), options: .refreshCached, completed: nil)
    }
    
    //MARK: IBActions
    @IBAction func addProfilePictureButtonAction(_ sender: Any) {
        CustomImagePickerView.sharedInstace.delegate = self
        showImagePicker()
    }
}

//MARK: Image Picker Delegate
extension ProfilePictureVC: CustomImagePickerDelegate {
    
    func didImagePickerFinishPicking(_ image: UIImage) {
        userImageView.image = image
        SignupContainerVC.imageDict[APIKeys.kImage] = image.imageData
    }
}
