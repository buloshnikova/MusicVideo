//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by Inna Ziskind on 29/11/2016.
//  Copyright © 2016 Inna Ziskind. All rights reserved.
//

import Foundation

class Videos {
    
    // Data Encapsulation
    
    private var _vName:String
    private var _vImageUrl:String
    private var _vVideoUrl:String
    
    private var _vRights:String
    private var _vPrice:String
    private var _vArtist:String
    private var _vImid:String
    private var _vGenre:String
    private var _vLinkToiTunes:String
    private var _vReleaseDte:String
    
    //gets created from the UI
    var vImageData:NSData?
    
    // Getter
    
    var vName: String {
        return _vName
    }
    
    var vImageUrl: String {
        return _vImageUrl
    }
    
    var vVideoUrl: String {
        return _vVideoUrl
    }
    
    var vRights:String {
        return _vRights
    }
    
    var vPrice:String {
        return _vPrice
    }
    
    var vArtist:String {
        return _vArtist
    }
    
    var vImid:String {
        return _vImid
    }
    
    var vGenre:String {
        return _vGenre
    }
    
    var vLinkToiTunes:String {
        return _vLinkToiTunes
    }
    
    var vReleaseDte:String {
        return _vReleaseDte
    }
    
    init(data:JSONDictionary) {
        
        // Video name
        if let name = data["im:name"] as? JSONDictionary,
            let vName = name["label"] as? String {
            self._vName = vName
        }
        else {
            _vName = ""
        }
        
        // Video image
        if let imgarray = data["im:image"] as? JSONArray,
        let img = imgarray[2] as? JSONDictionary,
            let image = img["label"] as? String {
            _vImageUrl = image.replacingOccurrences(of: "100x100", with: "600x600")
        } else {
            _vImageUrl = ""
        }
        
        // Video url
        if let video = data["link"] as? JSONArray,
        let vUril = video[1] as? JSONDictionary,
        let vHref = vUril["attributes"] as? JSONDictionary,
            let vVideoUrl = vHref["href"] as? String  {
            _vVideoUrl = vVideoUrl
        } else {
            _vVideoUrl = ""
        }
        
        // Rights
        if let rights = data["rights"] as? JSONDictionary,
            let vRights = rights["label"] as? String {
            _vRights = vRights
        } else {
            _vRights = ""
        }
        
        // Price
        if let price = data["im:price"] as? JSONDictionary,
            let vPrice = price["label"] as? String {
            _vPrice = vPrice
        } else {
            _vPrice = ""
        }
        
        // Artist
        if let artist = data["im:artist"] as? JSONDictionary,
            let vArtist = artist["label"] as? String {
            _vArtist = vArtist
        } else {
            _vArtist = ""
        }
        
        // Imid
        if let id = data["id"] as? JSONDictionary,
            let idattr = id["attributes"] as? JSONDictionary,
            let imid = idattr["im:id"] as? String  {
            _vImid = imid
        } else {
            _vImid = ""
        }
        
        // Genre
        if let category = data["category"] as? JSONDictionary,
            let categoryattr = category["attributes"] as? JSONDictionary,
            let term = categoryattr["term"] as? String  {
            _vGenre = term
        } else {
            _vGenre = ""
        }

        
        // Link to iTunes
        if let iTunes = data["id"] as? JSONDictionary,
            let iTunesLabel = iTunes["label"] as? String {
            _vLinkToiTunes = iTunesLabel
        } else {
            _vLinkToiTunes = ""
        }
        
        // Release date
        if let releaseDate = data["im:releaseDate"] as? JSONDictionary,
            let dateAttr = releaseDate["attributes"] as? JSONDictionary,
            let dateLabel = dateAttr["label"] as? String  {
            _vReleaseDte = dateLabel
        } else {
            _vReleaseDte = ""
        }
    }
    
}
