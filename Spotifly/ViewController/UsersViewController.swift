//
//  UsersViewController.swift
//  Spotifly
//
//  Created by alumno on 30/12/2019.
//  Copyright © 2019 Dayron. All rights reserved.
//

import UIKit
import FirebaseAuth

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let userModel = UsersModel()
    var userList : [UserItem] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        cell.textLabel?.text = userList[indexPath.row].username
        return cell
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        userModel.fillArray { (error, array) in
            if(!error){
                self.userList = array
                self.tableView.reloadData()
                
            }
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func logoutButton(_ sender: Any) {
        
    let firebaseAuth = Auth.auth()
        do{
            try firebaseAuth.signOut()
            transitionToMain()
            
        }catch let signOutError as NSError {
            print("Error singin out: %@",signOutError)
        }
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "userSong"){
            if let indexPath = tableView.indexPathForSelectedRow{
                let userSongController = segue.destination as! UserSongViewController
                userSongController.usuario = self.userList[indexPath.row]
                
            }
        }
    }
    
    func transitionToMain(){
        let mainViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.navMainController) as? UINavigationController
        
        view.window?.rootViewController = mainViewController
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
