//
//  ServiceManager.swift
//  FreeAnimal
//
//  Created by Glny Gl on 13.10.2018.
//  Copyright © 2018 Glny Gl. All rights reserved.
//

import Foundation
import Alamofire

class JSONServise: NSObject {
    
    
    static func getJSON(_ animalName: String, _ page: Int, success:@escaping (Animal) -> Void, failure: @escaping (String) -> Void)  {
        
        let baseURL = "https://api.unsplash.com/"
        let clintID = "869f6830c0c80b50e4fc96a8d07b4127fae9bb508440d95d378b4dd2edbefd54"
        let URL = "\(baseURL)search/photos?page=\(page)&query=\(animalName)&client_id=\(clintID)"
        var animal: Animal?
        
        Alamofire.request(URL).responseJSON { (response) -> Void in
            if response.result.isFailure {
                print("Error")
            } else {
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let jData = try decoder.decode(Animal.self, from: data)
                    animal = jData
                    success(animal!)
                } catch let err {
                    print("Err", err)
                }
            }
        }
    }
    
}

