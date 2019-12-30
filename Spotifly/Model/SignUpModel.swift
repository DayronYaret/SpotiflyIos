//
//  SignUpModel.swift
//  Spotifly
//
//  Created by alumno on 30/12/2019.
//  Copyright © 2019 Dayron. All rights reserved.
//

import UIKit

import FirebaseAuth
import FirebaseDatabase

class SignUpModel {

    var error:Bool?
    var ref: DatabaseReference!
    
    
    func createAccount(username:String, email:String, password:String, completion: @escaping (Bool)->Void){
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //crear usuario
        Auth.auth().createUser(withEmail: email, password: password){ (result, err) in
            if(err != nil){
                completion(true)
                return
            }else{
                self.ref = Database.database().reference().child("usuarios").child(username.lowercased())
                var uid = Auth.auth().currentUser?.uid
                let user = ["email":email, "uId":uid, "username":username]
                self.ref.setValue(user)
                completion(false)
            }
        }
    }
    
}
