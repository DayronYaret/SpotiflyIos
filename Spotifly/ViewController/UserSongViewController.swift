//
//  UserSongViewController.swift
//  Spotifly
//
//  Created by alumno on 03/01/2020.
//  Copyright © 2020 Dayron. All rights reserved.
//

import UIKit

class UserSongViewController: UIViewController {
    
    @IBOutlet weak var titleButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    var usuario:UserItem?
    var userSong:SongItem?
    let userSongModel = UserSongModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(usuario)
        usernameLabel.text = usuario?.username
        titleButton.setTitle(usuario?.ultimaCancion, for: .normal)
        
        userSongModel.chosenSong(ultimaCancion: usuario!.ultimaCancion!) { (error, song) in
                if(error == false){
                    self.userSong = song
                }
            }
        // Do any additional setup after loading the view.

    }
    
    @IBAction func songButton(_ sender: Any) {


    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "userSongPlayer"){
            let playerController = segue.destination as! PlayerViewController
            playerController.song = self.userSong
            
            
        }
    }    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
