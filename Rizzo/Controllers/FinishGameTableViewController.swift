//
//  FinishGameTableViewController.swift
//  Rizzo
//
//  Created by punyawee  on 7/5/61.
//  Copyright © พ.ศ. 2561 punyawee . All rights reserved.
//

import UIKit
import AVFoundation

class FinishGameTableViewController: UITableViewController {

    var buttonPlayer = AVAudioPlayer()
    var getCorrectQuestion = 0
    @IBOutlet weak var numCorrect: UILabel!
    @IBOutlet weak var numUncorrect: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.isScrollEnabled = false
        self.numCorrect.text = "\(getCorrectQuestion) ข้อ"
        self.numUncorrect.text = "\(10 - getCorrectQuestion) ข้อ"
        do {
            buttonPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:Bundle.main.path(forResource: "touch", ofType: "mp3")!))
            buttonPlayer.prepareToPlay()
        }catch{
            print(error)
        }

    }

    func playButton() {
        self.buttonPlayer.stop()
        self.buttonPlayer.currentTime = 0
        self.buttonPlayer.play()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    @IBAction func onPlayAgain(_ sender: UIButtonX) {
        playButton()
    }
    

}