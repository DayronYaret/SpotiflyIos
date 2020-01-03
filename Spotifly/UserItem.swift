//
//  UserItem.swift
//  Spotifly
//
//  Created by alumno on 30/12/2019.
//  Copyright © 2019 Dayron. All rights reserved.
//

import Foundation
import FirebaseDatabase
struct UserItem {
    
    let ref: DatabaseReference?
    let email:String
    let uId:String
    let ultimaCancion:String?
    let username:String
    let key:String
    
    init(email:String, uId:String, ultimaCancion:String?, username:String, key:String = "") {
        self.ref = nil
        self.key = key
        self.email = email
        self.uId = uId
        self.ultimaCancion = ultimaCancion
        self.username = username
    }

    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let email = value["email"] as? String,
            let uId = value["uId"] as? String,
            let ultimaCancion = value["ultimaCancion"] as? String,
            let username = value["username"] as? String
            else {return nil}
        self.key = snapshot.key
        self.ref = snapshot.ref
        self.email = email
        self.uId = uId
        self.ultimaCancion = ultimaCancion
        self.username = username
    }
    
    func toAnyObject() -> Any {
        return [
            "email" : email,
            "uId" : uId,
            "ultimaCancion" : ultimaCancion,
            "username" : username
        ]
    }
}
