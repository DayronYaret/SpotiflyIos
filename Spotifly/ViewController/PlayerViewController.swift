//
//  PlayerViewController.swift
//  Spotifly
//
//  Created by alumno on 03/01/2020.
//  Copyright © 2020 Dayron. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var actualTimeLabel: UILabel!
    @IBOutlet weak var duartionLabel: UILabel!
    @IBOutlet var progressView: UIView!
    let playerModel = PlayerModel()
    var song:SongItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(song)
        titleLabel.text = song?.title
        artistLabel.text = song?.artist
        playerModel.songSelected(song: song!)
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
    @IBAction func playButton(_ sender: Any) {
    }
    
    @IBAction func pauseButton(_ sender: Any) {
    }
    
}
