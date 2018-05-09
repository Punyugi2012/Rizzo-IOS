//
//  PrepareSoundQTableViewController.swift
//  Rizzo
//
//  Created by punyawee  on 7/5/61.
//  Copyright © พ.ศ. 2561 punyawee . All rights reserved.
//

import UIKit
import AVFoundation

class PrepareSoundQTableViewController: UITableViewController {

    var bgSoundPlayer: AVAudioPlayer!
    var buttonPlayer: AVAudioPlayer?
    let TURNON = 1
    let TURNOFF = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.isScrollEnabled = false
        setButtonSound()
    }
    
    func setButtonSound() {
        if let data = UserDefaults.standard.value(forKey: "btnSoundConfig") as? Int {
            if data == TURNON {
                do {
                    buttonPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:Bundle.main.path(forResource: "touch", ofType: "mp3")!))
                    buttonPlayer?.prepareToPlay()
                }catch{
                    print(error)
                }
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
    @IBAction func onPlay(_ sender: UIButton) {
        playButton()
        bgSoundPlayer.pause()
    }
    @IBAction func onClose(_ sender: UIButton) {
        playButton()
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
