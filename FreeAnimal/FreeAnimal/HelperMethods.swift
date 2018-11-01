//
//  HelperMethods.swift
//  FreeAnimal
//
//  Created by Glny Gl on 9.10.2018.
//  Copyright © 2018 Glny Gl. All rights reserved.
//

import Foundation
import UIKit

class HelperMethods: NSObject {
    
    class func getCollectionViewCellSize () -> UICollectionViewFlowLayout {
        
        let widthSize = UIScreen.main.bounds.width/2 - 48
        let heightSize = UIScreen.main.bounds.height/3.6
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: widthSize, height: heightSize)
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsetsMake(10, 40, 10, 40)
//        layout.minimumLineSpacing = 20
        return layout
        
    }
    
    class func getTableViewCellSize (_ view: UIView) -> CGFloat {
        let navBarHeight = view.safeAreaInsets.top
        let bottomBarHeight = view.safeAreaInsets.bottom
        let barHeight = navBarHeight + bottomBarHeight
        return barHeight
    }
    
 
    
    
}
