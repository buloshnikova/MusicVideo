//
//  MusicVideoTableViewCell.swift
//  MusicVideo
//
//  Created by Inna Ziskind on 02/12/2016.
//  Copyright © 2016 Inna Ziskind. All rights reserved.
//

import UIKit

class MusicVideoTableViewCell: UITableViewCell {

    var video: Videos? {
        didSet {
            updateCell()
        }
    }
    
    @IBOutlet weak var musicImage: UIImageView!

    @IBOutlet weak var rank: UILabel!
    
    @IBOutlet weak var musicTitle: UILabel!
    
    func updateCell() {
        
        musicTitle.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        rank.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        
        musicTitle.text = video?.vName
        rank.text = ("\(video!.vRank)")
        //musicImage.image = UIImage(named: "imageNotAvailable")
        
        if (video!.vImageData != nil) {
            print("Get data from array")
            musicImage.image = UIImage(data: video!.vImageData! as Data)
        } else {
            GetVideoImage(video: video!, imageView: musicImage)
            print("Get images in background thread")
            
        }
    }
    
    func GetVideoImage(video: Videos, imageView: UIImageView) {
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async {
            
            let data = try? Data(contentsOf: URL(string: video.vImageUrl)!)
            
            var image : UIImage?
            if data != nil {
                video.vImageData = data as NSData?
                image = UIImage(data: data!)
            }
            
            // move back to Main Queue
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
        
        
    }
}
