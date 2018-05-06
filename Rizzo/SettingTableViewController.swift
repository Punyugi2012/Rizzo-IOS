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
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
        }
    }
    @IBAction func onStopSound(_ sender: UIButton) {
        playButton()
        if self.getAudioPlayer.isPlaying {
            self.getAudioPlayer.stop()
            self.playSoundButton.backgroundColor = UIColor.white
            self.stopSoundButton.backgroundColor = UIColor(red: 109/255.0, green: 192/255.0, blue: 102/255.0, alpha: 1)
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
    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
