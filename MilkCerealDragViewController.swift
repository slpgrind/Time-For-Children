//
//  MilkCerealDragViewController.swift
//  Alex
//
//  Created by Alex Panganiban on 5/30/17.
//  Copyright © 2017 TFC. All rights reserved.
//

import UIKit
import AVFoundation

class MilkCerealDragViewController: UIViewController {
    var location = CGPoint(x: 0, y: 0);
    
    @IBOutlet weak var cereal: UIImageView!
    @IBOutlet weak var milk: UIImageView!
    @IBOutlet weak var bowl: UIImageView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var fruit: UIImageView!
    
    var milkBowl = UIImage(named: "Bowl_Milk.png");
    var cerealBowl = UIImage(named: "Bowl_Cereal.png");
    var milkCerealBowl = UIImage(named: "Bowl_Cereal-Milk.png");
    
    var cerealInBowl = false;
    var milkInBowl = false;
    
    //Load Audio
    var great = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "great", ofType: "mp3")!));
    
    var pourCerealMilk = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "pourMilkPourCereal", ofType: "wav")!));
    
    var listenAgain = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "listenAgain", ofType: "mp3")!));
    
    var tryAgain = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "tryCereal", ofType: "mp3")!));
    
    var correct = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Correct", ofType: "mp3")!));
    
    
    var incorrect = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Incorrect", ofType: "mp3")!));
    
    var pour = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "pour", ofType: "wav")!));
    
    var pourCereal = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "pourCereal", ofType: "wav")!));
    
    var pourMilk = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "pourMilk", ofType: "wav")!));

    override func viewDidLoad() {
        self.view.isUserInteractionEnabled = false;
        
        pourCerealMilk.play();
        
        let delay = DispatchTime.now() + 7 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: delay) {
            self.view.isUserInteractionEnabled = true;
        }
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var touch : UITouch! = touches.first! as UITouch;
        
        location = touch.location(in: self.view);
        
        if cereal.frame.contains(location){
            cereal.center = location;
        }
            
        else if milk.frame.contains(location){
            milk.center = location;
        }
    }
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        var touch : UITouch! = touches.first! as UITouch;
        
        location = touch.location(in: self.view);
        
        if cereal.frame.contains(location) {
            cereal.center = location;
        }
            
        else if milk.frame.contains(location){
            milk.center = location;
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        var touch : UITouch! = touches.first! as UITouch;
        
        
        location = touch.location(in: self.view);
        
        if (bowl.frame.contains(cereal.center) && !cereal.isHidden) {
            self.view.isUserInteractionEnabled = false
            correct.play();
            
            let delay = DispatchTime.now() + 2 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.view.isUserInteractionEnabled = true
            }
            
            pourCereal.play();
            cereal.isHidden = true;
            image.image = cerealBowl;
            cerealInBowl = true;
            
        }
        
        if (bowl.frame.contains(milk.center) && !milk.isHidden) {
            self.view.isUserInteractionEnabled = false
            correct.play();
            pourMilk.play()
            let delay = DispatchTime.now() + 2 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.view.isUserInteractionEnabled = true
            }
            milk.isHidden = true;
            image.image = milkBowl;
            milkInBowl = true;
            
        }
        
        if (bowl.frame.contains(cereal.center) && milkInBowl) {
            self.view.isUserInteractionEnabled = false
            cereal.isHidden = true;
            correct.play();
            pourCereal.play();
            let delay = DispatchTime.now() + 2 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.view.isUserInteractionEnabled = true
            }
            image.image = milkCerealBowl;
            cerealInBowl = true;
            
        }
        
        if (bowl.frame.contains(milk.center) && cerealInBowl) {
            self.view.isUserInteractionEnabled = false
            correct.play();
            pourMilk.play()
            let delay = DispatchTime.now() + 2 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.view.isUserInteractionEnabled = true
            }
            milk.isHidden = true;
            image.image = milkCerealBowl;
            milkInBowl = true;
            
        }
        
        if (fruit.frame.contains(milk.center)) {
            self.view.isUserInteractionEnabled = false
            self.incorrect.play();
            let wait = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: wait) {
               self.tryAgain.play()
            }
            
            
            let delay = DispatchTime.now() + 9 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.view.isUserInteractionEnabled = true
            }
            
        }
        
        if (fruit.frame.contains(cereal.center)) {
            self.view.isUserInteractionEnabled = false
            incorrect.play();
            let wait = DispatchTime.now() + 2.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: wait) {
                self.tryAgain.play();
            }
            
            tryAgain.play()
            let delay = DispatchTime.now() + 9 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.view.isUserInteractionEnabled = true
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
