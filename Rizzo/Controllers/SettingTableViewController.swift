//
//  SettingTableViewController.swift
//  Rizzo
//
//  Created by punyawee  on 5/5/61.
//  Copyright © พ.ศ. 2561 punyawee . All rights reserved.
//

import UIKit
import AVFoundation

class SettingTableViewController: UITableViewController {

    var getAudioPlayer = AVAudioPlayer()
    var buttonPlayer = AVAudioPlayer()
    @IBOutlet weak var playSoundButton: UIButton!
    @IBOutlet weak var stopSoundButton: UIButton!
    let TURNON_BGSOUND = 1
    let TURNOFF_BGSOUND = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.isScrollEnabled = false
        if self.getAudioPlayer.isPlaying {
            self.playSoundButton.backgroundColor = UIColor(red: 109/255.0, green: 192/255.0, blue: 102/255.0, alpha: 1)
            self.stopSoundButton.backgroundColor = UIColor.white
        }
        else {
            self.playSoundButton.backgroundColor = UIColor.white
            self.stopSoundButton.backgroundColor = UIColor(red: 109/255.0, green: 192/255.0, blue: 102/255.0, alpha: 1)
        }
        do {
            buttonPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:Bundle.main.path(forResource: "touch", ofType: "mp3")!))
            buttonPlayer.prepareToPlay()
        }catch{
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func playButton() {
        self.buttonPlayer.stop()
        self.buttonPlayer.currentTime = 0
        self.buttonPlayer.play()
    }
    
    @IBAction func onPlaySound(_ sender: UIButton) {
        playButton()
        if !self.getAudioPlayer.isPlaying {
            self.getAudioPlayer.play()
            self.playSoundButton.backgroundColor = UIColor(red: 109/255.0, green: 192/255.0, blue: 102/255.0, alpha: 1)
            self.stopSoundButton.backgroundColor = UIColor.white
            UserDefaults.standard.set(TURNON_BGSOUND, forKey: "bgSoundConfig")
        }
    }
    @IBAction func onStopSound(_ sender: UIButton) {
        playButton()
        if self.getAudioPlayer.isPlaying {
            self.getAudioPlayer.stop()
            self.playSoundButton.backgroundColor = UIColor.white
            self.stopSoundButton.backgroundColor = UIColor(red: 109/255.0, green: 192/255.0, blue: 102/255.0, alpha: 1)
            UserDefaults.standard.set(TURNOFF_BGSOUND, forKey: "bgSoundConfig")
        }
    }
    @IBAction func onBack(_ sender: UIButton) {
        playButton()
        self.buttonPlayer.stop()
        self.buttonPlayer.currentTime = 0
        self.buttonPlayer.play()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
