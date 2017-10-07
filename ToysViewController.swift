//
//  ToysViewController.swift
//  Alex
//
//  Created by Alex Panganiban on 4/16/17.
//  Copyright © 2017 TFC. All rights reserved.
//

import UIKit
import AVFoundation

class ToysViewController: UIViewController {

    @IBOutlet weak var ball1: UIButton!
    @IBOutlet weak var truck: UIButton!
    @IBOutlet weak var ball2: UIButton!
    
    //Check colored
    var ball1Colored = false;
    var ball2Colored = false;
    
    var truckColored = false;
    //Replace uncolored images with colored images
    var allColored = UIImageView(frame: CGRect(x: 0, y: 0, width: 1024, height: 768));
    var backgroundImage = UIImage(named: "Toys.png");
    
    var coloredTruck = UIImage(named: "Truck.png");
    var coloredBall1 = UIImage(named: "Ball1.png");
    var coloredBall2 = UIImage(named: "Ball2.png");
    
    
    //Load audio
    var tapTruckToColor = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "colorTruck", ofType: "mp3")!));
    
    var tapBallToColor = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "colorBall", ofType: "mp3")!));
    
    var tapOtherBall = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "colorOtherBall", ofType: "mp3")!));
    
    var onTable = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "onTable", ofType: "mp3")!));
    
    var underTable = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "underTable", ofType: "mp3")!));
    
    
    
    
    var veryNice = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "veryNice", ofType: "mp3")!));
    
    var inflate = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "ball", ofType: "wav")!));
    
    var vroom = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "truck", ofType: "wav")!));
    
    
    var usedAudio = [AVAudioPlayer]();
    
    var checkAudio = [AVAudioPlayer]();
    
    var audioPrompts = [AVAudioPlayer]();
    
    var secondPrompts = [AVAudioPlayer]();
    
    var thirdPrompts = [AVAudioPlayer]();
    
    var currentPrompt = AVAudioPlayer();
    
    
    override func viewDidLoad() {
        
        ball1.adjustsImageWhenDisabled = false;
        ball2.adjustsImageWhenDisabled = false;
        truck.adjustsImageWhenDisabled = false;
        
        
        ball1.isExclusiveTouch = true;
        ball2.isExclusiveTouch = true;
        truck.isExclusiveTouch = true;
        
        
        ball1.isEnabled = false;
        ball2.isEnabled = false;
        truck.isEnabled = false;
        
        let delay = DispatchTime.now() + 2 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: delay) {
            
            self.ball1.isEnabled = true;
            self.ball2.isEnabled = true;
            self.truck.isEnabled = true;
        }
        
        audioPrompts.append(tapTruckToColor);
        //audioPrompts.append(tapBallToColor);
        audioPrompts.append(onTable);
        audioPrompts.append(underTable);
        
        
        let randomIndex = Int(arc4random_uniform(UInt32(audioPrompts.count)))
        
        currentPrompt = audioPrompts[randomIndex];
        
        currentPrompt.play();
        usedAudio.append(currentPrompt);
        audioPrompts.remove(at: randomIndex);
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func allTrue() -> Bool{
        if (ball1Colored&&ball2Colored&&truckColored){
            return true;
        }
        else {
            return false;
        }
        
    }
    
    @IBAction func ball1Tapped(_ sender: Any) {
        
        
        
        if (ball2Colored&&truckColored) {
            self.ball1.isEnabled = false;
            
            self.ball1.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height);
            let image = UIImage(named: "Toys.png") as UIImage!;
            inflate.play();
            
            self.ball1.setImage(image, for: UIControlState())
            let delay = DispatchTime.now() + 2 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                
                self.veryNice.play();
            }
            
            let when = DispatchTime.now() + 4 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "Clothes")
                self.show(vc as! UIViewController, sender: vc)
            }
            
        }
            
        else if (currentPrompt == onTable) {
            self.ball1.isEnabled = false;
            ball2.isEnabled = false;
            truck.isEnabled = false;
            UIView.transition(with: self.ball1, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.ball1.setImage(self.coloredBall1, for: UIControlState())}, completion: nil)
            ball1Colored = true;
            inflate.play();
            
            if (!ball2Colored) {
                checkAudio.append(underTable);
            }
            if (truckColored==false){
                checkAudio.append(tapTruckToColor);
            }
            
            
            
            
            for file in checkAudio {
                for oldFile in usedAudio {
                    if (file != oldFile) {
                        secondPrompts.append(file)
                    }
                }
            }
            
            
            
            let randomIndex = Int(arc4random_uniform(UInt32(secondPrompts.count)))
            
            currentPrompt = secondPrompts[randomIndex];
            
            let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.currentPrompt.play();
                
                }
            
            
            let delay = DispatchTime.now() + 4.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
            self.ball2.isEnabled = true;
            if !self.truckColored {
                self.truck.isEnabled = true;
            }
            }
            
            usedAudio.append(currentPrompt);
            secondPrompts.remove(at: randomIndex);
        }
        /*
        else if (currentPrompt == tapOtherBall) {
            self.ball1.isEnabled = false;
            ball2.isEnabled = false;
            truck.isEnabled = false;
            UIView.transition(with: self.ball1, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.ball1.setImage(self.coloredBall1, for: UIControlState())}, completion: nil)
            ball1Colored = true;
            inflate.play();
            
            checkAudio.append(tapTruckToColor);
            
            
            
            
            if (!truckColored) {
                currentPrompt = tapTruckToColor
            }
            
            let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.currentPrompt.play();
                
            }
            let delay = DispatchTime.now() + 4.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
            if !self.truckColored {
                self.truck.isEnabled = true;
            }
            }
            usedAudio.append(currentPrompt);
        }
        */
    }

    @IBAction func ball2Tapped(_ sender: Any) {
        
        if (ball1Colored&&truckColored) {
            self.ball2.isEnabled = false;
            self.ball2.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height);
            let image = UIImage(named: "Toys.png") as UIImage!;
            inflate.play();
            
            self.ball2.setImage(image, for: UIControlState())
            let delay = DispatchTime.now() + 2 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                
                self.veryNice.play();
            }
            
            let when = DispatchTime.now() + 4 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "Clothes")
                self.show(vc as! UIViewController, sender: vc)
            }
            
        }
            
        else if (currentPrompt == underTable) {
            self.ball2.isEnabled = false;
            ball1.isEnabled = false;
            truck.isEnabled = false;
            UIView.transition(with: self.ball2, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.ball2.setImage(self.coloredBall2, for: UIControlState())}, completion: nil)
            ball2Colored = true;
            inflate.play();
            
            if (!ball1Colored) {
                checkAudio.append(onTable);
            }
            if (truckColored==false){
                checkAudio.append(tapTruckToColor);
            }
            
            
            
            
            for file in checkAudio {
                for oldFile in usedAudio {
                    if (file != oldFile) {
                        secondPrompts.append(file)
                    }
                }
            }
            
            
            
            let randomIndex = Int(arc4random_uniform(UInt32(secondPrompts.count)))
            
            currentPrompt = secondPrompts[randomIndex];
            
            let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.currentPrompt.play();
                
            }
            let delay = DispatchTime.now() + 4.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
            self.ball1.isEnabled = true;
            if !self.truckColored {
                self.truck.isEnabled = true;
            }
            }
            
            usedAudio.append(currentPrompt);
            secondPrompts.remove(at: randomIndex);
        }
         /*
        else if (currentPrompt == tapOtherBall) {
            self.ball2.isEnabled = false;
            ball1.isEnabled = false;
            truck.isEnabled = false;
            UIView.transition(with: self.ball2, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.ball2.setImage(self.coloredBall2, for: UIControlState())}, completion: nil)
            ball2Colored = true;
            inflate.play();
            
            checkAudio.append(tapTruckToColor);
            
            
            
            
            if (!truckColored) {
                currentPrompt = tapTruckToColor
            }
            
            let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.currentPrompt.play();
                
                
            }
            let delay = DispatchTime.now() + 4.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
            if !self.truckColored {
                self.truck.isEnabled = true;
            }
            }
            usedAudio.append(currentPrompt);
        }
        */
    }
    @IBAction func truckTapped(_ sender: Any) {

        
        if (ball1Colored&&ball2Colored) {
            self.truck.isEnabled = false;
            self.truck.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height);
            let image = UIImage(named: "Toys.png") as UIImage!;
            vroom.play();
            
            self.truck.setImage(image, for: UIControlState())
            let delay = DispatchTime.now() + 2 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                
                self.veryNice.play();
            }
            
            let when = DispatchTime.now() + 4 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "Clothes")
                self.show(vc as! UIViewController, sender: vc)
            }
            
        }
            
        else if (currentPrompt == tapTruckToColor) {
            self.truck.isEnabled = false;
            ball1.isEnabled = false;
            ball2.isEnabled = false;
            
            UIView.transition(with: self.truck, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.truck.setImage(self.coloredTruck, for: UIControlState())}, completion: nil)
            truckColored = true;
            vroom.play();
            
            
            if (ball1Colored==false&&ball2Colored==false){
                checkAudio.append(onTable);
                checkAudio.append(underTable);
            }
            
            if (ball1Colored && !ball2Colored) {
                checkAudio.append(underTable);
            }
            
            if (!ball1Colored && ball2Colored) {
                checkAudio.append(onTable);
            }
            
            
            for file in checkAudio {
                for oldFile in usedAudio {
                    if (file != oldFile) {
                        secondPrompts.append(file)
                    }
                }
            }
            
            
            
            let randomIndex = Int(arc4random_uniform(UInt32(secondPrompts.count)))
            
            currentPrompt = secondPrompts[randomIndex];
            
            let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.currentPrompt.play();
                
            }
            let delay = DispatchTime.now() + 4.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
            if !self.ball1Colored {
                self.ball1.isEnabled = true;
            }
            
            if !self.ball2Colored {
                self.ball2.isEnabled = true;
            }
            }
            usedAudio.append(currentPrompt);
            secondPrompts.remove(at: randomIndex);
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
