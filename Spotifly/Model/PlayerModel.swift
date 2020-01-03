//
//  PlayerModel.swift
//  Spotifly
//
//  Created by alumno on 03/01/2020.
//  Copyright © 2020 Dayron. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class PlayerModel{
    
    var userItemArrayList:[UserItem] = []
    
        func songSelected(song:SongItem){
        var ref = Database.database().reference().child("usuarios")
        var uid = Auth.auth().currentUser?.uid
        ref.observeSingleEvent(of: .value) { (snapshot) in
                    var userItemArrayListdummy : [UserItem] = []
                   for child in snapshot.children{
                       if let snapshot = child as? DataSnapshot,
                           let user = UserItem(snapshot: snapshot){
                           userItemArrayListdummy.append(user)
                       }
                   }
                   self.userItemArrayList = userItemArrayListdummy
                       
                       for usuario in self.userItemArrayList{
                           if(usuario.uId == uid){
               ref.child(usuario.username.lowercased()).child("ultimaCancion").setValue(song.title)
                           }
                       }
        }
    }

}
