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
    }
    
}
