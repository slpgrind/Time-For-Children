//
//  AppleSinkViewController.swift
//  Alex
//
//  Created by Alex Panganiban on 5/4/17.
//  Copyright © 2017 TFC. All rights reserved.
//

import UIKit
import AVFoundation

class AppleSinkViewController: UIViewController {
    var location = CGPoint(x: 0, y: 0);
    
    @IBOutlet weak var spoon: UIButton!
    @IBOutlet weak var apple: UIButton!
    @IBOutlet weak var inSink: UIButton!
    @IBOutlet weak var bowl: UIButton!
    
    var spoonTapped = false;
    var appleTapped = false;
    
    var spoonInSink = false;
    var appleInSink = false;
    
    var sinkSpoon = UIImage(named: "Sink_Spoon.png");
    var sinkAppleSpoon = UIImage(named: "Sink_AppleSpoon.png");
    
    //Load Audio
    var appleSpoonInSink = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "appleSpoonInSink", ofType: "mp3")!));
    
    var tryAgain = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "tryAgain", ofType: "mp3")!));
    
    var correct = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Correct", ofType: "mp3")!));
    
    
    var incorrect = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Incorrect", ofType: "mp3")!));
    
    var yay = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Yay", ofType: "mp3")!));
    
    
    
    

    override func viewDidLoad() {
        apple.isEnabled = false;
        spoon.isEnabled = false;
        inSink.isEnabled = false;
        
        appleSpoonInSink.play()
        
        let delay = DispatchTime.now() + 7 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: delay) {
            self.apple.isEnabled = true;
            self.spoon.isEnabled = true;
            self.inSink.isEnabled = true;
        }
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    @IBAction func spoonTapped(_ sender: Any) {
        spoonTapped = true;
    }

    @IBAction func appleTapped(_ sender: Any) {
        appleTapped = true;
        if !spoonInSink {
        tryAgain.play();
            appleTapped = false;
            spoonTapped = false;
            
            self.spoon.isEnabled = false;
            self.apple.isEnabled = false;
            let wait = DispatchTime.now() + 7 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: wait) {
                
                self.spoon.isEnabled = true;
                self.apple.isEnabled = true;
            
            }
        }
    }
    
    @IBAction func sinkTapped(_ sender: Any) {
        
        
        if spoonTapped {
            correct.play();
            UIView.transition(with: self.inSink, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.inSink.setImage(self.sinkSpoon, for: UIControlState())}, completion: nil)
            spoonInSink = true;
            spoon.isHidden = true;
            spoon.isEnabled = false;
        }
        if spoonInSink&&appleTapped {
            correct.play();
            UIView.transition(with: self.inSink, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.inSink.setImage(self.sinkAppleSpoon, for: UIControlState())}, completion: nil)
            
            apple.isHidden = true;
            spoon.isHidden = true;
            yay.play();
            let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "sink")
                self.show(vc as! UIViewController, sender: vc)
            }
        }
    }
    
    @IBAction func bowlTapped(_ sender: Any) {
        if spoonTapped{
            incorrect.play();
        }
        
        else if appleTapped{
            incorrect.play();
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
