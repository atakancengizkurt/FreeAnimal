//
//  MainViewController.swift
//  FreeAnimal
//
//  Created by Glny Gl on 9.10.2018.
//  Copyright © 2018 Glny Gl. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwipeView

class MainViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, MoreDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var sliderSwipeView: SwipeView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    
    var cat,dog,rabbit,bird: Animal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryTableView.dataSource = self
        categoryTableView.delegate = self
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.animalLabel.text = "Dog"
            
            JSONServise.getJSON("dog", 1, success: { (responseData) in
                self.dog = responseData
                cell.animal = responseData
                cell.animalCollectionView.reloadData()
            }) { (error) in
                print(error)
            }
            
        case 1:
            cell.animalLabel.text = "Rabbit"
            
            JSONServise.getJSON("rabbit", 1, success: { (responseData) in
                self.rabbit = responseData
                cell.animal = responseData
                cell.animalCollectionView.reloadData()
            }) { (error) in
                print(error)
            }
            
        case 2:
            cell.animalLabel.text = "Bird"
            
            JSONServise.getJSON("bird", 1, success: { (responseData) in
                self.bird = responseData
                cell.animal = responseData
                cell.animalCollectionView.reloadData()
            }) { (error) in
                print(error)
            }
            
        default:
            cell.animalLabel.text = "Animal"
        }
        
        cell.moreDelegate=self
        cell.indexPath = indexPath
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let heightSize = (UIScreen.main.bounds.height - HelperMethods.getTableViewCellSize(self.view)) / 3.2
        return heightSize
    }
    
    
    func morePressed(_ indexPath: IndexPath) {
        
        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let moreViewController = mainStoryboard.instantiateViewController(withIdentifier: "MoreViewController") as! MoreViewController
        
        switch indexPath.row {
        case 0:
            moreViewController.animal = self.dog
            moreViewController.animalName = "dog"
            moreViewController.navigationItem.title = "Dog"
        case 1:
            moreViewController.animal = self.rabbit
            moreViewController.animalName = "rabbit"
            moreViewController.navigationItem.title = "Rabbit"
        case 2:
            moreViewController.animal = self.bird
            moreViewController.animalName = "bird"
            moreViewController.navigationItem.title = "Bird"
        default:
            print("Default")
        }
        
        self.navigationController?.pushViewController(moreViewController, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCollectionViewCell", for: indexPath) as! SliderCollectionViewCell
        
        JSONServise.getJSON("cat", 1, success: { (responseData) in
            self.cat = responseData
            if let catResult = self.cat?.results?[indexPath.row] {
                if let link = catResult.urls?.regular {
                    let imageURL = URL(string: link)
                    cell.sliderImageView.af_setImage(withURL: imageURL!)
                }else {
                    cell.sliderImageView.image = UIImage(named: "NoImage")
                }
            }
        }) { (error) in
            print(error)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
       return CGSize(width: sliderCollectionView.bounds.width, height: sliderCollectionView.bounds.height)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
        
        //        pageControl.currentPage = ((sliderCollectionView.indexPathsForVisibleItems.first as NSIndexPath?)?.row)!
        //        sliderCollectionView.endEditing(true)
    }

}
