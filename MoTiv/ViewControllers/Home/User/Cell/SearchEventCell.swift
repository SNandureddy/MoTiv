//
//  SearchEventCell.swift
//  MoTiv
//
//  Created by Deftsoft on 06/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit
import SDWebImage
import AVKit

class SearchEventCell: UITableViewCell {
    
    //MARK: IBOutlets
    @IBOutlet weak var eventCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    //MARK: Variables
    var categoryEventDetailArray = [SearchEventDetail]()
    var navigationController = UINavigationController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        eventCollectionView.dataSource = self
        eventCollectionView.delegate = self
        eventCollectionView.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


//MARK: Collection View DataSource and Delegates

extension SearchEventCell: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryEventDetailArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kUserEventCell, for: indexPath) as! UserEventCell
        cell.eventNameLabel.text = categoryEventDetailArray[indexPath.row].eventName
        cell.priceLabel.text = "From \(Double(categoryEventDetailArray[indexPath.row].eventTicketPrice ?? 0).roundToTwoDecimal.amountValue)"
        cell.eventImageView?.sd_setImage(with: URL(string: categoryEventDetailArray[indexPath.row].eventImageURL ?? ""), placeholderImage: #imageLiteral(resourceName: "imagePlaceholder"), options: .cacheMemoryOnly, completed: nil)
        cell.playButton.isHidden = categoryEventDetailArray[indexPath.row].eventVideoURL == "" ? true : false
        cell.playButton.tag = indexPath.row
        cell.playButton.addTarget(self, action: #selector(self.playButtonAction(sender:)), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width-10)/2, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(storyboard: .Home)
        let detailvc = storyboard.instantiateViewController(withIdentifier: kEventDetails) as! EventDetailVC
        detailvc.selectedIndex = indexPath.row
        detailvc.type = .search
        detailvc.categoryEventDetailArray = self.categoryEventDetailArray
        self.navigationController.show(detailvc, sender: self)
    }
    
    @objc func playButtonAction(sender: UIButton) {
        if let url = URL(string: categoryEventDetailArray[sender.tag].eventVideoURL ?? ""){
            let player = AVPlayer(url: url)
            let controller=AVPlayerViewController()
            controller.player=player
            player.play()
            self.navigationController.present(controller, animated: true, completion: nil)
        }
    }
}

