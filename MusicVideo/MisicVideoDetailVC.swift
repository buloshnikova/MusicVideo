//
//  MisicVideoDetailVC.swift
//  MusicVideo
//
//  Created by Inna Ziskind on 03/12/2016.
//  Copyright © 2016 Inna Ziskind. All rights reserved.
//

import UIKit

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

    
}
