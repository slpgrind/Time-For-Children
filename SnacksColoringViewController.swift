//
//  SnacksColoringViewController.swift
//  Alex
//
//  Created by Alex Panganiban on 4/11/17.
//  Copyright © 2017 TFC. All rights reserved.
//

import UIKit
import AVFoundation

class SnacksColoringViewController: UIViewController {

    @IBOutlet weak var apple1: UIButton!
    @IBOutlet weak var sugarCookie: UIButton!
    @IBOutlet weak var chocoCookie: UIButton!
    @IBOutlet weak var apple2: UIButton!
    
    //Check colored
    var apple1Colored = false;
    var sugarCookieColored = false;
    var chocoCookieColored = false;
    var apple2Colored = false;
    
    //Replace uncolored images with colored images
    var allColored = UIImageView(frame: CGRect(x: 0, y: 0, width: 1024, height: 768));
    var backgroundImage = UIImage(named: "Snacks.png");
    
    var coloredApple1 = UIImage(named: "Apple.png");
    var coloredSugarCookie = UIImage(named: "Sugar.png");
    var coloredChocoCookie = UIImage(named: "Chocolate-Chip.png");
    var coloredApple2 = UIImage(named: "Apple2.png");
    
    //Load audio
    var tapAppleToColor = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "colorApple", ofType: "mp3")!));
    
    var tapCookieToColor = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "colorCookie", ofType: "mp3")!));
    
    var crunch = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "crunch_1", ofType: "wav")!));
    
    var colorAnotherApple = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "colorAnotherApple", ofType: "mp3")!));
    
    var colorOtherCookie = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "colorOtherCookie", ofType: "mp3")!));
    
    var yumYum = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Yumyum", ofType: "mp3")!));
    
    var usedAudio = [AVAudioPlayer]();
    
    var checkAudio = [AVAudioPlayer]();
    
    var audioPrompts = [AVAudioPlayer]();
    
    var secondPrompts = [AVAudioPlayer]();
    
    var thirdPrompts = [AVAudioPlayer]();
    
    var currentPrompt = AVAudioPlayer();
    
    
    override func viewDidLoad() {
        
        apple1.adjustsImageWhenDisabled = false;
        sugarCookie.adjustsImageWhenDisabled = false;
        apple2.adjustsImageWhenDisabled = false;
        chocoCookie.adjustsImageWhenDisabled = false;
        
        apple1.isExclusiveTouch = true;
        apple2.isExclusiveTouch = true;
        chocoCookie.isExclusiveTouch = true;
        sugarCookie.isExclusiveTouch = true;
        
        apple1.isEnabled = false;
        sugarCookie.isEnabled = false;
        apple2.isEnabled = false;
        chocoCookie.isEnabled = false;
        
        let delay = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: delay) {
            self.apple1.isEnabled = true;
            self.sugarCookie.isEnabled = true;
            self.apple2.isEnabled = true;
            self.chocoCookie.isEnabled = true;
        }
        
        audioPrompts.append(tapAppleToColor);
        audioPrompts.append(tapCookieToColor);
        
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
        if (apple1Colored&&apple2Colored&&sugarCookieColored&&chocoCookieColored){
            return true;
        }
        else {
            return false;
        }
        
    }
    
    @IBAction func apple1Tapped(_ sender: Any) {
        
        if (sugarCookieColored&&chocoCookieColored&&apple2Colored) {
            apple1.isEnabled = false;
            self.apple1.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height);
            let image = UIImage(named: "Snacks.png") as UIImage!;
            crunch.play();
            
            self.apple1.setImage(image, for: UIControlState())
            let delay = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.yumYum.play();
            }
            
            let when = DispatchTime.now() + 5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "planes")
                self.show(vc as! UIViewController, sender: vc)
            }
        }
            
        else if (currentPrompt == tapAppleToColor) {
            
            sugarCookie.isEnabled = false;
            apple2.isEnabled = false;
            chocoCookie.isEnabled = false;
            UIView.transition(with: self.apple1, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.apple1.setImage(self.coloredApple1, for: UIControlState())}, completion: nil)
            apple1Colored = true;
            crunch.play();
            
            if (!apple2Colored) {
                checkAudio.append(colorAnotherApple);
            }
            if (sugarCookieColored==false&&chocoCookieColored==false){
                checkAudio.append(tapCookieToColor);
            }
            
            else if ((sugarCookieColored||chocoCookieColored)&&(!(sugarCookieColored&&chocoCookieColored))) {
                checkAudio.append(colorOtherCookie);
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
            apple1.isEnabled = false;
            let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
            self.currentPrompt.play();
            }
            let delay = DispatchTime.now() + 4.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
            if !self.sugarCookieColored {
                self.sugarCookie.isEnabled = true;
            }
            if !self.chocoCookieColored {
                self.chocoCookie.isEnabled = true;
            }
                self.apple2.isEnabled = true;
            }
            
            usedAudio.append(currentPrompt);
            secondPrompts.remove(at: randomIndex);
        }
            
        else if (currentPrompt == colorAnotherApple) {
            apple1.isEnabled = false;
            sugarCookie.isEnabled = false;
            apple2.isEnabled = false;
            chocoCookie.isEnabled = false;
            UIView.transition(with: self.apple1, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.apple1.setImage(self.coloredApple1, for: UIControlState())}, completion: nil)
            apple1Colored = true;
            crunch.play();
            
            checkAudio.append(tapCookieToColor);
            checkAudio.append(colorOtherCookie)
            
            
            
            
            if (sugarCookieColored||chocoCookieColored) {
                currentPrompt = colorOtherCookie
            }
            else {
                currentPrompt = tapCookieToColor;
            }
            
            
            let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
            self.currentPrompt.play();
                
            }
            let delay = DispatchTime.now() + 4.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
            if !self.sugarCookieColored {
                self.sugarCookie.isEnabled = true;
            }
            if !self.chocoCookieColored {
                self.chocoCookie.isEnabled = true;
            }
            }
            usedAudio.append(currentPrompt);
        }
    }
    
    @IBAction func sugarCookieTapped(_ sender: Any) {
        
    
        
        if (apple1Colored&&chocoCookieColored&&apple2Colored) {
            sugarCookie.isEnabled = false;
            self.sugarCookie.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height);
            let image = UIImage(named: "Snacks.png") as UIImage!;
            crunch.play();
            
            self.sugarCookie.setImage(image, for: UIControlState())
            let delay = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.yumYum.play();
            }
            
            
            
            
            
            let when = DispatchTime.now() + 5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "planes")
                self.show(vc as! UIViewController, sender: vc)
            }
        }
            
        else if (currentPrompt == tapCookieToColor) {
            apple1.isEnabled = false;
            apple2.isEnabled = false;
            chocoCookie.isEnabled = false;
            UIView.transition(with: self.sugarCookie, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.sugarCookie.setImage(self.coloredSugarCookie, for: UIControlState())}, completion: nil)
            sugarCookieColored = true;
            crunch.play();
            
            if (!chocoCookieColored) {
                checkAudio.append(colorOtherCookie);
            }
            if (apple1Colored==false&&apple2Colored==false){
                checkAudio.append(tapAppleToColor);
            }
            
            else if ((apple1Colored||apple2Colored)&&(!(apple1Colored&&apple2Colored))) {
                checkAudio.append(colorAnotherApple);
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
            sugarCookie.isEnabled = false;
            
            let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
            self.currentPrompt.play();
            }
            let delay = DispatchTime.now() + 4.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
            if !self.apple1Colored {
                self.apple1.isEnabled = true;
            }
            if !self.apple2Colored {
                self.apple2.isEnabled = true;
            }
                self.chocoCookie.isEnabled = true;
            }
            
            
            usedAudio.append(currentPrompt);
            secondPrompts.remove(at: randomIndex);
        }
            
        else if (currentPrompt == colorOtherCookie) {
            sugarCookie.isEnabled = false;
            apple1.isEnabled = false;
            apple2.isEnabled = false;
            chocoCookie.isEnabled = false;
            UIView.transition(with: self.sugarCookie, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.sugarCookie.setImage(self.coloredSugarCookie, for: UIControlState())}, completion: nil)
            sugarCookieColored = true;
            crunch.play();
            
            checkAudio.append(tapAppleToColor);
            checkAudio.append(colorAnotherApple)
            
            
            
            
            if (apple1Colored||apple2Colored) {
                currentPrompt = colorAnotherApple
            }
            else {
                currentPrompt = tapAppleToColor;
            }
            
            
            let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
            self.currentPrompt.play();

               
                
            }
            let delay = DispatchTime.now() + 4.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
            if !self.apple1Colored {
                self.apple1.isEnabled = true;
            }
            if !self.apple2Colored {
                self.apple2.isEnabled = true;
            }
            }
            usedAudio.append(currentPrompt);
        }
        
    }
    
    @IBAction func chocoCookieTapped(_ sender: Any) {
        
        
        if (apple1Colored&&sugarCookieColored&&apple2Colored) {
            chocoCookie.isEnabled = false;
            self.chocoCookie.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height);
            let image = UIImage(named: "Snacks.png") as UIImage!;
            crunch.play();
            
            self.chocoCookie.setImage(image, for: UIControlState())
            let delay = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.yumYum.play();
            }
            
            let when = DispatchTime.now() + 5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "planes")
                self.show(vc as! UIViewController, sender: vc)
            }
        }
            
            
            
        else if (currentPrompt == tapCookieToColor) {
            
            apple1.isEnabled = false;
            apple2.isEnabled = false;
            sugarCookie.isEnabled = false;
            UIView.transition(with: self.chocoCookie, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.chocoCookie.setImage(self.coloredChocoCookie, for: UIControlState())}, completion: nil)
            chocoCookieColored = true;
            crunch.play();
            
            if (!sugarCookieColored) {
                checkAudio.append(colorOtherCookie);
            }
            if (apple1Colored==false&&apple2Colored==false){
                checkAudio.append(tapAppleToColor);
            }
            
            else if ((apple1Colored||apple2Colored)&&(!(apple1Colored&&apple2Colored))) {
                checkAudio.append(colorAnotherApple);
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
            chocoCookie.isEnabled = false;
            let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
            self.currentPrompt.play();
                
            }
            let delay = DispatchTime.now() + 4.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
            if !self.apple1Colored {
                self.apple1.isEnabled = true;
            }
            if !self.apple2Colored {
                self.apple2.isEnabled = true;
            }
                self.sugarCookie.isEnabled = true;
            }
            
            
            usedAudio.append(currentPrompt);
            secondPrompts.remove(at: randomIndex);
        }
            
        else if (currentPrompt == colorOtherCookie) {
            chocoCookie.isEnabled = false;
            apple1.isEnabled = false;
            apple2.isEnabled = false;
            sugarCookie.isEnabled = false;
            UIView.transition(with: self.chocoCookie, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.chocoCookie.setImage(self.coloredChocoCookie, for: UIControlState())}, completion: nil)
            chocoCookieColored = true;
            crunch.play();
            
            checkAudio.append(tapAppleToColor);
            checkAudio.append(colorAnotherApple)
            
            
            
            
            if (apple1Colored||apple2Colored) {
                currentPrompt = colorAnotherApple
            }
            else {
                currentPrompt = tapAppleToColor;
            }
            
            let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
            self.currentPrompt.play();
                
                
            }
            let delay = DispatchTime.now() + 4.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
            if !self.apple1Colored {
                self.apple1.isEnabled = true;
            }
            if !self.apple2Colored {
                self.apple2.isEnabled = true;
            }
            }
            usedAudio.append(currentPrompt);
        }
        
    }

    @IBAction func apple2Tapped(_ sender: Any) {

        
        if (sugarCookieColored&&chocoCookieColored&&apple1Colored) {
            apple2.isEnabled = false;
            self.apple2.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height);
            let image = UIImage(named: "Snacks.png") as UIImage!;
            crunch.play();
            
            self.apple2.setImage(image, for: UIControlState())
            let delay = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.yumYum.play();
            }
            
            let when = DispatchTime.now() + 5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "planes")
                self.show(vc as! UIViewController, sender: vc)
            }
        }
            
        else if (currentPrompt == tapAppleToColor) {
            
            apple1.isEnabled = false;
            chocoCookie.isEnabled = false;
            sugarCookie.isEnabled = false;
            UIView.transition(with: self.apple2, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.apple2.setImage(self.coloredApple2, for: UIControlState())}, completion: nil)
            apple2Colored = true;
            crunch.play();
            
            if (!apple1Colored) {
                checkAudio.append(colorAnotherApple);
            }
            if (sugarCookieColored==false&&chocoCookieColored==false){
                checkAudio.append(tapCookieToColor);
            }
            
            else if ((sugarCookieColored||chocoCookieColored)&&(!(sugarCookieColored&&chocoCookieColored))) {
                checkAudio.append(colorOtherCookie);
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
            apple2.isEnabled = false;
            let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
            self.currentPrompt.play();
                
                
            }
            let delay = DispatchTime.now() + 4.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
            self.apple1.isEnabled = true;
            if !self.sugarCookieColored {
                self.sugarCookie.isEnabled = true;
            }
            if !self.chocoCookieColored {
                self.chocoCookie.isEnabled = true;
            }
            }
            usedAudio.append(currentPrompt);
            secondPrompts.remove(at: randomIndex);
        }
            
        else if (currentPrompt == colorAnotherApple) {
            apple2.isEnabled = false;
            apple1.isEnabled = false;
            chocoCookie.isEnabled = false;
            sugarCookie.isEnabled = false;
            UIView.transition(with: self.apple2, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.apple2.setImage(self.coloredApple2, for: UIControlState())}, completion: nil)
            apple2Colored = true;
            crunch.play();
            
            checkAudio.append(tapCookieToColor);
            checkAudio.append(colorOtherCookie)
            
            
            
            
            if (sugarCookieColored||chocoCookieColored) {
                currentPrompt = colorOtherCookie
            }
            else {
                currentPrompt = tapCookieToColor;
            }
            
            let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
            self.currentPrompt.play();
                
                
            }
            let delay = DispatchTime.now() + 4.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
            if !self.sugarCookieColored {
                self.sugarCookie.isEnabled = true;
            }
            if !self.chocoCookieColored {
                self.chocoCookie.isEnabled = true;
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
