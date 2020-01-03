//
//  ViewController.swift
//  Spotifly
//
//  Created by alumno on 30/12/2019.
//  Copyright © 2019 Dayron. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                if(Auth.auth().currentUser != nil){
                    print("hola")
                    DispatchQueue.main.async {
                        self.transitionToMain()
        
                    }
                }else{
                    print("adios")
                    setUpElements()
                }
        // Do any additional setup after loading the view.
    }
    
        func transitionToMain(){
                let tabBarController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabBarController) as? UITabBarController
                              
                self.view.window?.rootViewController = tabBarController
                self.view.window?.makeKeyAndVisible()
    
            }
    func setUpElements(){
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
    }

}

