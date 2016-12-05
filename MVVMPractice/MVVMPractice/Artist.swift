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
    var imageURL: String?
    
    init(artist: [String: AnyObject]) {
        if let identifier = artist["id"] as? String {
            self.identifier = identifier
        }
        if let name = artist["name"] as? String {
            self.name = name
        }
        if let image = artist["images"]?.firstObject as? [String: AnyObject],
            let url = image["url"] as? String {
            self.imageURL = url
        }
    }
}
