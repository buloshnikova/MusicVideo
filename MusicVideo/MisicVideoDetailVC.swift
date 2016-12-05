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
import LocalAuthentication

class MisicVideoDetailVC: UIViewController {

    var videos: Videos!
    
    var securitySwitch: Bool = false
    
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
        
        securitySwitch = UserDefaults.standard.bool(forKey: "SecSetting")
        
        switch securitySwitch {
        case true:
            touchIdChk()
        default:
            shareMedia()
        }
        
        
    }
    
    func touchIdChk() {
        // create an alert
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "continue", style: UIAlertActionStyle.cancel, handler: nil))
        
        // crreate the local authentication context
        let context = LAContext()
        var touchIDError: NSError?
        let reasonString = "Touch-Id authentication is needed to share info on Social Media"
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error:&touchIDError) {
            // Check what the authentication response was
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success, policyError) -> Void in
                if success {
                    // User authenticated using Local Device Authentication Successfully!
                    DispatchQueue.main.async() { [unowned self] in
                        self.shareMedia()
                    }
                } else {
                    
                    alert.title = "Unsuccessful!"
                    
                    switch LAError(_nsError: policyError! as NSError) {
                        
                    case LAError.appCancel:
                        alert.message = "Authentication was cancelled by application"
                        
                    case LAError.authenticationFailed:
                        alert.message = "The user failed to provide valid credentials"
                        
                    case LAError.passcodeNotSet:
                        alert.message = "Passcode is not set on the device"
                        
                    case LAError.systemCancel:
                        alert.message = "Authentication was cancelled by the system"
                        
                    case LAError.touchIDLockout:
                        alert.message = "Too many failed attempts."
                        
                    case LAError.userCancel:
                        alert.message = "You cancelled the request"
                        
                    case LAError.userFallback:
                        alert.message = "Password not accepted, must use Touch-ID"
                        
                    default:
                        alert.message = "Unable to Authenticate!"
                        
                    }
                    
                    // Show the alert
                    DispatchQueue.main.async {
                        [unowned self] in
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            })
        } else {
            // Unable to access local device authentication
            
            // Set the error title
            alert.title = "Error"
            
            // Set the error alert message with more information
            switch LAError.Code(rawValue: touchIDError!.code)! {
                
            case .touchIDNotEnrolled:
                alert.message = "Touch ID is not enrolled"
                
            case .touchIDNotAvailable:
                alert.message = "TouchID is not available on the device"
                
            case .passcodeNotSet:
                alert.message = "Passcode has not been set"
                
            case .invalidContext:
                alert.message = "The context is invalid"
                
            default:
                alert.message = "Local Authentication not available"
            }
            
            // Show the alert
            DispatchQueue.main.async () { [unowned self] in
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        
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
