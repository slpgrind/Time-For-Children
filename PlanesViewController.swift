//
//  PlaneesViewController.swift
//  Alex
//
//  Created by Alex Panganiban on 4/12/17.
//  Copyright © 2017 TFC. All rights reserved.
//

import UIKit
import AVFoundation

class PlanesViewController: UIViewController {
    @IBOutlet weak var plane1: UIButton!
    @IBOutlet weak var plane2: UIButton!
    @IBOutlet weak var car1: UIButton!
    @IBOutlet weak var car2: UIButton!
    
    //check Colored
    var plane1Colored = false;
    var plane2Colored = false;
    
    var car1Colored = false;
    var car2Colored = false;
    
    //Replace uncolored images with colored images
    var allColored = UIImageView(frame: CGRect(x: 0, y: 0, width: 1024, height: 768));
    var backgroundImage = UIImage(named: "Planes.png");
    
    var coloredPlane1 = UIImage(named: "Plane1.png");
    var coloredPlane2 = UIImage(named: "Plane2.png");
    var coloredCar1 = UIImage(named: "Car1.png");
    var coloredCar2 = UIImage(named: "Car2.png");
    
    //Load audio
    var tapPlaneToColor = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "colorPlane", ofType: "mp3")!));
    
    var tapCarToColor = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "colorCar", ofType: "mp3")!));
    
    var vroom = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "car beep", ofType: "wav")!));
    
    var colorAnotherPlane = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "colorAnotherPlane", ofType: "mp3")!));
    
    var colorAnotherCar = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "colorAnotherCar", ofType: "mp3")!));
    
    var yay = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Yay", ofType: "mp3")!));
    
    var flyby = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "flyby_2", ofType: "wav")!));
    
    
    
    var usedAudio = [AVAudioPlayer]();
    
    var checkAudio = [AVAudioPlayer]();
    
    var audioPrompts = [AVAudioPlayer]();
    
    var secondPrompts = [AVAudioPlayer]();
    
    var thirdPrompts = [AVAudioPlayer]();
    
    var currentPrompt = AVAudioPlayer();
    
    

    override func viewDidLoad() {
        
        plane1.adjustsImageWhenDisabled = false;
        plane2.adjustsImageWhenDisabled = false;
        car1.adjustsImageWhenDisabled = false;
        car2.adjustsImageWhenDisabled = false;
        
        plane1.isExclusiveTouch = true;
        plane2.isExclusiveTouch = true;
        car1.isExclusiveTouch = true;
        car2.isExclusiveTouch = true;
        
        plane1.isEnabled = false;
        plane2.isEnabled = false;
        car1.isEnabled = false;
        car2.isEnabled = false;
        
        let delay = DispatchTime.now() + 2 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: delay) {
            
            self.plane1.isEnabled = true;
            self.plane2.isEnabled = true;
            self.car1.isEnabled = true;
            self.car2.isEnabled = true;
        }
        
        audioPrompts.append(tapCarToColor);
        audioPrompts.append(tapPlaneToColor);
        
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
        if (plane1Colored&&plane2Colored&&car1Colored&&car2Colored){
            return true;
        }
        else {
            return false;
        }
        
    }

    @IBAction func plane1Tapped(_ sender: Any) {
        
        
        if (car1Colored&&car2Colored&&plane2Colored) {
            self.plane1.isEnabled = false;
            self.plane1.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height);
            let image = UIImage(named: "Planes.png") as UIImage!;
            flyby.play();
            self.plane1.setImage(image, for: UIControlState())
            let delay = DispatchTime.now() + 2 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
            
            self.yay.play();
            }
            
            let when = DispatchTime.now() + 6 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "Gifts")
                self.show(vc as! UIViewController, sender: vc)
            }
            
        }
            
        else if (currentPrompt == tapPlaneToColor) {
            plane2.isEnabled = false;
            car1.isEnabled = false;
            car2.isEnabled = false;
            UIView.transition(with: self.plane1, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.plane1.setImage(self.coloredPlane1, for: UIControlState())}, completion: nil)
            plane1Colored = true;
            flyby.play();
            
            if (!plane2Colored) {
                checkAudio.append(colorAnotherPlane);
            }
            if (car1Colored==false&&car2Colored==false){
                checkAudio.append(tapCarToColor);
            }
            
            else if ((car1Colored||car2Colored)&&(!(car1Colored&&car2Colored))) {
                checkAudio.append(colorAnotherCar);
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
            self.plane1.isEnabled = false;
            let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
            self.currentPrompt.play();
                
            }
            let delay = DispatchTime.now() + 4.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
            self.plane2.isEnabled = true;
            if !self.car1Colored {
                self.car1.isEnabled = true;
            }
            if !self.car2Colored {
                self.car2.isEnabled = true;
            }
            }
            
            usedAudio.append(currentPrompt);
            secondPrompts.remove(at: randomIndex);
        }
            
        else if (currentPrompt == colorAnotherPlane) {
            self.plane1.isEnabled = false;
            plane2.isEnabled = false;
            car1.isEnabled = false;
            car2.isEnabled = false;
            UIView.transition(with: self.plane1, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.plane1.setImage(self.coloredPlane1, for: UIControlState())}, completion: nil)
            plane1Colored = true;
            flyby.play();
            
            checkAudio.append(tapCarToColor);
            checkAudio.append(colorAnotherCar)
            
            
            
            
            if (car1Colored||car2Colored) {
                currentPrompt = colorAnotherCar
            }
            else {
                currentPrompt = tapCarToColor;
            }
            let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
            self.currentPrompt.play();
                
            }
            let delay = DispatchTime.now() + 4.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
            if !self.car1Colored {
                self.car1.isEnabled = true;
            }
            if !self.car2Colored {
                self.car2.isEnabled = true;
            }
            }
            
            usedAudio.append(currentPrompt);
        }
        
    }
    
    @IBAction func plane2Tapped(_ sender: Any) {
        
        
        if (car1Colored&&car2Colored&&plane1Colored) {
            self.plane2.isEnabled = false;
            self.plane2.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height);
            let image = UIImage(named: "Planes.png") as UIImage!;
            flyby.play();
            
            self.plane2.setImage(image, for: UIControlState())
            let delay = DispatchTime.now() + 2 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                
                self.yay.play();
            }
                
            
            
            let when = DispatchTime.now() + 6 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "Gifts")
                self.show(vc as! UIViewController, sender: vc)
            }
            
        }
            
        else if (currentPrompt == tapPlaneToColor) {
            self.plane2.isEnabled = false;
            plane1.isEnabled = false;
            car1.isEnabled = false;
            car2.isEnabled = false;
            UIView.transition(with: self.plane2, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.plane2.setImage(self.coloredPlane2, for: UIControlState())}, completion: nil)
            plane2Colored = true;
            flyby.play();
            
            if (!plane1Colored) {
                checkAudio.append(colorAnotherPlane);
            }
            if (car1Colored==false&&car2Colored==false){
                checkAudio.append(tapCarToColor);
            }
            
            else if ((car1Colored||car2Colored)&&(!(car1Colored&&car2Colored))) {
                checkAudio.append(colorAnotherCar);
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
            self.plane1.isEnabled = true;
            if !self.car1Colored {
                self.car1.isEnabled = true;
            }
            if !self.car2Colored {
                self.car2.isEnabled = true;
            }
            }
            
            usedAudio.append(currentPrompt);
            secondPrompts.remove(at: randomIndex);
        }
            
        else if (currentPrompt == colorAnotherPlane) {
            self.plane2.isEnabled = false;
            plane1.isEnabled = false;
            car1.isEnabled = false;
            car2.isEnabled = false;
            UIView.transition(with: self.plane2, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.plane2.setImage(self.coloredPlane2, for: UIControlState())}, completion: nil)
            plane2Colored = true;
            flyby.play();
            
            checkAudio.append(tapCarToColor);
            checkAudio.append(colorAnotherCar)
            
            
            
            
            if (car1Colored||car2Colored) {
                currentPrompt = colorAnotherCar
            }
            else {
                currentPrompt = tapCarToColor;
            }
            
            let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
            self.currentPrompt.play();
                
            }
            
            let delay = DispatchTime.now() + 4.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
            if !self.car1Colored {
                self.car1.isEnabled = true;
            }
            if !self.car2Colored {
                self.car2.isEnabled = true;
            }
            }
            usedAudio.append(currentPrompt);
        }
        
    }
    
    @IBAction func car1Tapped(_ sender: Any) {
        
        if (car2Colored&&plane2Colored&&plane1Colored) {
            self.car1.isEnabled = false;
            self.car1.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height);
            let image = UIImage(named: "Planes.png") as UIImage!;
            
            UIView.transition(with: self.car1, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.car1.setImage(self.coloredCar1, for: UIControlState())}, completion: nil)
            vroom.play();
            
            self.car1.setImage(image, for: UIControlState())
            let delay = DispatchTime.now() + 2 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                
                self.yay.play();
            }
            
            let when = DispatchTime.now() + 6 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "Gifts")
                self.show(vc as! UIViewController, sender: vc)
            }
            
        }
            
        else if (currentPrompt == tapCarToColor) {
            self.car1.isEnabled = false;
            plane1.isEnabled = false;
            plane2.isEnabled = false;
            car2.isEnabled = false;
            UIView.transition(with: self.car1, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.car1.setImage(self.coloredCar1, for: UIControlState())}, completion: nil)
            car1Colored = true;
            vroom.play();
            
            if (!car2Colored) {
                checkAudio.append(colorAnotherCar);
            }
            if (plane1Colored==false&&plane2Colored==false){
                checkAudio.append(tapPlaneToColor);
            }
            
            else if ((plane1Colored||plane2Colored)&&(!(plane1Colored&&plane2Colored))) {
                checkAudio.append(colorAnotherPlane);
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
            if !self.plane1Colored {
                self.plane1.isEnabled = true;
            }
            if !self.plane2Colored {
                self.plane2.isEnabled = true;
            }
            self.car2.isEnabled = true;
            }
            usedAudio.append(currentPrompt);
            secondPrompts.remove(at: randomIndex);
        }
            
        else if (currentPrompt == colorAnotherCar) {
            self.car1.isEnabled = false;
            plane1.isEnabled = false;
            plane2.isEnabled = false;
            car2.isEnabled = false;
            UIView.transition(with: self.car1, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.car1.setImage(self.coloredCar1, for: UIControlState())}, completion: nil)
            car1Colored = true;
            vroom.play();
            
            checkAudio.append(tapPlaneToColor);
            checkAudio.append(colorAnotherPlane)
            
            
            
            
            if (plane1Colored||plane2Colored) {
                currentPrompt = colorAnotherPlane
            }
            else {
                currentPrompt = tapPlaneToColor;
            }
            let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
            self.currentPrompt.play();
                
            }
            let delay = DispatchTime.now() + 4.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
            if !self.plane1Colored {
                self.plane1.isEnabled = true;
            }
            if !self.plane2Colored {
                self.plane2.isEnabled = true;
            }
            }
            usedAudio.append(currentPrompt);
        }
        
    }
    
    @IBAction func car2Tapped(_ sender: Any) {

        
        if (car1Colored&&plane2Colored&&plane1Colored) {
            self.car2.isEnabled = false;
            self.car2.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height);
            let image = UIImage(named: "Planes.png") as UIImage!;
            vroom.play();
            
            self.car2.setImage(image, for: UIControlState())
            let delay = DispatchTime.now() + 2 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                
                self.yay.play();
            }
            
            
            
            let when = DispatchTime.now() + 6 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "Gifts")
                self.show(vc as! UIViewController, sender: vc)
            }
            
        }
            
        else if (currentPrompt == tapCarToColor) {
            self.car2.isEnabled = false;
            plane1.isEnabled = false;
            plane2.isEnabled = false;
            car1.isEnabled = false;
            UIView.transition(with: self.car2, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.car2.setImage(self.coloredCar2, for: UIControlState())}, completion: nil)
            car2Colored = true;
            vroom.play();
            
            if (!car1Colored) {
                checkAudio.append(colorAnotherCar);
            }
            if (plane1Colored==false&&plane2Colored==false){
                checkAudio.append(tapPlaneToColor);
            }
            
            else if ((plane1Colored||plane2Colored)&&(!(plane1Colored&&plane2Colored))) {
                checkAudio.append(colorAnotherPlane);
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
            if !self.plane1Colored {
                self.plane1.isEnabled = true;
            }
            if !self.plane2Colored {
                self.plane2.isEnabled = true;
            }
                self.car1.isEnabled = true;
            }
            
            
            usedAudio.append(currentPrompt);
            secondPrompts.remove(at: randomIndex);
        }
            
        else if (currentPrompt == colorAnotherCar) {
            self.car2.isEnabled = false;
            plane1.isEnabled = false;
            plane2.isEnabled = false;
            car1.isEnabled = false;
            UIView.transition(with: self.car2, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.car2.setImage(self.coloredCar2, for: UIControlState())}, completion: nil)
            car2Colored = true;
            vroom.play();
            
            checkAudio.append(tapPlaneToColor);
            checkAudio.append(colorAnotherPlane)
            
            
            
            
            if (plane1Colored||plane2Colored) {
                currentPrompt = colorAnotherPlane
            }
            else {
                currentPrompt = tapPlaneToColor;
            }
            
            let when = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
            self.currentPrompt.play();
                
            }
            let delay = DispatchTime.now() + 4.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
            if !self.plane1Colored {
                self.plane1.isEnabled = true;
            }
            if !self.plane2Colored {
                self.plane2.isEnabled = true;
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
