//
//  ImageQuestionViewController.swift
//  Rizzo
//
//  Created by punyawee  on 6/5/61.
//  Copyright © พ.ศ. 2561 punyawee . All rights reserved.
//

import UIKit
import AVFoundation

class ImageQuestionViewController: UIViewController {
    
    var buttonPlayer = AVAudioPlayer()
    @IBOutlet weak var questionImage: UIImageView!
    @IBOutlet weak var myView: UIView!
    @IBOutlet var myButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            buttonPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:Bundle.main.path(forResource: "touch", ofType: "mp3")!))
            buttonPlayer.prepareToPlay()
        }catch{
            print(error)
        }
    }
    
    @IBAction func onClose(_ sender: UIButton) {
        playButton()
    }
    
    func playButton() {
        self.buttonPlayer.stop()
        self.buttonPlayer.currentTime = 0
        self.buttonPlayer.play()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func touchedAnswer(_ sender: UIButtonX) {
        playButton()
    }
    


}
