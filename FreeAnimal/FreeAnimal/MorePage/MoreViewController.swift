//
//  MoreViewController.swift
//  FreeAnimal
//
//  Created by Glny Gl on 9.10.2018.
//  Copyright © 2018 Glny Gl. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SVProgressHUD

class MoreViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    var animal: Animal?
    var isLoadingMore = false
    var page = 1
    var animalName = ""
    
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listCollectionView.dataSource = self
        listCollectionView.delegate = self
        listCollectionView.collectionViewLayout = HelperMethods.getCollectionViewCellSize()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.animal?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCell", for: indexPath) as! ListCollectionViewCell
        
        if let animalResult = self.animal?.results?[indexPath.row] {
            cell.descriptionLabel.text = animalResult.description
            cell.userNameLabel.text = animalResult.user?.username
            if let link = animalResult.urls?.regular {
                let imageURL = URL(string: link)
                cell.animalImageView.image = nil
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (self.animal?.results?.count)! - 1 {
            loadMoreJSON()
            self.page += 1
        }
    }
    
    func loadMoreJSON(){
        
        if self.isLoadingMore
        {
            return
            
        }
            self.isLoadingMore = true
            let baseURL = "https://api.unsplash.com/"
            let clintID = "869f6830c0c80b50e4fc96a8d07b4127fae9bb508440d95d378b4dd2edbefd54"
            let url = "\(baseURL)search/photos?page=\(page+1)&query=\(String(describing: animalName)))&client_id=\(clintID)"
        
            SVProgressHUD.show()
        
            Alamofire.request(url).responseJSON { (response) -> Void in
                if response.result.isFailure {
                    print("Error")
                } else {
                    guard let data = response.data else { return }
                    do {
                        let decoder = JSONDecoder()
                        let jData = try decoder.decode(Animal.self, from: data)
                        self.animal?.results?.append(contentsOf: (jData.results ?? []))
                        self.listCollectionView.reloadData()
                        self.isLoadingMore = false
                    } catch let err {
                        print("Err", err)
                    }
                }
                SVProgressHUD.dismiss()
            }
        
    }
    
}

