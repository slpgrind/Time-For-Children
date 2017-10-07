//
//  GiftsViewController.swift
//  Alex
//
//  Created by Alex Panganiban on 4/16/17.
//  Copyright © 2017 TFC. All rights reserved.
//

import UIKit
import AVFoundation

class GiftsViewController: UIViewController {

    @IBOutlet weak var balloon1: UIButton!
    @IBOutlet weak var balloon2: UIButton!
    @IBOutlet weak var gift1: UIButton!
    @IBOutlet weak var gift2: UIButton!
    
    //Check colored
    var balloon1Colored = false;
    var balloon2Colored = false;
    
    var gift1Colored = false;
    var gift2Colored = false;
    
    //Replace uncolored images with colored images
    var allColored = UIImageView(frame: CGRect(x: 0, y: 0, width: 1024, height: 768));
    var backgroundImage = UIImage(named: "Presents.png");
    
    var coloredGift1 = UIImage(named: "Present1.png");
    var coloredGift2 = UIImage(named: "Present2.png");
    var coloredBalloon1 = UIImage(named: "Balloon1.png");
    var coloredBalloon2 = UIImage(named: "Balloon2.png");
    
    //Load audio
    var tapPresentToColor = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "colorPresent", ofType: "mp3")!));
    
    var tapBalloonToColor = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "colorBallon", ofType: "mp3")!));
    
    var colorOtherPresent = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "colorOtherPresent", ofType: "mp3")!));
    
    var colorAnotherBalloon = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "colorAnotherBalloon", ofType: "mp3")!));
    
    var howPretty = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "howPretty", ofType: "mp3")!));
    
    var inflate = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "inflate_2", ofType: "wav")!));
    
    var crumple = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "crumple_1", ofType: "wav")!));
    
    var usedAudio = [AVAudioPlayer]();
    
    var checkAudio = [AVAudioPlayer]();
    
    var audioPrompts = [AVAudioPlayer]();
    
    var secondPrompts = [AVAudioPlayer]();
    
    var thirdPrompts = [AVAudioPlayer]();
    
    var currentPrompt = AVAudioPlayer();
    
    
    
    override func viewDidLoad() {
        
        balloon1.adjustsImageWhenDisabled = false;
        balloon2.adjustsImageWhenDisabled = false;
        gift1.adjustsImageWhenDisabled = false;
        gift2.adjustsImageWhenDisabled = false;
        
        balloon1.isExclusiveTouch = true;
        balloon2.isExclusiveTouch = true;
        gift1.isExclusiveTouch = true;
        gift2.isExclusiveTouch = true;
        
        balloon1.isEnabled = false;
        balloon2.isEnabled = false;
        gift1.isEnabled = false;
        gift2.isEnabled = false;
        
        let delay = DispatchTime.now() + 2 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: delay) {
            
            self.balloon1.isEnabled = true;
            self.balloon2.isEnabled = true;
            self.gift1.isEnabled = true;
            self.gift2.isEnabled = true;
        }
        
        audioPrompts.append(tapBalloonToColor);
        audioPrompts.append(tapPresentToColor);
        
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
        if (balloon1Colored&&balloon2Colored&&gift1Colored&&gift2Colored){
            return true;
        }
        else {
            return false;
        }
        
    }
    
    @IBAction func balloon1Tapped(_ sender: Any) {
        
        
        if (gift1Colored&&gift2Colored&&balloon2Colored) {
            self.balloon1.isEnabled = false;
            self.balloon1.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height);
            let image = UIImage(named: "Presents.png") as UIImage!;
            inflate.play();
            
            self.balloon1.setImage(image, for: UIControlState())
            let delay = DispatchTime.now() + 2 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                
                self.howPretty.play();
            }
            
            let when = DispatchTime.now() + 6 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "Toys")
                self.show(vc as! UIViewController, sender: vc)
            }
            
        }
            
        else if (currentPrompt == tapBalloonToColor) {
            self.balloon1.isEnabled = false;
            balloon2.isEnabled = false;
            gift1.isEnabled = false;
            gift2.isEnabled = false;
            UIView.transition(with: self.balloon1, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.balloon1.setImage(self.coloredBalloon1, for: UIControlState())}, completion: nil)
            balloon1Colored = true;
            inflate.play();
            
            if (!balloon2Colored) {
                checkAudio.append(colorAnotherBalloon);
            }
            if (gift1Colored==false&&gift2Colored==false){
                checkAudio.append(tapPresentToColor);
            }
            
            else if ((gift1Colored||gift2Colored)&&(!(gift1Colored&&gift2Colored))) {
                checkAudio.append(colorOtherPresent);
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
            self.balloon2.isEnabled = true;
            if !self.gift1Colored {
                self.gift1.isEnabled = true;
            }
            if !self.gift2Colored {
                self.gift2.isEnabled = true;
            }
            }
            
            usedAudio.append(currentPrompt);
            secondPrompts.remove(at: randomIndex);
            self.balloon1.isEnabled = false;
        }
            
        else if (currentPrompt == colorAnotherBalloon) {
            self.balloon1.isEnabled = false;
            balloon2.isEnabled = false;
            gift1.isEnabled = false;
            gift2.isEnabled = false;
            UIView.transition(with: self.balloon1, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.balloon1.setImage(self.coloredBalloon1, for: UIControlState())}, completion: nil)
            balloon1Colored = true;
            inflate.play();
            
            checkAudio.append(tapPresentToColor);
            checkAudio.append(colorOtherPresent)
            
            
            
            if (gift1Colored||gift2Colored) {
                currentPrompt = colorOtherPresent
            }
            else {
                currentPrompt = tapPresentToColor;
            }
            
            let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
            self.currentPrompt.play();
                
            }
            
            let delay = DispatchTime.now() + 4.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
            if !self.gift1Colored {
                self.gift1.isEnabled = true;
            }
            if !self.gift2Colored {
                self.gift2.isEnabled = true;
            }
            }
            
            
            
            usedAudio.append(currentPrompt);
        }
        
    }
    
    @IBAction func balloon2Tapped(_ sender: Any) {
        
        
        if (gift1Colored&&gift2Colored&&balloon1Colored) {
            self.balloon2.isEnabled = false;
            self.balloon2.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height);
            let image = UIImage(named: "Presents.png") as UIImage!;
            inflate.play();
            
            self.balloon2.setImage(image, for: UIControlState())
            let delay = DispatchTime.now() + 2 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                
                self.howPretty.play();
            }
            
            let when = DispatchTime.now() + 6 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "Toys")
                self.show(vc as! UIViewController, sender: vc)
            }
            
        }
            
        else if (currentPrompt == tapBalloonToColor) {
            self.balloon2.isEnabled = false;
            balloon1.isEnabled = false;
            gift1.isEnabled = false;
            gift2.isEnabled = false;
            UIView.transition(with: self.balloon2, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.balloon2.setImage(self.coloredBalloon2, for: UIControlState())}, completion: nil)
            balloon2Colored = true;
            inflate.play();
            
            if (!balloon1Colored) {
                checkAudio.append(colorAnotherBalloon);
            }
            if (gift1Colored==false&&gift2Colored==false){
                checkAudio.append(tapPresentToColor);
            }
            
            else if ((gift1Colored||gift2Colored)&&(!(gift1Colored&&gift2Colored))) {
                checkAudio.append(colorOtherPresent);
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
            self.balloon1.isEnabled = true;
            if !self.gift1Colored {
                self.gift1.isEnabled = true;
            }
            if !self.gift2Colored {
                self.gift2.isEnabled = true;
            }
            }
            
            usedAudio.append(currentPrompt);
            secondPrompts.remove(at: randomIndex);
            self.balloon2.isEnabled = false;
        }
            
        else if (currentPrompt == colorAnotherBalloon) {
            self.balloon2.isEnabled = false;
            balloon2.isEnabled = false;
            gift1.isEnabled = false;
            gift2.isEnabled = false;
            UIView.transition(with: self.balloon2, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.balloon2.setImage(self.coloredBalloon2, for: UIControlState())}, completion: nil)
            balloon2Colored = true;
            inflate.play();
            
            checkAudio.append(tapPresentToColor);
            checkAudio.append(colorOtherPresent)
            
            
            
            
            if (gift1Colored||gift2Colored) {
                currentPrompt = colorOtherPresent
            }
            else {
                currentPrompt = tapPresentToColor;
            }
            
            let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
            self.currentPrompt.play();
                
            }
            let delay = DispatchTime.now() + 4.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
            if !self.gift1Colored {
                self.gift1.isEnabled = true;
            }
            if !self.gift2Colored {
                self.gift2.isEnabled = true;
            }
            }
            usedAudio.append(currentPrompt);
        }
        
    }
    
    @IBAction func gift1Tapped(_ sender: Any) {
        
        
        if (balloon2Colored&&gift2Colored&&balloon1Colored) {
            self.gift1.isEnabled = false;
            self.gift1.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height);
            let image = UIImage(named: "Presents.png") as UIImage!;
            crumple.play();
            
            self.gift1.setImage(image, for: UIControlState())
            let delay = DispatchTime.now() + 2 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                
                self.howPretty.play();
            }
            
            let when = DispatchTime.now() + 6 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "Toys")
                self.show(vc as! UIViewController, sender: vc)
            }
            
        }
            
        else if (currentPrompt == tapPresentToColor) {
            self.gift1.isEnabled = false;
            balloon1.isEnabled = false;
            balloon2.isEnabled = false;
            gift2.isEnabled = false;
            UIView.transition(with: self.gift1, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.gift1.setImage(self.coloredGift1, for: UIControlState())}, completion: nil)
            gift1Colored = true;
            crumple.play();
            
            if (!gift2Colored) {
                checkAudio.append(colorOtherPresent);
            }
            if (balloon1Colored==false&&balloon2Colored==false){
                checkAudio.append(tapBalloonToColor);
            }
            
            else if ((balloon1Colored||balloon2Colored)&&(!(balloon2Colored&&balloon1Colored))) {
                checkAudio.append(colorAnotherBalloon);
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
            if !self.balloon1Colored {
                self.balloon1.isEnabled = true;
            }
            if !self.balloon2Colored {
                self.balloon2.isEnabled = true;
            }
            self.gift2.isEnabled = true;
            }
            usedAudio.append(currentPrompt);
            secondPrompts.remove(at: randomIndex);
        }
        
        
        else if (currentPrompt == colorOtherPresent) {
            self.gift1.isEnabled = false;
            balloon1.isEnabled = false;
            balloon2.isEnabled = false;
            gift2.isEnabled = false;
            UIView.transition(with: self.gift1, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.gift1.setImage(self.coloredGift1, for: UIControlState())}, completion: nil)
            gift1Colored = true;
            crumple.play();
            
            checkAudio.append(tapBalloonToColor);
            checkAudio.append(colorAnotherBalloon)
            
            
            
            
            if (balloon1Colored||balloon2Colored) {
                currentPrompt = colorAnotherBalloon
            }
            else {
                currentPrompt = tapBalloonToColor;
            }
            let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
            self.currentPrompt.play();
                
            }
            let delay = DispatchTime.now() + 4.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
            if !self.balloon1Colored {
                self.balloon1.isEnabled = true;
            }
            if !self.balloon2Colored {
                self.balloon2.isEnabled = true;
            }
            }
            
            usedAudio.append(currentPrompt);
        }
        
    }

    @IBAction func gift2Tapped(_ sender: Any) {
        
        
        
        if (balloon2Colored&&gift1Colored&&balloon1Colored) {
            self.gift2.isEnabled = false;
            self.gift2.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height);
            let image = UIImage(named: "Presents.png") as UIImage!;
            crumple.play();
            
            self.gift2.setImage(image, for: UIControlState())
            let delay = DispatchTime.now() + 2 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                
                self.howPretty.play();
            }
            
            let when = DispatchTime.now() + 6 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "Toys")
                self.show(vc as! UIViewController, sender: vc)
            }
            
        }
            
        else if (currentPrompt == tapPresentToColor) {
            self.gift2.isEnabled = false;
            balloon1.isEnabled = false;
            balloon2.isEnabled = false;
            gift1.isEnabled = false;
            UIView.transition(with: self.gift2, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.gift2.setImage(self.coloredGift2, for: UIControlState())}, completion: nil)
            gift2Colored = true;
            crumple.play();
            
            if (!gift1Colored) {
                checkAudio.append(colorOtherPresent);
            }
            if (balloon1Colored==false&&balloon2Colored==false){
                checkAudio.append(tapBalloonToColor);
            }
            
            else if ((balloon1Colored||balloon2Colored)&&(!(balloon2Colored&&balloon1Colored))) {
                checkAudio.append(colorAnotherBalloon);
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
            if !self.balloon1Colored {
                self.balloon1.isEnabled = true;
            }
            if !self.balloon2Colored {
                self.balloon2.isEnabled = true;
            }
            self.gift1.isEnabled = true;
                
            }
        
            usedAudio.append(currentPrompt);
            secondPrompts.remove(at: randomIndex);
        }
            
        else if (currentPrompt == colorOtherPresent) {
            self.gift2.isEnabled = false;
            balloon1.isEnabled = false;
            balloon2.isEnabled = false;
            gift1.isEnabled = false;
            UIView.transition(with: self.gift2, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.gift2.setImage(self.coloredGift2, for: UIControlState())}, completion: nil)
            gift2Colored = true;
            crumple.play();
            
            checkAudio.append(tapBalloonToColor);
            checkAudio.append(colorAnotherBalloon)
            
            
            
            
            if (balloon1Colored||balloon2Colored) {
                currentPrompt = colorAnotherBalloon
            }
            else {
                currentPrompt = tapBalloonToColor;
            }
            let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
            self.currentPrompt.play();
                
            }
            let delay = DispatchTime.now() + 4.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
            if !self.balloon1Colored {
                self.balloon1.isEnabled = true;
            }
            if !self.balloon2Colored {
                self.balloon2.isEnabled = true;
            }
            }
            usedAudio.append(currentPrompt);
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
