//
//  ViewController.swift
//  MusicVideo
//
//  Created by Inna Ziskind on 28/11/2016.
//  Copyright © 2016 Inna Ziskind. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
    }


    func didLoadData(result:String) {
        let alert = UIAlertController(title: (result), message: nil, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { action -> Void in
            //do something if you want
        }
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        print(result)
    }

}

