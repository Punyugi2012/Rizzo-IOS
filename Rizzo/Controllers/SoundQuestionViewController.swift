//
//  SoundQuestionViewController.swift
//  Rizzo
//
//  Created by punyawee  on 7/5/61.
//  Copyright © พ.ศ. 2561 punyawee . All rights reserved.
//

import UIKit
import AVFoundation

extension UIButton {
    func pulsate(_ duration: TimeInterval) {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = duration
        pulse.fromValue = 0.77
        pulse.toValue = 1.0
        pulse.autoreverses = false
        pulse.repeatCount = 0
        pulse.initialVelocity = 0.5
        pulse.damping = 2.0
        layer.add(pulse, forKey: "pulse")
    }
}

class SoundQuestionViewController: UIViewController {

    @IBOutlet weak var myLoadView: UIView!
    @IBOutlet weak var firstTextLoadView: UILabel!
    @IBOutlet weak var secondTextLoadView: UILabel!
    @IBOutlet weak var popupReply: UILabel!
    @IBOutlet weak var popupAnswer: UILabel!
    @IBOutlet weak var popupLabel: UILabel!
    @IBOutlet weak var myPopup: UIView!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var mySpeaker: UIButton!
    @IBOutlet weak var currentQuestion: UILabel!
    @IBOutlet var myButtons: [UIButton]!
    var buttonPlayer: AVAudioPlayer?
    var speakerPlayer = AVAudioPlayer()
    var bufferQuestions: [SoundQuestion] = []
    var questions: [SoundQuestion] = []
    var currentAnswer = ""
    var correctQuestion = 0
    var currentNumQuestion = 0
    let TURNON = 1
    let TURNOFF = 0

    @IBAction func onSpeak(_ sender: UIButton) {
        if !self.speakerPlayer.isPlaying {
            self.mySpeaker.pulsate(speakerPlayer.duration)
            self.speakerPlayer.play()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myPopup.bounds.size.width = self.view.bounds.width - 200
        self.myPopup.bounds.size.height = self.view.bounds.height / 2
        self.myLoadView.bounds.size.width = self.view.bounds.width
        self.myLoadView.bounds.size.height = self.view.bounds.height
        self.firstTextLoadView.text = "กำลังโหลด...."
        self.secondTextLoadView.text = "กรุณารอสักครู่"
        loadViewInside()
        setCurrentQuestion()
        Datas.getSoundQuestions { (data) in
            self.bufferQuestions = data
            self.questions = self.chooseSoundQuestion(10)
            self.setQuestion()
            self.setButtonSound()
            self.loadViewOutside()
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
    
    
    func chooseSoundQuestion(_ number: Int) -> [SoundQuestion] {
        var soundQuestions: [SoundQuestion] = []
        var i = 1
        while i <= number {
            let random = Int(arc4random_uniform(UInt32(self.bufferQuestions.count)))
            if (soundQuestions.index { (soundQuestion) -> Bool in
                return soundQuestion.answer == self.bufferQuestions[random].answer
            }) == nil {
                soundQuestions.append(self.bufferQuestions[random])
                i += 1
            }
        }
        return soundQuestions
    }
    
    func setQuestion() {
        let numOfQuestion = Int(arc4random_uniform(UInt32(self.questions.count)))
        let question = self.questions[numOfQuestion]
        self.currentAnswer = question.answer
        do {
            speakerPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:Bundle.main.path(forResource: self.currentAnswer, ofType: "mp3")!))
            speakerPlayer.prepareToPlay()
        }catch{
            print(error)
        }
        for i in 0...3 {
            self.myButtons[i].setTitle(question.answers[i], for: .normal)
        }
        self.questions.remove(at: numOfQuestion)
    }
    
    @IBAction func onClose(_ sender: UIButton) {
        playButton()
    }
    
    func playButton() {
        self.buttonPlayer?.stop()
        self.buttonPlayer?.currentTime = 0
        self.buttonPlayer?.play()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func touchedAnswer(_ sender: UIButtonX) {
        playButton()
        if self.currentAnswer == sender.currentTitle {
            self.correctQuestion += 1
            setupCorrectPopup(sender.currentTitle!)
        }
        else {
            setupUnCorrectPopup(sender.currentTitle!)
        }
        disableAnswerButtons()
        self.speakerPlayer.stop()
        self.speakerPlayer.currentTime = 0
        self.mySpeaker.isEnabled = false
        insidePopup()
    }
    
    func setupCorrectPopup(_ reply: String) {
        self.popupLabel.text = "ถูกต้องนะครับ"
        self.popupLabel.textColor =  UIColor(red: 109/255.0, green: 192/255.0, blue: 102/255.0, alpha: 1)
        self.popupReply.text = reply
        self.popupReply.textColor =  UIColor(red: 109/255.0, green: 192/255.0, blue: 102/255.0, alpha: 1)
        self.popupAnswer.text = ""
    }
    
    func setupUnCorrectPopup(_ reply: String) {
        self.popupLabel.text = "ไม่ถูกต้อง"
        self.popupLabel.textColor = UIColor(red: 246/255.0, green: 84/255.0, blue: 106/255.0, alpha: 1)
        self.popupReply.text = reply
        self.popupReply.textColor = UIColor(red: 246/255.0, green: 84/255.0, blue: 106/255.0, alpha: 1)
        self.popupAnswer.text = "คำตอบคือ \(self.currentAnswer)"
    }
    
    func insidePopup() {
        self.myPopup.alpha = 0.5
        self.view.addSubview(self.myPopup)
        self.myPopup.center = self.view.center
        self.myPopup.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.myPopup.alpha = 1
            self.myPopup.transform = CGAffineTransform.identity
        })
    }
    
    func disableAnswerButtons() {
        for i in 0...3 {
            self.myButtons[i].isEnabled = false
        }
    }
    
    func ableAnswerButtons() {
        for i in 0...3 {
            self.myButtons[i].isEnabled = true
        }
    }
    
    func setCurrentQuestion() {
        self.currentNumQuestion += 1
        self.currentQuestion.text = "ข้อที่ \(self.currentNumQuestion) / 10"
    }
    
    @IBAction func onNext(_ sender: UIButtonX) {
        playButton()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.myPopup.alpha = 0
            self.myPopup.transform = CGAffineTransform(scaleX: 0.5, y: 0.2)
        }) { (true) in
            self.myPopup.removeFromSuperview()
            if self.questions.isEmpty {
                self.performSegue(withIdentifier: "ToFinishQuestion", sender: self)
            }
            else {
                UIView.transition(with: self.myView, duration: 0.4, options: [.transitionCrossDissolve], animations: {
                    self.myView.alpha = 0
                }, completion: { (true) in
                    self.setQuestion()
                    self.setCurrentQuestion()
                    UIView.transition(with: self.myView, duration: 0.4, options: [.transitionCrossDissolve], animations: {
                        self.myView.alpha = 1
                    }, completion: { (true) in
                        self.ableAnswerButtons()
                        self.mySpeaker.isEnabled = true
                    })
                })
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToFinishQuestion" {
            let destination = segue.destination as! FinishGameTableViewController
            destination.getCorrectQuestion = self.correctQuestion
            destination.getPreScene = "SoundQuestion"
        }
    }
    @IBAction func dissmiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
