//
//  SubCategoryVC.swift
//  MoTiv
//
//  Created by IOS on 11/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class SubCategoryVC: BaseVC {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!

    var delegate: CategoryDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customiseUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func customiseUI() {
        baseView.set(radius: 14.0)
        baseView.setShadow()
        self.view.backgroundColor = UIColor(red: 27/255, green: 27/255, blue: 27/255, alpha: 0.9)
    }
    
    
    @IBAction func clossButtonAction(_ sender: UIButton) {
        delegate.didGetCategories(array: SelectCategoryVC.musicCategoryArray, type: .musicCategory)
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - UICollectionViewDataSource
extension SubCategoryVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CommonVM.shared.musicArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selectCategoryCell", for: indexPath) as! SongAlbumCell
        cell.titleLabel.text = CommonVM.shared.musicArray[indexPath.row].name
        cell.albumImageView.sd_setImage(with: CommonVM.shared.musicArray[indexPath.row].image, placeholderImage: #imageLiteral(resourceName: "Music01"), options: .refreshCached) { (image, error, cache, url) in
            cell.albumImageView.image = image?.withRenderingMode(.alwaysTemplate)
        }
        cell.albumImageView.tintColor = SelectCategoryVC.musicCategoryArray.contains(where: {$0 == CommonVM.shared.publicArray[indexPath.row].id}) ? UIColor.motivColor.baseColor.color(): UIColor.white
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension SubCategoryVC: UICollectionViewDelegateFlowLayout {
    
}

//MARK: - UICollectionViewDelegate
extension SubCategoryVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.collectionView.frame.size.width - 30 ) / 3, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SongAlbumCell
        if let index = SelectCategoryVC.musicCategoryArray.firstIndex(where: {$0 == CommonVM.shared.publicArray[indexPath.row].id}) {
            SelectCategoryVC.musicCategoryArray.remove(at: index)
            cell.albumImageView.tintColor = UIColor.white
        }
        else {
        SelectCategoryVC.musicCategoryArray.append(CommonVM.shared.publicArray[indexPath.row].id)
            cell.albumImageView.image?.withRenderingMode(.alwaysTemplate)
            cell.albumImageView.tintColor = UIColor.motivColor.baseColor.color()
        }
    }
}

