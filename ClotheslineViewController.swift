//
//  ClotheslineViewController.swift
//  Alex
//
//  Created by Alex Panganiban on 5/11/17.
//  Copyright © 2017 TFC. All rights reserved.
//

import UIKit
import AVFoundation

class ClotheslineViewController: UIViewController {
    @IBOutlet weak var shirt: UIButton!
    @IBOutlet weak var pants: UIButton!
    @IBOutlet weak var sock1: UIButton!
    @IBOutlet weak var sock2: UIButton!
    
    //Check colored
    var shirtColored = false;
    var pantsColored = false;
    
    var sock1Colored = false;
    var sock2Colored = false;
    
    
    //Replace uncolored images with colored images
    var allColored = UIImageView(frame: CGRect(x: 0, y: 0, width: 1024, height: 768));
    var backgroundImage = UIImage(named: "Clothes.png");
    
    var coloredShirt = UIImage(named: "Shirt.png");
    var coloredPants = UIImage(named: "Pants.png");
    var coloredSock1 = UIImage(named: "Sock1.png");
    var coloredSock2 = UIImage(named: "Sock2.png");
    
    
    //Load Audio
    var tapShirtToColor = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "colorShirt", ofType: "mp3")!));
    
    var tapPantsToColor = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "colorPants", ofType: "mp3")!));
    
    var tapSockToColor = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "colorSock", ofType: "mp3")!));
    
    var colorOtherSock = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "colorOtherSock", ofType: "mp3")!));
    
    var excellent = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Excellent!", ofType: "mp3")!));
    
    var wind = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "wind_1", ofType: "wav")!));
    
    
    
    var usedAudio = [AVAudioPlayer]();
    
    var checkAudio = [AVAudioPlayer]();
    
    var audioPrompts = [AVAudioPlayer]();
    
    var secondPrompts = [AVAudioPlayer]();
    
    var thirdPrompts = [AVAudioPlayer]();
    
    var currentPrompt = AVAudioPlayer();

    override func viewDidLoad() {
        shirt.adjustsImageWhenDisabled = false;
        sock1.adjustsImageWhenDisabled = false;
        sock2.adjustsImageWhenDisabled = false;
        pants.adjustsImageWhenDisabled = false;
        
        shirt.isExclusiveTouch = true;
        sock1.isExclusiveTouch = true;
        sock2.isExclusiveTouch = true;
        pants.isExclusiveTouch = true;
        
        shirt.isEnabled = false;
        sock1.isEnabled = false;
        sock2.isEnabled = false;
        pants.isEnabled = false;
        
        let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.shirt.isEnabled = true;
            self.sock1.isEnabled = true;
            self.sock2.isEnabled = true;
            self.pants.isEnabled = true;
        }
        
        audioPrompts.append(tapSockToColor);
        audioPrompts.append(tapShirtToColor);
        audioPrompts.append(tapPantsToColor);
        
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
        if (sock1Colored&&sock2Colored&&shirtColored&&pantsColored){
            return true;
        }
        else {
            return false;
        }
        
    }
    
    @IBAction func shirtTapped(_ sender: Any) {
        if (sock1Colored&&sock2Colored&&pantsColored) {
            self.shirt.isEnabled = false;
            self.shirt.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height);
            let image = UIImage(named: "Clothes.png") as UIImage!;
            wind.play();
            
            
            
            self.shirt.setImage(image, for: UIControlState())
            let delay = DispatchTime.now() + 2 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.excellent.play();
            }
            
            
            let when = DispatchTime.now() + 4 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "eggbowl")
                self.show(vc as! UIViewController, sender: vc)
            }
            
        }
        
        else if (currentPrompt == tapShirtToColor) {
            self.shirt.isEnabled = false;
            self.sock1.isEnabled = false;
            self.sock2.isEnabled = false;
            self.pants.isEnabled = false;
            UIView.transition(with: self.shirt, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.shirt.setImage(self.coloredShirt, for: UIControlState())}, completion: nil)
            shirtColored = true;
            wind.play();
            
            if (!pantsColored) {
                checkAudio.append(tapPantsToColor)
            }
            
            if (!sock1Colored && !sock2Colored) {
                checkAudio.append(tapSockToColor)
            }
            
            if ((sock1Colored||sock2Colored)&&(!(sock1Colored&&sock2Colored))) {
                checkAudio.append(colorOtherSock);
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
            checkAudio = []
            let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.currentPrompt.play();
                
                
            }
            let delay = DispatchTime.now() + 4.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                if !self.sock1Colored {
                    self.sock1.isEnabled = true;
                }
                if !self.sock2Colored {
                    self.sock2.isEnabled = true;
                }
                self.pants.isEnabled = true;
            }
            usedAudio.append(currentPrompt);
            secondPrompts.remove(at: randomIndex);
    
            checkAudio = []
            
        }
        
        
    }
    
    
    @IBAction func pantsTapped(_ sender: Any) {
        if (shirtColored&&sock1Colored&&sock2Colored) {
            self.pants.isEnabled = false;
            self.pants.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height);
            let image = UIImage(named: "Clothes.png") as UIImage!;
            wind.play();
            
            self.pants.setImage(image, for: UIControlState())
            let delay = DispatchTime.now() + 2 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.excellent.play();
            }
            
            let when = DispatchTime.now() + 4 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "eggbowl")
                self.show(vc as! UIViewController, sender: vc)
            }
            
        }
            
        else if (currentPrompt == tapPantsToColor) {
            self.pants.isEnabled = false;
            self.shirt.isEnabled = false;
            self.sock2.isEnabled = false;
            self.sock1.isEnabled = false;
            UIView.transition(with: self.pants, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.pants.setImage(self.coloredPants, for: UIControlState())}, completion: nil)
            pantsColored = true;
            wind.play();
            
            if (!shirtColored) {
                checkAudio.append(tapShirtToColor);
            }
            if (sock1Colored==false&&sock2Colored==false){
                checkAudio.append(tapSockToColor);
            }
            
            if ((sock1Colored||sock2Colored)&&(!(sock1Colored&&sock2Colored))) {
                checkAudio.append(colorOtherSock);
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
            secondPrompts.remove(at: randomIndex);
            checkAudio = []
            let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.currentPrompt.play();
                
                if !self.shirtColored {
                    self.shirt.isEnabled = true;
                }
                if !self.sock1Colored {
                    self.sock1.isEnabled = true;
                }
                if !self.sock2Colored {
                    self.sock2.isEnabled = true;
                }
            }
            
            usedAudio.append(currentPrompt);
            checkAudio = []
        }
    }
    
    
    @IBAction func sock1Tapped(_ sender: Any) {
        if (shirtColored&&pantsColored&&sock2Colored) {
            self.sock1.isEnabled = false;
            self.sock1.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height);
            let image = UIImage(named: "Clothes.png") as UIImage!;
            wind.play();
            
            self.sock1.setImage(image, for: UIControlState())
            let delay = DispatchTime.now() + 2 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.excellent.play();
            }
            
            let when = DispatchTime.now() + 4 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "eggbowl")
                self.show(vc as! UIViewController, sender: vc)
            }
        }
        
        else if (currentPrompt == tapSockToColor) {
            self.sock1.isEnabled = false;
            self.shirt.isEnabled = false;
            self.sock2.isEnabled = false;
            self.pants.isEnabled = false;
            UIView.transition(with: self.sock1, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.sock1.setImage(self.coloredSock1, for: UIControlState())}, completion: nil)
            sock1Colored = true;
            wind.play();
            
            if (!sock2Colored) {
                checkAudio.append(colorOtherSock);
            }
            
            if (!shirtColored) {
                checkAudio.append(tapShirtToColor)
            }
            
            if (!pantsColored) {
                checkAudio.append(tapPantsToColor)
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
            checkAudio = []
            let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.currentPrompt.play();
                
                if !self.shirtColored {
                    self.shirt.isEnabled = true;
                }
                if !self.pantsColored {
                    self.pants.isEnabled = true;
                }
                self.sock2.isEnabled = true;
                
            }
            
            usedAudio.append(currentPrompt);
            secondPrompts.remove(at: randomIndex);
            
            
        }
        
        else if (currentPrompt == colorOtherSock) {
            
            self.sock1.isEnabled = false;
            self.shirt.isEnabled = false;
            self.sock2.isEnabled = false;
            self.pants.isEnabled = false;
            
            let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                //self.currentPrompt.play();
                
                if !self.shirtColored {
                    self.shirt.isEnabled = true;
                }
                if !self.pantsColored {
                    self.pants.isEnabled = true;
                }
                
            }
            UIView.transition(with: self.sock1, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.sock1.setImage(self.coloredSock1, for: UIControlState())}, completion: nil)
            sock1Colored = true;
            wind.play();
            
            checkAudio.append(tapShirtToColor);
            checkAudio.append(tapPantsToColor)
            
            for file in checkAudio {
                for oldFile in usedAudio {
                    if (file != oldFile) {
                        thirdPrompts.append(file)
                    }
                }
            }
            let randomIndex = Int(arc4random_uniform(UInt32(secondPrompts.count)))
            
            currentPrompt = thirdPrompts[randomIndex];
            checkAudio = []
            self.sock2.isEnabled = false;
            self.shirt.isEnabled = false;
            self.pants.isEnabled = false;
            self.sock1.isEnabled = false;
            let delay = DispatchTime.now() + 4.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.currentPrompt.play();
            }
            
            
            let w = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: w) {
                //self.currentPrompt.play();
                
                if !self.shirtColored {
                    self.shirt.isEnabled = true;
                }
                if !self.pantsColored {
                    self.pants.isEnabled = true;
                }
                
            }
            
            usedAudio.append(currentPrompt);
            thirdPrompts.remove(at: randomIndex);
            checkAudio = []
            
        }
    }
    
    @IBAction func sock2Tapped(_ sender: Any) {
        if (shirtColored&&pantsColored&&sock1Colored) {
            self.sock2.isEnabled = false;
            self.sock2.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height);
            let image = UIImage(named: "Clothes.png") as UIImage!;
            wind.play();
            
            self.sock2.setImage(image, for: UIControlState())
            let delay = DispatchTime.now() + 2 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.excellent.play();
            }
            
            let when = DispatchTime.now() + 4 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "eggbowl")
                self.show(vc as! UIViewController, sender: vc)
            }
            
        }
            
        else if (currentPrompt == tapSockToColor) {
            self.sock2.isEnabled = false;
            self.shirt.isEnabled = false;
            self.pants.isEnabled = false;
            self.sock1.isEnabled = false;
            
            
            
            UIView.transition(with: self.sock2, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.sock2.setImage(self.coloredSock2, for: UIControlState())}, completion: nil)
            sock2Colored = true;
            wind.play();
            
            if (!sock1Colored) {
                checkAudio.append(colorOtherSock);
            }
            if (shirtColored==false){
                checkAudio.append(tapShirtToColor);
            }
            
            if (pantsColored == false){
                checkAudio.append(tapPantsToColor);
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
            
            usedAudio.append(currentPrompt);
   
            let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.currentPrompt.play();
                
                if !self.shirtColored {
                    self.shirt.isEnabled = true;
                }
                
                if !self.pantsColored {
                    self.pants.isEnabled = true;
                }
                if !self.sock1Colored {
                    self.sock1.isEnabled = true;
                }
            }
            
            usedAudio.append(currentPrompt);
            secondPrompts.remove(at: randomIndex);
            checkAudio = []
        }
            
        else if (currentPrompt == colorOtherSock) {
            self.sock2.isEnabled = false;
            self.shirt.isEnabled = false;
            self.pants.isEnabled = false;
            self.sock1.isEnabled = false;
            
            let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                //self.currentPrompt.play();
                
                if !self.shirtColored {
                    self.shirt.isEnabled = true;
                }
                if !self.pantsColored {
                    self.pants.isEnabled = true;
                }
                
            }
            
            UIView.transition(with: self.sock2, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.sock2.setImage(self.coloredSock2, for: UIControlState())}, completion: nil)
            sock2Colored = true;
            wind.play();
            
            
            checkAudio.append(tapShirtToColor);
            checkAudio.append(tapPantsToColor)
            

            
            for file in checkAudio {
                for oldFile in usedAudio {
                    if (file != oldFile) {
                        thirdPrompts.append(file)
                    }
                }
            }
            let randomIndex = Int(arc4random_uniform(UInt32(secondPrompts.count)))
            
            currentPrompt = thirdPrompts[randomIndex];
            checkAudio = []
            
            self.sock2.isEnabled = false;
            self.shirt.isEnabled = false;
            self.pants.isEnabled = false;
            self.sock1.isEnabled = false;
            
            let delay = DispatchTime.now() + 4.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.currentPrompt.play();
            }
            
            let w = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: w) {
                //self.currentPrompt.play();
                
                if !self.shirtColored {
                    self.shirt.isEnabled = true;
                }
                if !self.pantsColored {
                    self.pants.isEnabled = true;
                }
                
            }
            
            
            
            usedAudio.append(currentPrompt);
            thirdPrompts.remove(at: randomIndex);
            checkAudio = []
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
