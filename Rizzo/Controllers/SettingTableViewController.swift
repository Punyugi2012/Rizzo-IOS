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
    var buttonPlayer: AVAudioPlayer?
    @IBOutlet weak var playSoundBg: UIButton!
    @IBOutlet weak var stopSoundBg: UIButton!
    @IBOutlet weak var playSoundBtn: UIButton!
    @IBOutlet weak var stopSoundBtn: UIButton!
    let TURNON = 1
    let TURNOFF = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.isScrollEnabled = false
        setBgSoundButton()
        setButtonSound()
    }
    
    func setBgSoundButton() {
        if self.getAudioPlayer.isPlaying {
            self.playSoundBg.backgroundColor = UIColor(red: 109/255.0, green: 192/255.0, blue: 102/255.0, alpha: 1)
            self.stopSoundBg.backgroundColor = UIColor.white
        }
        else {
            self.playSoundBg.backgroundColor = UIColor.white
            self.stopSoundBg.backgroundColor = UIColor(red: 109/255.0, green: 192/255.0, blue: 102/255.0, alpha: 1)
        }
    }
    
    func setButtonSound() {
        if let data = UserDefaults.standard.value(forKey: "btnSoundConfig") as? Int {
            if data == TURNON {
                self.playSoundBtn.backgroundColor = UIColor(red: 109/255.0, green: 192/255.0, blue: 102/255.0, alpha: 1)
                self.stopSoundBtn.backgroundColor = UIColor.white
                do {
                    buttonPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:Bundle.main.path(forResource: "touch", ofType: "mp3")!))
                    buttonPlayer?.prepareToPlay()
                }catch{
                    print(error)
                }
            }
            else {
                self.playSoundBtn.backgroundColor = UIColor.white
                self.stopSoundBtn.backgroundColor = UIColor(red: 109/255.0, green: 192/255.0, blue: 102/255.0, alpha: 1)
                buttonPlayer = nil
            }
        }
        else {
            UserDefaults.standard.set(TURNON, forKey: "btnSoundConfig")
            self.playSoundBtn.backgroundColor = UIColor(red: 109/255.0, green: 192/255.0, blue: 102/255.0, alpha: 1)
            self.stopSoundBtn.backgroundColor = UIColor.white
            do {
                buttonPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:Bundle.main.path(forResource: "touch", ofType: "mp3")!))
                buttonPlayer?.prepareToPlay()
            }catch{
                print(error)
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func playButton() {
        self.buttonPlayer?.stop()
        self.buttonPlayer?.currentTime = 0
        self.buttonPlayer?.play()
    }
    
    @IBAction func onPlaySound(_ sender: UIButton) {
        playButton()
        if !self.getAudioPlayer.isPlaying {
            self.getAudioPlayer.play()
            self.playSoundBg.backgroundColor = UIColor(red: 109/255.0, green: 192/255.0, blue: 102/255.0, alpha: 1)
            self.stopSoundBg.backgroundColor = UIColor.white
            UserDefaults.standard.set(TURNON, forKey: "bgSoundConfig")
        }
    }
    @IBAction func onStopSound(_ sender: UIButton) {
        playButton()
        if self.getAudioPlayer.isPlaying {
            self.getAudioPlayer.stop()
            self.playSoundBg.backgroundColor = UIColor.white
            self.stopSoundBg.backgroundColor = UIColor(red: 109/255.0, green: 192/255.0, blue: 102/255.0, alpha: 1)
            UserDefaults.standard.set(TURNOFF, forKey: "bgSoundConfig")
        }
    }
    @IBAction func onPlaySoundBtn(_ sender: UIButton) {
        playButton()
        if self.buttonPlayer == nil {
            UserDefaults.standard.set(TURNON, forKey: "btnSoundConfig")
            setButtonSound()
        }
    }
    @IBAction func onStopSoundBtn( _ sender: UIButton) {
        playButton()
        if self.buttonPlayer != nil {
            UserDefaults.standard.set(TURNOFF, forKey: "btnSoundConfig")
            setButtonSound()
        }
    }
    @IBAction func onBack(_ sender: UIButton) {
        playButton()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
