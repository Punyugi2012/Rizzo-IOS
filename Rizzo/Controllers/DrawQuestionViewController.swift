//
//  DrawQuestionViewController.swift
//  Rizzo
//
//  Created by punyawee  on 10/5/61.
//  Copyright © พ.ศ. 2561 punyawee . All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire

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
    @IBOutlet weak var preview: UIView!
    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet var colorButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myLoadView.bounds.size.width = self.view.bounds.width
        self.myLoadView.bounds.size.height = self.view.bounds.height
        self.preview.bounds.size.width = self.view.bounds.width - 20
        self.preview.bounds.size.height = self.view.bounds.height - 20
        loadViewInside()
        Datas.getDrawQuestion { (result) in
            self.bufferQuestions = result
            self.question = self.chooseDrawQuestion()
            self.setButtonSound()
            self.setCurrentQuestion()
            self.myDrawView.currentWidth = 2
            self.setColorButtons()
            self.loadViewOutside()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToFinishDrawQuestion" {
            var points = Array(repeating: [Float](), count: 2)
            for stroke in self.myDrawView.strokes {
                points[0].append(Float(stroke.lastPoint.x))
                points[1].append(Float(stroke.lastPoint.y))
            }
            let parameters: Parameters = [
                "input_type": 0,
                "requests": [
                    [
                        "language": "quickdraw",
                        "writing_guide": [
                            "width": self.myDrawView.bounds.width,
                            "height": self.myDrawView.bounds.height
                        ],
                        "ink": [
                            points
                        ]
                    ]
                ]
            ]
            let destination = segue.destination as! FinishDrawQuestionTableViewController
            destination.params = parameters
            destination.question = self.question
            let image = UIImage(view: self.myDrawView)
            destination.imageDraw = image
        }
    }
    
    func setColorButtons() {
        for button in self.colorButtons {
            button.layer.cornerRadius = button.frame.width / 2
            button.clipsToBounds = true
        }
    }
    
    @IBAction func changeRowPen(_ sender: UIButton) {
        playButton()
        self.myDrawView.currentWidth = 2
    }
    @IBAction func changeMediumPen(_ sender: UIButton) {
        playButton()
        self.myDrawView.currentWidth = 5
    }
    @IBAction func changeHighPen(_ sender: UIButton) {
        playButton()
        self.myDrawView.currentWidth = 10
    }
    @IBAction func onClear() {
        playButton()
        self.myDrawView.clearDraw()
    }
    
    @IBAction func onUndo() {
        playButton()
        self.myDrawView.undo()
    }
    @IBAction func changeColor(_ sender: UIButton) {
        playButton()
        self.myDrawView.currentStrockColor = (sender.backgroundColor?.cgColor)!
    }
    @IBAction func onPreviewImage(_ sender: UIButton) {
        playButton()
        self.imagePreview.image = UIImage(named: self.question.answer)!
        self.preview.alpha = 0.5
        self.view.addSubview(self.preview)
        self.preview.center = self.view.center
        self.preview.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.preview.alpha = 1
            self.preview.transform = CGAffineTransform.identity
        })
    }
    
    @IBAction func onClosePreview(_ sender: UIButtonX) {
        playButton()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.preview.alpha = 0
            self.preview.transform = CGAffineTransform(scaleX: 0.5, y: 0.2)
        })
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
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    

}
