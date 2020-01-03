//
//  SongItem.swift
//  Spotifly
//
//  Created by alumno on 30/12/2019.
//  Copyright © 2019 Dayron. All rights reserved.
//

import Foundation
import FirebaseDatabase
struct SongItem {
    
    let ref: DatabaseReference?
    let artist:String
    let title:String
    let url:String
    let key:String
    
    init(artist:String, title:String, url:String, key:String = "") {
        self.ref = nil
        self.key = key
        self.artist = artist
        self.title = title
        self.url = url
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let artist = value["artist"] as? String,
            let title = value["title"] as? String,
            let url = value["url"] as? String
            else {return nil}
        self.key = snapshot.key
        self.ref = snapshot.ref
        self.artist = artist
        self.title = title
        self.url = url
    }
    
    func toAnyObject() -> Any {
        return [
            "artist" : artist,
            "title" : title,
            "url" : url
        ]
    }
}
