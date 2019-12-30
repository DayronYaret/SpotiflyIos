//
//  SignUpViewController.swift
//  Spotifly
//
//  Created by alumno on 30/12/2019.
//  Copyright © 2019 Dayron. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var SignUpButton: UIButton!
    
    var singupModel = SignUpModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        // Do any additional setup after loading the view.
    }
    
    //comprueba los campos y valida si los datos son correctos para ver si todo esta correcto, el metodo retorna nil, si algo pasa retorna el error
    func validateFields()->String?{
        
        //comprobar que los campos estan llenos
        if (usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            return "Por favor, rellene los campos"
        }
        
        return nil
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        // validar campos
        let error = validateFields()
        if error != nil{
            errorLabel.text = error!
            errorLabel.alpha=1
        }else{
            //crear usuario
            guard let username = self.usernameTextField.text else{return}
            guard let email = self.emailTextField.text else{return}
            guard let password = self.passwordTextField.text else{return}
            
            self.singupModel.createAccount(username: username, email: email, password: password) { (error) in
                if(error == true){
                    self.errorLabel.text = "Error creando el usuario"
                    self.errorLabel.alpha = 1
                }else{
                    //llevar a la siguiente pantalla
                    self.transitionToLogin()
                }
            }
            
        }
    }
    
    func setUpElements(){
        //ocultar el errorLabel para que aparezca solo cuando hay error
        errorLabel.alpha = 0
        
        //Estilo de los elementos del Storyboard
        Utilities.styleTextField(usernameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(SignUpButton)
    }
    
    func transitionToLogin(){
        let loginViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.loginViewController) as? LoginViewController
        
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
        
    }

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}




