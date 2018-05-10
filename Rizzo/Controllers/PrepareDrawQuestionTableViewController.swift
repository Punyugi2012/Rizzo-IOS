//
//  PrepareDrawQuestionTableViewController.swift
//  Rizzo
//
//  Created by punyawee  on 9/5/61.
//  Copyright © พ.ศ. 2561 punyawee . All rights reserved.
//

import UIKit
import AVFoundation

class PrepareDrawQuestionTableViewController: UITableViewController {

    let TURNON = 1
    let TURNOFF = 0
    var buttonPlayer: AVAudioPlayer?
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
    
    func playButton() {
        self.buttonPlayer?.stop()
        self.buttonPlayer?.currentTime = 0
        self.buttonPlayer?.play()
    }
    
    @IBAction func onPlay(_ sender: UIButton) {
        playButton()
    }
    
    @IBAction func onClose(_ sender: UIButton) {
        playButton()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
