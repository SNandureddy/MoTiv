//
//  SalesDataTableViewCell.swift
//  MoTiv
//
//  Created by Apple on 25/02/19.
//  Copyright © 2019 MoTiv. All rights reserved.
//

import UIKit

class SalesDataTableViewCell: UITableViewCell {

    //MARK: IBOutlets
    
    @IBOutlet var recordLabel: UILabel!
    @IBOutlet var progressImageView: UIImageView!
    @IBOutlet var progressImageHeightConstraint: NSLayoutConstraint!
    @IBOutlet var ticketNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func handleProgessBar(ticketBought: Double, totalTicket: Double) {
        progressImageView.isHidden = true
        let circle = UIView(frame: CGRect(x: 5, y: self.contentView.bounds.midY, width: progressImageView.frame.width-2, height: progressImageView.frame.height-2))
        
        circle.layoutIfNeeded()
        
        var progressCircle = CAShapeLayer()
        var backgroundCircle = CAShapeLayer()
        let startAngle : CGFloat = .pi * 1.5
        let endAngle : CGFloat = startAngle + (.pi * 2.0);
        let centerPoint = CGPoint (x: circle.bounds.width / 2 , y: circle.bounds.width / 2 - 14)
        let circleRadius : CGFloat = circle.bounds.width / 2
        
        let circlePath = UIBezierPath(arcCenter: centerPoint, radius: circleRadius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        backgroundCircle = CAShapeLayer ()
        backgroundCircle.path = circlePath.cgPath
        backgroundCircle.strokeColor = UIColor.white.cgColor
        backgroundCircle.fillColor = UIColor.clear.cgColor
        backgroundCircle.lineWidth = 3.5
        backgroundCircle.strokeStart = 0
        backgroundCircle.strokeEnd = 1
        circle.layer.addSublayer(backgroundCircle)

        progressCircle = CAShapeLayer ()
        progressCircle.path = circlePath.cgPath
        progressCircle.strokeColor = UIColor.motivColor.darkBaseColor.color().cgColor
        progressCircle.fillColor = UIColor.clear.cgColor
        progressCircle.lineWidth = 3.5
        progressCircle.strokeStart = 0
        progressCircle.strokeEnd = CGFloat(ticketBought/totalTicket)
        circle.layer.addSublayer(progressCircle)
        self.contentView.addSubview(circle)
    }
}
