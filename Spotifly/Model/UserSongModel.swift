//
//  UserSongModel.swift
//  Spotifly
//
//  Created by alumno on 03/01/2020.
//  Copyright © 2020 Dayron. All rights reserved.
//

import UIKit
import FirebaseDatabase

class UserSongModel{
    var songItemArrayList:[SongItem] = []
    var song:SongItem!
    
    func chosenSong(ultimaCancion:String, completion:@escaping(Bool, SongItem)-> Void ){
                
        let ref = Database.database().reference().child("songs")
        ref.observe(.value, with: { (snapshot) in
            
            var songItemArrayListdummy : [SongItem] = []
            print(snapshot.value)
            for child in snapshot.children{
                if let snapshot = child as? DataSnapshot,
                    let song = SongItem(snapshot: snapshot){
                    songItemArrayListdummy.append(song)
                    
                }
            }
            self.songItemArrayList = songItemArrayListdummy
            for songs in self.songItemArrayList{
                if(songs.title == ultimaCancion){
                    self.song = songs
                    
                }
                
            }
            
            completion(false,self.song)
        })
    }
}

