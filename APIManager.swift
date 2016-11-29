//
//  APIManager.swift
//  MusicVideo
//
//  Created by Inna Ziskind on 28/11/2016.
//  Copyright © 2016 Inna Ziskind. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(_ urlString:String, completion: @escaping (_ result:String) -> Void ) {
        
        
        let config = URLSessionConfiguration.ephemeral
        
        let session = URLSession(configuration: config)
        
        
        //        let session = NSURLSession.sharedSession()
        let url = URL(string: urlString)!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) -> Void in
            
            DispatchQueue.main.async {
                if error != nil {
                    completion((error!.localizedDescription))
                } else {
                    completion("NSURLSession successful")
                    print(data)
                }
            }
        })
        
        task.resume()
    }

}
