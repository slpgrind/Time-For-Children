//
//  DuckColoringViewController.swift
//  Alex
//
//  Created by Alex Panganiban on 4/6/17.
//  Copyright © 2017 TFC. All rights reserved.
//

import UIKit
import AVFoundation






class DuckColoringViewController: UIViewController {
    
    @IBOutlet weak var duck1: UIButton!
    @IBOutlet weak var duck2: UIButton!
    @IBOutlet weak var fish1: UIButton!
    @IBOutlet weak var fish2: UIButton!
    @IBOutlet var panButton: UIButton!
    
   
    
    
    //Check colored
    var duck1Colored = false;
    var duck2Colored = false;
    
    var fish1Colored = false;
    var fish2Colored = false;

    //Replace uncolored images with colored images
    var allColored = UIImageView(frame: CGRect(x: 0, y: 0, width: 1024, height: 768));
    var backgroundImage = UIImage(named: "Ducks.png");
    
    var duck = UIImage(named: "Duck.png");
    var fish = UIImage(named: "Fish.png");
    
    //Load Audio
    var tapFishToColor = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "colorFish", ofType: "mp3")!));
    
    var tapDuckToColor = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "colorDuck2", ofType: "mp3")!));
    
    var colorAnotherDuck = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "color2ndDuck", ofType: "mp3")!));
    
    var colorAnotherfish = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "colorAnotherFish", ofType: "mp3")!));
    
    //var colorOtherDuck = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "colorOtherDuck", ofType: "mp3")!));
    
    //var colorOtherFish = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "colorOtherFish", ofType: "mp3")!));
    
    var listenColorDuck = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "listenColorDuck", ofType: "mp3")!));
    
    var tryColorFish = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "tryColorFish", ofType: "mp3")!));
    
    var colorMore = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "colorMore", ofType: "mp3")!));
    
    var quack = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "quack_1", ofType: "wav")!));
    
    var bubbles = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "bubbles_1", ofType: "wav")!));
    
    var usedAudio = [AVAudioPlayer]();
    
    var checkAudio = [AVAudioPlayer]();
    
    var audioPrompts = [AVAudioPlayer]();
    
    var secondPrompts = [AVAudioPlayer]();
    
    var thirdPrompts = [AVAudioPlayer]();
    
    var currentPrompt = AVAudioPlayer();
    

    
    
    

    override func viewDidLoad() {
        
        let image = UIImage(named: "Duck.png") as UIImage?
        let button   = UIButton(type: UIButtonType.custom) as UIButton
     
        button.setImage(image, for: UIControlState())
        button.addTarget(self, action: Selector("btnTouched:"), for:.touchUpInside)
        self.view.addSubview(button)
        
        duck1.adjustsImageWhenDisabled = false;
        duck2.adjustsImageWhenDisabled = false;
        fish1.adjustsImageWhenDisabled = false;
        fish2.adjustsImageWhenDisabled = false;
        
        duck1.isExclusiveTouch = true;
        duck2.isExclusiveTouch = true;
        fish1.isExclusiveTouch = true;
        fish2.isExclusiveTouch = true;
        
        duck1.isEnabled = false;
        duck2.isEnabled = false;
        fish1.isEnabled = false;
        fish2.isEnabled = false;
        
        
        let delay = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: delay) {
            self.duck1.isEnabled = true;
            self.duck2.isEnabled = true;
            self.fish1.isEnabled = true;
            self.fish2.isEnabled = true;
        }
        
        
        audioPrompts.append(tapDuckToColor);
        audioPrompts.append(tapFishToColor);
        
        
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
        if (fish1Colored&&fish2Colored&&duck1Colored&&duck2Colored){
            return true;
        }
        else {
            return false;
        }
    }

    
    
    
    @IBAction func duck1Tapped(_ sender: Any) {
       
        
        if (fish1Colored&&fish2Colored&&duck2Colored) {
            duck1.isEnabled = false;
            self.duck1.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height);
            let image = UIImage(named: "Ducks.png") as UIImage!;
            quack.play();
            
            self.duck1.setImage(image, for: UIControlState())
            let delay = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
            self.colorMore.play();
            }
            let when = DispatchTime.now() + 6 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "snacks")
                self.show(vc as! UIViewController, sender: vc)
            }
            
        }
        
        else if (currentPrompt == tapDuckToColor) {
            
            
            self.duck2.isEnabled = false;
            self.fish1.isEnabled = false;
            self.fish2.isEnabled = false;
            UIView.transition(with: self.duck1, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.duck1.setImage(self.duck, for: UIControlState())}, completion: nil)
            duck1Colored = true;
            quack.play();
            
            if (!duck2Colored) {
            checkAudio.append(colorAnotherDuck);
            }
            if (fish1Colored==false&&fish2Colored==false){
                checkAudio.append(tapFishToColor);
            }
            
            else if ((fish1Colored||fish2Colored)&&(!(fish1Colored&&fish2Colored))) {
                checkAudio.append(colorAnotherfish);
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
            duck1.isEnabled = false;
            
            let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
            self.currentPrompt.play();
                
                
            }
            let delay = DispatchTime.now() + 4.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
            self.duck2.isEnabled = true;
            if !self.fish1Colored {
                self.fish1.isEnabled = true;
            }
            if !self.fish2Colored {
                self.fish2.isEnabled = true;
            }
            }
            
                
            
            self.usedAudio.append(self.currentPrompt);
            self.secondPrompts.remove(at: randomIndex);
            duck1.isEnabled = false;
        }
        
        else if (currentPrompt == colorAnotherDuck) {
            duck1.isEnabled = false;
            
            self.duck2.isEnabled = false;
            self.fish1.isEnabled = false;
            self.fish2.isEnabled = false;
            UIView.transition(with: self.duck1, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.duck1.setImage(self.duck, for: UIControlState())}, completion: nil)
            duck1Colored = true;
            quack.play();
            
            checkAudio.append(tapFishToColor);
            checkAudio.append(colorAnotherfish)
            
            
            
            
            if (fish1Colored||fish2Colored) {
                currentPrompt = colorAnotherfish
            }
            else {
                currentPrompt = tapFishToColor;
            }
            
            
            let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
            self.currentPrompt.play();
                
                
               
            }
            let delay = DispatchTime.now() + 4.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
            if !self.fish1Colored {
                self.fish1.isEnabled = true;
            }
            if !self.fish2Colored {
                self.fish2.isEnabled = true;
            }
            
            }
            self.usedAudio.append(self.currentPrompt);
        }
    }
    
    @IBAction func duck2Tapped(_ sender: Any) {
        
        
        duck2.isEnabled = false;
        
        if (duck1Colored&&fish1Colored&&fish2Colored) {
            self.duck2.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height);
            let image = UIImage(named: "Ducks.png") as UIImage!;
            quack.play();
            self.duck2.setImage(image, for: UIControlState())
            let delay = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.colorMore.play();
            }
            
            let when = DispatchTime.now() + 6 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "snacks")
                self.show(vc as! UIViewController, sender: vc)
            }
        }
        
        else if (currentPrompt == tapDuckToColor) {
            duck2.isEnabled = false;
            self.duck1.isEnabled = false;
            self.fish1.isEnabled = false;
            self.fish2.isEnabled = false;
            UIView.transition(with: self.duck2, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.duck2.setImage(self.duck, for: UIControlState())}, completion: nil)
            duck2Colored = true;
            quack.play();
            
            if (!duck1Colored) {
            checkAudio.append(colorAnotherDuck);
            }
            if (fish1Colored==false&&fish2Colored==false) {
                checkAudio.append(tapFishToColor);
            }
            
            else if ((fish1Colored||fish2Colored)&&(!(fish1Colored&&fish2Colored))) {
                checkAudio.append(colorAnotherfish);
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
            self.duck1.isEnabled = true;
            if !self.fish1Colored {
                self.fish1.isEnabled = true;
            }
            if !self.fish2Colored {
                self.fish2.isEnabled = true;
            }
            
            }
            self.usedAudio.append(self.currentPrompt);
            self.secondPrompts.remove(at: randomIndex);
            
        }
        
        else if (currentPrompt == colorAnotherDuck) {
            duck2.isEnabled = false;
            self.duck1.isEnabled = false;
            self.fish1.isEnabled = false;
            self.fish2.isEnabled = false;
            UIView.transition(with: self.duck2, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.duck2.setImage(self.duck, for: UIControlState())}, completion: nil)
            duck2Colored = true;
            quack.play();
            
            checkAudio.append(tapFishToColor);
            checkAudio.append(colorAnotherfish)
            
            
            if (fish1Colored||fish2Colored) {
                currentPrompt = colorAnotherfish
            }
            else {
                currentPrompt = tapFishToColor;
            }
            
            let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
            self.currentPrompt.play();
                
               
                
               
            
            }
            let delay = DispatchTime.now() + 4.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
            if !self.fish1Colored {
                self.fish1.isEnabled = true;
            }
            if !self.fish2Colored {
                self.fish2.isEnabled = true;
            }
            
            }
            self.usedAudio.append(self.currentPrompt);
            
        }
        
    }
    
    @IBAction func fish1Tapped(_ sender: Any) {
       
        fish1.isEnabled = false;
        
        if (fish2Colored&&duck1Colored&&duck2Colored) {
            self.fish1.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height);
            let image = UIImage(named: "Ducks.png") as UIImage!;
            bubbles.play();
            
            self.fish1.setImage(image, for: UIControlState())
            let delay = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.colorMore.play();
            }
            
            let when = DispatchTime.now() + 6 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "snacks")
                self.show(vc as! UIViewController, sender: vc)
            }
            
        }
            
        else if (currentPrompt == tapFishToColor) {
            fish1.isEnabled = false;
            
            self.duck1.isEnabled = false;
            self.duck2.isEnabled = false;
            self.fish2.isEnabled = false;
            UIView.transition(with: self.fish1, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.fish1.setImage(self.fish, for: UIControlState())}, completion: nil)
            fish1Colored = true;
            bubbles.play();
            
            if (!fish2Colored) {
                checkAudio.append(colorAnotherfish);
            }
            if (duck1Colored==false&&duck2Colored==false){
                checkAudio.append(tapDuckToColor);
            }
            
            else if ((duck1Colored||duck2Colored)&&(!(duck1Colored&&duck2Colored))) {
                checkAudio.append(colorAnotherDuck);
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
            if !self.duck1Colored {
                self.duck1.isEnabled = true;
            }
            if !self.duck2Colored {
                self.duck2.isEnabled = true;
            }
            self.fish2.isEnabled = true;
            self.fish1.isEnabled = false;
            
            }
            
            
            self.usedAudio.append(self.currentPrompt);
            self.secondPrompts.remove(at: randomIndex);
            
        }
            
        else if (currentPrompt == colorAnotherfish) {
            fish1.isEnabled = false;
            
            self.duck1.isEnabled = false;
            self.duck2.isEnabled = false;
            self.fish2.isEnabled = false;
            UIView.transition(with: self.fish1, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.fish1.setImage(self.fish, for: UIControlState())}, completion: nil)
            fish1Colored = true;
            bubbles.play();
            
            checkAudio.append(tapDuckToColor);
            checkAudio.append(colorAnotherDuck)
            
            
            
            
            if (duck1Colored||duck2Colored) {
                currentPrompt = colorAnotherDuck
            }
            else {
                currentPrompt = tapDuckToColor;
            }
            
            let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.currentPrompt.play();
                
          
                
            
            }
            let delay = DispatchTime.now() + 4.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
            
            if !self.duck1Colored {
                self.duck1.isEnabled = true;
            }
            if !self.duck2Colored {
                self.duck2.isEnabled = true;
            }
            
            }
            
            self.usedAudio.append(self.currentPrompt);
            
        }
    }

    @IBAction func fish2Tapped(_ sender: Any) {
        
        fish2.isEnabled = false;
        
        
        if (fish1Colored&&duck1Colored&&duck2Colored) {
            self.fish2.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height);
            let image = UIImage(named: "Ducks.png") as UIImage!;
            bubbles.play();
            
            self.fish2.setImage(image, for: UIControlState())
            let delay = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.colorMore.play();
            }
            
            let when = DispatchTime.now() + 6 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "snacks")
                self.show(vc as! UIViewController, sender: vc)
            }
            
        }
            
        else if (currentPrompt == tapFishToColor) {
            fish2.isEnabled = false;
            self.duck1.isEnabled = false;
            self.duck2.isEnabled = false;
            self.fish1.isEnabled = false;
            UIView.transition(with: self.fish2, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.fish2.setImage(self.fish, for: UIControlState())}, completion: nil)
            fish2Colored = true;
            bubbles.play();
            
            if (!fish1Colored) {
                checkAudio.append(colorAnotherfish);
            }
            if (duck1Colored==false&&duck2Colored==false){
                checkAudio.append(tapDuckToColor);
            }
            
            else if ((duck1Colored||duck2Colored)&&(!(duck1Colored&&duck2Colored))) {
                checkAudio.append(colorAnotherDuck);
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
            if !self.duck1Colored {
                self.duck1.isEnabled = true;
            }
            if !self.duck2Colored {
                self.duck2.isEnabled = true;
            }
            self.fish1.isEnabled = true;
            self.fish2.isEnabled = false;
            }
            
            
            self.usedAudio.append(self.currentPrompt);
            self.secondPrompts.remove(at: randomIndex);
            
        }
            
        else if (currentPrompt == colorAnotherfish) {
            fish2.isEnabled = false;

            self.duck1.isEnabled = false;
            self.duck2.isEnabled = false;
            self.fish1.isEnabled = false;
            UIView.transition(with: self.fish2, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.fish2.setImage(self.fish, for: UIControlState())}, completion: nil)
            fish2Colored = true;
            bubbles.play();
            
            checkAudio.append(tapDuckToColor);
            checkAudio.append(colorAnotherDuck)
            
            
            
            
            if (duck1Colored||duck2Colored) {
                currentPrompt = colorAnotherDuck
            }
            else {
                currentPrompt = tapDuckToColor;
            }
            
            let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.currentPrompt.play();
                
            }
            let delay = DispatchTime.now() + 4.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
            if !self.duck1Colored {
                self.duck1.isEnabled = true;
            }
            if !self.duck2Colored {
                self.duck2.isEnabled = true;
            }
            
            
            }
            
            
            
            
            self.usedAudio.append(self.currentPrompt);
            
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
