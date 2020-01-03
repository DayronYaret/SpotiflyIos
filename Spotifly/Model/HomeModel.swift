//
//  HomeModel.swift
//  Spotifly
//
//  Created by alumno on 30/12/2019.
//  Copyright © 2019 Dayron. All rights reserved.
//

import UIKit
import FirebaseDatabase

class HomeModel{
    var songItemArrayList: [SongItem] = []
    var cantidad: Int?
    
    func fillArray(completion: @escaping (Bool, [SongItem]) -> Void){
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
            self.cantidad = songItemArrayListdummy.count
            self.songItemArrayList = songItemArrayListdummy
            completion(false,self.songItemArrayList)
            Constants.Values.array = self.songItemArrayList
                    
        })
    
    }
    
    
}
