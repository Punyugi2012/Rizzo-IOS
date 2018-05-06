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
    
    @IBOutlet weak var currentQuestion: UILabel!
    @IBOutlet weak var questionImage: UIImageView!
    @IBOutlet weak var myView: UIView!
    @IBOutlet var myButtons: [UIButton]!
    var questions: [ImageQuestion] = []
    var bufferQuestions: [ImageQuestion] = []
    var buttonPlayer = AVAudioPlayer()
    var currentNumQuestion = 1
    var currentAnswer: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            buttonPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:Bundle.main.path(forResource: "touch", ofType: "mp3")!))
            buttonPlayer.prepareToPlay()
        }catch{
            print(error)
        }
        self.currentQuestion.text = "ข้อที่ \(self.currentNumQuestion) / 10"
        self.bufferQuestions = Datas.getImageQuestion()
//        for i in self.bufferQuestions {
//            if i.answers.count != 4 {
//                print(i.answer)
//                print("Error")
//            }
//            if UIImage(named: i.answer) == nil {
//                      print("\(i.answer) Error image")
//            }
//        }
        self.questions = chooseImageQuestion(10)
        setQuestion()
    }
    
    func chooseImageQuestion(_ number: Int) -> [ImageQuestion] {
        var imageQuestions: [ImageQuestion] = []
        var i = 1
        while i <= number {
            let random = Int(arc4random_uniform(UInt32(self.bufferQuestions.count)))
            if (imageQuestions.index { (imageQuestion) -> Bool in
                return imageQuestion.answer == self.bufferQuestions[random].answer
            }) == nil {
                imageQuestions.append(self.bufferQuestions[random])
                i += 1
            }
        }
        return imageQuestions
    }
    
    func setQuestion() {
        let numOfQuestion = Int(arc4random_uniform(UInt32(self.questions.count)))
        let question = self.questions[numOfQuestion]
        self.currentAnswer = question.answer
        self.questionImage.image = UIImage(named: question.answer)
//        print(self.currentAnswer)
        for i in 0...3 {
            self.myButtons[i].setTitle(question.answers[i], for: .normal)
        }
        self.questions.remove(at: numOfQuestion)
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
