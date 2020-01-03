//
//  UsersModel.swift
//  Spotifly
//
//  Created by alumno on 30/12/2019.
//  Copyright © 2019 Dayron. All rights reserved.
//

import UIKit
import FirebaseDatabase
class UsersModel{
    var userItemArrayList: [UserItem] = []
    var cantidad: Int?
    
    func fillArray(completion: @escaping (Bool, [UserItem]) -> Void){
        let ref = Database.database().reference().child("usuarios")
        ref.observe(.value, with: { (snapshot) in
            
            var userItemArrayListdummy : [UserItem] = []
            for child in snapshot.children{
                if let snapshot = child as? DataSnapshot,
                    let user = UserItem(snapshot: snapshot){
                    userItemArrayListdummy.append(user)
                    
                }
            }
            self.cantidad = userItemArrayListdummy.count
            self.userItemArrayList = userItemArrayListdummy
            completion(false,self.userItemArrayList)
            Constants.Values.arrayU = self.userItemArrayList
                    
        })
    
    }
}
