//
//  Artist.swift
//  MVVMPractice
//
//  Created by Charles Kang on 12/5/16.
//  Copyright © 2016 Charles Kang. All rights reserved.
//

import Foundation

struct Artist {
    
    var identifier: String?
    var name: String?
    var uri: String?
    var genres: String?
    
    init(artist: [String: AnyObject]) {
        if let identifier = artist["id"] as? String {
            self.identifier = identifier
        }
        if let name = artist["name"] as? String {
            self.name = name
        }
        if let uri = artist["uri"] as? String {
            self.uri = uri
        }
        if let genres = artist["genres"]?.firstObject as? String {
            self.genres = genres
        }
        
    }
}
