//
//  MisicVideoDetailVC.swift
//  MusicVideo
//
//  Created by Inna Ziskind on 03/12/2016.
//  Copyright © 2016 Inna Ziskind. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MisicVideoDetailVC: UIViewController {

    var videos: Videos!
    
    @IBOutlet weak var vName: UILabel!
    
    @IBOutlet weak var videoImage: UIImageView!
    
    @IBOutlet weak var vGenre: UILabel!
    
    @IBOutlet weak var vPrice: UILabel!
    
    @IBOutlet weak var vRights: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(MusicVideoTVC.preferredFontChange), name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
        
        vName.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        vPrice.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        vRights.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        vGenre.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        
        title = videos.vArtist
        vName.text = videos.vName
        vPrice.text = videos.vPrice
        vRights.text = videos.vRights
        vGenre.text = videos.vGenre
        
        if videos.vImageData != nil {
            videoImage.image = UIImage(data: videos.vImageData! as Data)
        } else {
            videoImage.image = UIImage(named: "imageNotAvailable")
        }
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "preferredFontChange"), object: nil)
    }
    
    
    @IBAction func socialMedia(_ sender: UIBarButtonItem) {
        
        shareMedia()
        
    }
    
    func shareMedia() {
        
        let activity1 = "Have you had the opportunity to see this Music Video?"
        let activity2 = ("\(videos.vName) b7 \(videos.vArtist)")
        let activity3 = "Watch it and tell me what you think?"
        let activity4 = videos.vLinkToiTunes
        let activity5 = "(Shared with the Music Video App - Step It UP!"
        
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [activity1, activity2, activity3, activity4, activity5], applicationActivities: nil)
        
        
        activityViewController.completionWithItemsHandler = {
            (activity, success, items, error) in
            
            if activity == UIActivityType.mail {
                print("Email selected")
            }
        }
        
        self.present(activityViewController, animated: true, completion: nil)
    }

    @IBAction func playVideo(_ sender: UIBarButtonItem) {
        
        let url = URL(string: videos.vVideoUrl)!
        let player = AVPlayer(url: url)
        
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        self.present(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
        
    }
    
    
    
    
    
}
