//
//  ViewController.swift
//  MusicVideo
//
//  Created by Inna Ziskind on 28/11/2016.
//  Copyright © 2016 Inna Ziskind. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var videos = [Videos]()
    
    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.reachabilityStatusChanged), name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
        
        reachabilityStatusChanged()
        
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
    }


    func didLoadData(videos: [Videos]) {
        print(reachabilityStatus)
        
        self.videos = videos
        
        for item in videos {
            print("name = \(item.vName)")
        }
    }

    func reachabilityStatusChanged()
    {
        switch reachabilityStatus {
        case NOACCESS: view.backgroundColor = UIColor.red
        displayLabel.text = "No Interntet"
        case WIFI: view.backgroundColor = UIColor.green
        displayLabel.text = "Reachable with WIFI"
        case WWAN: view.backgroundColor = UIColor.yellow
        displayLabel.text = "Reachable with Cellular"
        default: return
        }
    }
    
    // Is called when the object is about to be deallocated
    deinit
    {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
    }

}

