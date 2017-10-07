//
//  AppleSinkDragViewController.swift
//  Alex
//
//  Created by Alex Panganiban on 5/18/17.
//  Copyright © 2017 TFC. All rights reserved.
//

import UIKit
import AVFoundation

class AppleSinkDragViewController: UIViewController {
    var location = CGPoint(x: 0, y: 0);
    
    @IBOutlet weak var apple: UIImageView!
    @IBOutlet weak var spoon: UIImageView!
    @IBOutlet weak var inSink: UIImageView!
    @IBOutlet weak var bowl: UIImageView!
    
    
    var sinkSpoon = UIImage(named: "Sink_Spoon.png");
    var sinkAppleSpoon = UIImage(named: "Sink_AppleSpoon.png");
    
    //Load Audio
    var appleSpoonInSink = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "appleSpoonInSink", ofType: "mp3")!));
    
    var tryAgain = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "tryAgain", ofType: "mp3")!));
    
    var correct = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Correct", ofType: "mp3")!));
    
    
    var incorrect = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Incorrect", ofType: "mp3")!));
    
    var yay = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Yay", ofType: "mp3")!));

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var touch : UITouch! = touches.first! as UITouch;
        
        location = touch.location(in: self.view);
        
        if apple.frame.contains(location){
            apple.center = location;
        }
            
        else if spoon.frame.contains(location){
            spoon.center = location;
        }
    }
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        var touch : UITouch! = touches.first! as UITouch;
        
        location = touch.location(in: self.view);
        
        if apple.frame.contains(location) {
            apple.center = location;
        }
            
        else if spoon.frame.contains(location){
            spoon.center = location;
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        var touch : UITouch! = touches.first! as UITouch;
        
        
        location = touch.location(in: self.view);
        
        if inSink.frame.contains(spoon.center) && bowl.frame.contains(apple.center){
            correct.play()
            self.view.isUserInteractionEnabled = false
            
            let delay = DispatchTime.now() + 2 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.view.isUserInteractionEnabled = true
            }
            inSink.image = sinkSpoon;
            spoon.center = CGPoint(x: (inSink.frame.origin.x) + 100, y: (inSink.frame.origin.y) + 100);
            inSink.isHidden = false;
            
            spoon.isHidden = true;
            
        }
        
        
        if bowl.frame.contains(apple.center) && !spoon.isHidden{
            incorrect.play();
            self.view.isUserInteractionEnabled = false
            let delay = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.tryAgain.play();
            }
            
            
            let when = DispatchTime.now() + 11 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.view.isUserInteractionEnabled = true
            }
            
        }
        
        if bowl.frame.contains(spoon.center){
            incorrect.play();
            self.view.isUserInteractionEnabled = false
            let delay = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.tryAgain.play();
            }
            
            
            let when = DispatchTime.now() + 11 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.view.isUserInteractionEnabled = true
            }
            
        }
        
        if bowl.frame.contains(spoon.center) && apple.isHidden{
            incorrect.play();
            self.view.isUserInteractionEnabled = false
            let delay = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.tryAgain.play();
            }
            
            
            let when = DispatchTime.now() + 11 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.view.isUserInteractionEnabled = true
            }
           
        }
        
        
        
        if bowl.frame.contains(apple.center) && !(inSink.frame.contains(spoon.center)) {
            incorrect.play();
            self.view.isUserInteractionEnabled = false
            let delay = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.tryAgain.play();
            }
            
            
            let when = DispatchTime.now() + 11 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.view.isUserInteractionEnabled = true
            }
            
            
        }
 
        
        if inSink.frame.contains(spoon.center) && !spoon.isHidden{
            correct.play()
            self.view.isUserInteractionEnabled = false
            
            let delay = DispatchTime.now() + 2 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.view.isUserInteractionEnabled = true
            }
            inSink.image = sinkSpoon;
            spoon.center = CGPoint(x: (inSink.frame.origin.x) + 100, y: (inSink.frame.origin.y) + 100);
            inSink.isHidden = false;
            
            spoon.isHidden = true;
            
        }
        
        /*
        if (spoon.isHidden&&bowl.frame.contains(apple.center)) {
            incorrect.play();
            self.view.isUserInteractionEnabled = false
            let delay = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.tryAgain.play();
            }
            
            
            
            let when = DispatchTime.now() + 11 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.view.isUserInteractionEnabled = true
            }
            
        }
 */
        
        if spoon.isHidden == true && inSink.frame.contains(apple.center) {
            inSink.image = sinkAppleSpoon;
            correct.play()
            
            let delay = DispatchTime.now() + 2 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.view.isUserInteractionEnabled = false
            }
            inSink.isHidden = false;
            
            apple.isHidden = true;
            yay.play();
            let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "sink")
                self.show(vc as! UIViewController, sender: vc)
            }
        }
        
        
        
        
    }
    
    
    override func viewDidLoad() {
        appleSpoonInSink.play()
        self.view.isUserInteractionEnabled = false
        
        let when = DispatchTime.now() + 6 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.view.isUserInteractionEnabled = true
        }
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
