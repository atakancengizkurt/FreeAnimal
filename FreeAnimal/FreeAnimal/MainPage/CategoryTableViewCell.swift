//
//  CategoryTableViewCell.swift
//  FreeAnimal
//
//  Created by Glny Gl on 9.10.2018.
//  Copyright © 2018 Glny Gl. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

protocol MoreDelegate {
    func morePressed(_ indexPath: IndexPath)
}


class CategoryTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var animalCollectionView: UICollectionView!
    @IBOutlet weak var animalLabel: UILabel!
    
    var animal:Animal?
    var moreDelegate: MoreDelegate?
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        animalCollectionView.dataSource = self
        animalCollectionView.delegate = self
        
    }
    
    @IBAction func moreButtonPressed(_ sender: UIButton) {
        
     moreDelegate?.morePressed(indexPath!)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimalCollectionViewCell", for: indexPath) as! AnimalCollectionViewCell
        
        
        if let animalResult = self.animal?.results?[indexPath.row] {
            cell.descriptionLabel.text = animalResult.description
            cell.userNameLabel.text = animalResult.user?.username
            if let link = animalResult.urls?.regular {
                let imageURL = URL(string: link)
                cell.animalImageView.af_setImage(withURL: imageURL!)
            }else {
                cell.animalImageView.image = UIImage(named: "NoImage")
            }
        }else{
            cell.descriptionLabel.text = "Description"
            cell.userNameLabel.text = "by Username"
        }    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfCell: CGFloat = 3
        let cellWidth = UIScreen.main.bounds.size.width / numberOfCell
        return CGSize(width: cellWidth, height: self.contentView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
