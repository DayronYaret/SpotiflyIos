//
//  AddSongsViewController.swift
//  Spotifly
//
//  Created by alumno on 30/12/2019.
//  Copyright © 2019 Dayron. All rights reserved.
//

import UIKit
import FirebaseAuth
import MediaPlayer

class AddSongsViewController: UIViewController, MPMediaPickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func logoutButton(_ sender: Any) {
        
    let firebaseAuth = Auth.auth()
            do{
                try firebaseAuth.signOut()
                transitionToMain()
                
            }catch let signOutError as NSError {
                print("Error singin out: %@",signOutError)
        }
    }
    
    func transitionToMain(){
        let mainViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.navMainController) as? UINavigationController
        
        view.window?.rootViewController = mainViewController
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func selectSongs(_ sender: UIButton) {
        let controller = MPMediaPickerController(mediaTypes: .music)
        controller.allowsPickingMultipleItems = true
        controller.popoverPresentationController?.sourceView = sender
        controller.delegate = self
        present(controller, animated: true)
    }
    func mediaPicker(_ mediaPicker: MPMediaPickerController,
                     didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        // Get the system music player.
        let musicPlayer = MPMusicPlayerController.systemMusicPlayer
        musicPlayer.setQueue(with: mediaItemCollection)
        mediaPicker.dismiss(animated: true)
        // Begin playback.
        musicPlayer.play()
    }
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        mediaPicker.dismiss(animated: true)
    }
    
}
