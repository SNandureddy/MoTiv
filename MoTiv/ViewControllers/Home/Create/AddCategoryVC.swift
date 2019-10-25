//
//  AddCategoryVC.swift
//  MoTiv
//
//  Created by IOS on 18/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

enum CategoryType: String{
    case publicCategory = "SELECT PUBLIC INTEREST"
    case musicCategory = "SELECT MUSIC INTEREST"
}

class AddCategoryVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var interestLabel: UILabel!
    
    //MARK: Variables
    var delegate: CategoryDelegate!
    var type: CategoryType = .publicCategory
    var categoryArray = [Interest]()
    var selectedArray = [Int]()
    
    //MARK: Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customiseUI()
    }
    
    private func customiseUI() {
        interestLabel.text = type.rawValue
        baseView.set(radius: 14.0)
        baseView.setShadow()
        self.view.backgroundColor = UIColor(red: 27/255, green: 27/255, blue: 27/255, alpha: 0.9)
        collectionView.reloadData()
    }
    
    //MARK: IBActions
    @IBAction func closeButtonAction(_ sender: UIButton) {
        delegate.didGetCategories(array: selectedArray, type: type)
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddCategoryVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selectCategoryCell", for: indexPath) as! SongAlbumCell
        cell.titleLabel.text = categoryArray[indexPath.row].name
        cell.albumImageView.sd_setImage(with: categoryArray[indexPath.row].image, placeholderImage: #imageLiteral(resourceName: "categoryPlaceholder"), options: .refreshCached) { (image, error, cache, url) in
            cell.albumImageView.image = image?.withRenderingMode(.alwaysTemplate)
        }
        cell.albumImageView.tintColor = selectedArray.contains(where: {$0 == categoryArray[indexPath.row].id}) ? UIColor.motivColor.baseColor.color(): UIColor.white
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension AddCategoryVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.collectionView.frame.size.width - 30 ) / 3, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SongAlbumCell
        if let index = selectedArray.firstIndex(where: {$0 == categoryArray[indexPath.row].id}) {
            selectedArray.remove(at: index)
            cell.albumImageView.tintColor = UIColor.white
        }
        else {
            selectedArray.append(categoryArray[indexPath.row].id ?? 0)
            cell.albumImageView.image?.withRenderingMode(.alwaysTemplate)
            cell.albumImageView.tintColor = UIColor.motivColor.baseColor.color()
        }
    }
}

