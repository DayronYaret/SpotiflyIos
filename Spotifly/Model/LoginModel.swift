//
//  LoginModel.swift
//  Spotifly
//
//  Created by alumno on 30/12/2019.
//  Copyright © 2019 Dayron. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginModel{
    var error: Bool?
    var ref: DatabaseReference!

    func login(email:String, password:String, completion:@escaping(Bool, Error?)-> Void){
        Auth.auth().signIn(withEmail: email, password: password){(result, error) in
            if(error != nil){
                completion(true, error)
            }else{
                completion(false, error)
            }
        }
        
    }
}
