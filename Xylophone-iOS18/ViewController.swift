//
//  ViewController.swift
//  Xylophone-iOS18
//
//  Created by Dika Alfarell on 05/07/25.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer?
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
        }
    }

    @IBAction func keyPressed(_ sender: UIButton) {
        sender.layer.opacity = 0.2
        playSound(keyNote: sender.currentTitle!)
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
            sender.layer.opacity = 1
        }
    }
    
    func playSound(keyNote: String?) {
        guard let url = Bundle.main.url(forResource: keyNote, withExtension: "wav") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}

