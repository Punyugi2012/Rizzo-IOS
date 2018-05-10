//
//  DrawQuestionViewController.swift
//  Rizzo
//
//  Created by punyawee  on 10/5/61.
//  Copyright © พ.ศ. 2561 punyawee . All rights reserved.
//

import UIKit
import AVFoundation

class DrawQuestionViewController: UIViewController {

    let TURNON = 1
    let TURNOFF = 0
    var buttonPlayer: AVAudioPlayer?
    @IBOutlet weak var myLoadView: UIView!
    @IBOutlet weak var firstTextLoadView: UILabel!
    @IBOutlet weak var secondTextLoadView: UILabel!
    @IBOutlet weak var currentQuestion: UILabel!
    var question: DrawQuestion!
    var bufferQuestions: [DrawQuestion] = []
    @IBOutlet weak var myDrawView: DrawView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myLoadView.bounds.size.width = self.view.bounds.width
        self.myLoadView.bounds.size.height = self.view.bounds.height
        loadViewInside()
        Datas.getDrawQuestion { (result) in
            self.bufferQuestions = result
            self.question = self.chooseDrawQuestion()
            self.setButtonSound()
            self.setCurrentQuestion()
            self.myDrawView.currentWidth = 5
            self.loadViewOutside()
        }
    }
    
    @IBAction func onClear() {
        self.myDrawView.clearDraw()
    }
    
    @IBAction func onUndo() {
        self.myDrawView.undo()
    }
    
    func setCurrentQuestion() {
        self.currentQuestion.text = "จงวาด \(self.question.question)"
    }
    
    func chooseDrawQuestion() -> DrawQuestion {
        let random = Int(arc4random_uniform(UInt32(self.bufferQuestions.count)))
        return self.bufferQuestions[random]
    }
    
    
    func playButton() {
        self.buttonPlayer?.stop()
        self.buttonPlayer?.currentTime = 0
        self.buttonPlayer?.play()
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
    
    func loadViewInside() {
        self.view.addSubview(self.myLoadView)
        self.myLoadView.center = self.view.center
    }
    
    func loadViewOutside() {
        UIView.animate(withDuration: 0.5, animations: {
            self.firstTextLoadView.text = "เสร็จสิ้น"
            self.secondTextLoadView.text = ""
        }) { (true) in
            sleep(1)
            UIView.transition(with: self.myLoadView, duration: 0.4, options: [.transitionCrossDissolve], animations: {
                self.myLoadView.alpha = 0
            }) { (true) in
                self.myLoadView.removeFromSuperview()
            }
        }
    }
    

}
