//
//  AppleSink2ViewController.swift
//  Alex
//
//  Created by Alex Panganiban on 5/10/17.
//  Copyright © 2017 TFC. All rights reserved.
//

import UIKit
import AVFoundation

class AppleSink2ViewController: UIViewController {
    @IBOutlet weak var apple: UIButton!
    @IBOutlet weak var spoon: UIButton!
    @IBOutlet weak var inSink: UIButton!
    
    var appleTapped = false;
    var spoonTapped = false;
    
    var appleInSink = false;
    var spoonInSink = false;
    
    var waterdropsApple = UIImage(named: "Waterdrops_Apple.png");
    var waterdropsSpoon = UIImage(named: "Waterdrops_Spoon.png");
    
    var prompt = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "appleUnderWater", ofType: "wav")!));
    
    var correct = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Correct", ofType: "mp3")!));
    
    
    var incorrect = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Incorrect", ofType: "mp3")!));
    
    var water = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Water Sink", ofType: "wav")!));
    

    override func viewDidLoad() {
        super.viewDidLoad()
        apple.isEnabled = false;
        
        let wait = DispatchTime.now() + 1 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: wait) {
            self.prompt.play();
        }
        
        let delay = DispatchTime.now() + 6 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: delay) {
            self.apple.isEnabled = true;
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func appleTap(_ sender: Any) {
        appleTapped  = true;
    }

    @IBAction func spoonTap(_ sender: Any) {
    }
    @IBAction func sinkTap(_ sender: Any) {
        if appleTapped {
            apple.isHidden = true;
            correct.play();
            inSink.frame = CGRect(x: 255.0, y: 250.0, width: 100.0, height: 460.0)
            
            
            inSink.frame.size.width = 250
            
            
            self.water.play();
            
            
            UIView.transition(with: self.inSink, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.inSink.setImage(self.waterdropsApple, for: UIControlState())}, completion: nil)
            appleInSink = true;
            
            let when = DispatchTime.now() + 4 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "washedApple")
                self.show(vc as! UIViewController, sender: vc)
            }
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
