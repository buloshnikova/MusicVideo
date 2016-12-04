//
//  AboutVC.swift
//  MusicVideo
//
//  Created by Inna Ziskind on 04/12/2016.
//  Copyright © 2016 Inna Ziskind. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {

    @IBOutlet weak var subtitle: UILabel!
    
    @IBOutlet weak var aboutText: UITextField!
    
    @IBOutlet weak var imageAbout: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(AboutVC.preferredFontChange), name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)

        title = "About"
        aboutText.text = "Some text"
        
    }

    func preferredFontChange() {
        subtitle.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        aboutText.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
    }

    deinit
    {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "preferredFontChange"), object: nil)
    }

}
