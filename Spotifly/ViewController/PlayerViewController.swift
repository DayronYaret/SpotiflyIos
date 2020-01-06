//
//  PlayerViewController.swift
//  Spotifly
//
//  Created by alumno on 03/01/2020.
//  Copyright © 2020 Dayron. All rights reserved.
//

import UIKit
import MediaPlayer
import FirebaseStorage
import AVFoundation

extension TimeInterval{
 func stringFromTimeInterval() -> String {
             let time = NSInteger(self)
             let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 1000)
             let seconds = time % 60
             let minutes = (time / 60) % 60
             let hours = (time / 3600)
             return String(format: "%0.2d:%0.2d",minutes,seconds)
 
         }
     }

class PlayerViewController: UIViewController{
 var audioPlayer:AVAudioPlayer!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var actualTimeLabel: UILabel!
    @IBOutlet weak var duartionLabel: UILabel!
    @IBOutlet var progressView: UIView!
    let playerModel = PlayerModel()
    var song:SongItem?
    var tiempoActual: TimeInterval = 0
    var duracion: TimeInterval?
    var timeCount:Int = 0
    var timer:Timer!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(song)
        titleLabel.text = song?.title
        artistLabel.text = song?.artist
        playerModel.songSelected(song: song!)
        let url = NSURL(string: song!.url)
        print("the url = \(url!)")
        downloadFileFromURL(url: url!)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
    }
    

    func downloadFileFromURL(url:NSURL){
        var downloadTask:URLSessionDownloadTask
        let request = URLRequest(url: url as URL)
        downloadTask = URLSession.shared.downloadTask(with: request, completionHandler: { (url, response, error) in
            self.play(url: url! as NSURL)
        })
        //downloadTask = URLSession.shared.downloadTask(with: request as URLRequest)
        downloadTask.resume()

    }
    
    func play(url:NSURL) {
        print("playing \(url)")
    
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: url as URL)
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 1.0
            audioPlayer.play()
            duracion = audioPlayer.duration
            DispatchQueue.main.async {
                self.duartionLabel.text = self.audioPlayer.duration.stringFromTimeInterval()

            }
            

        } catch let error as NSError {
            //self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
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
        if(audioPlayer.isPlaying){
            print("ya esta reproduciendo")
        }else{
            tiempoActual = audioPlayer.currentTime
            audioPlayer.play(atTime: tiempoActual ?? 0)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
            
        }
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        if(audioPlayer.isPlaying){
            audioPlayer.pause()
            timer?.invalidate()
        }else{
            print("no se esta reproduciendo nada")
            timer?.invalidate()
            
        }
    }
    
    
    @objc func timerDidFire(){
        timeCount += 1
    
        actualTimeLabel.text = NSString(format: "%02d:%02d:%02d", timeCount/3600,(timeCount/60)%60,timeCount%60) as String
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        audioPlayer.stop()
        timer?.invalidate()
        timer = nil
    }

    @objc func getTimeOfDate() {
    actualTimeLabel.text = audioPlayer.currentTime.stringFromTimeInterval()
    }
    
    
    @objc func update() {
        DispatchQueue.main.async {
            self.timeCount = self.timeCount+1
            self.actualTimeLabel.text = TimeInterval(self.timeCount).stringFromTimeInterval()

        }
    }
}

