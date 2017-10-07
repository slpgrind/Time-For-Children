//
//  MilkCerealViewController.swift
//  Alex
//
//  Created by Alex Panganiban on 5/16/17.
//  Copyright © 2017 TFC. All rights reserved.
//

import UIKit
import AVFoundation

class MilkCerealViewController: UIViewController {
    var location = CGPoint(x: 0, y: 0);
    
    @IBOutlet weak var milk: UIButton!
    @IBOutlet weak var cereal: UIButton!
    @IBOutlet weak var bowl: UIButton!
    
    var milkTapped = false;
    var cerealTapped = false;
    
    var milkInBowl = false;
    var cerealInBowl = false;
    
    var milkBowl = UIImage(named: "Bowl_Milk.png");
    var cerealBowl = UIImage(named: "Bowl_Cereal.png");
    var milkCerealBowl = UIImage(named: "Bowl_Cereal-Milk.png");
    
    //Load Audio
    var great = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "great", ofType: "mp3")!));
    
    var pourCerealMilk = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "pourCerealMilk", ofType: "mp3")!));
    
    var listenAgain = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "listenAgain", ofType: "mp3")!));
    
    var tryAgain = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "tryAgain", ofType: "mp3")!));
    
    var correct = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Correct", ofType: "mp3")!));
    
    
    var incorrect = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Incorrect", ofType: "mp3")!));
    
    var pour = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "pour", ofType: "wav")!));
    
    var pourCereal = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "pourCereal", ofType: "wav")!));
    

    override func viewDidLoad() {
        milk.isEnabled = false;
        cereal.isEnabled = false;
        bowl.isEnabled = false;
        
        pourCerealMilk.play();
        
        let delay = DispatchTime.now() + 7 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: delay) {
            self.milk.isEnabled = true;
            self.cereal.isEnabled = true;
            self.bowl.isEnabled = true;
        }
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func milkTapped(_ sender: Any) {
        milkTapped = true;
        if (cerealTapped && !cerealInBowl) {
            incorrect.play()
            milkTapped = false;
        }
        
    }
    @IBAction func cerealTapped(_ sender: Any) {
        cerealTapped = true;
        if (milkTapped && !milkInBowl) {
            incorrect.play()
            cerealTapped = false;
        }
    }
    
    @IBAction func bowlTapped(_ sender: Any) {
        if milkTapped && !cerealTapped {
            
            milkInBowl = true;
            correct.play();
            pour.play();
            UIView.transition(with: self.bowl, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.bowl.setImage(self.milkBowl, for: UIControlState())}, completion: nil)
            
            milk.isHidden = true;
            milk.isEnabled = false;
            
        }
        else if (cerealTapped && !milkTapped) {
            pourCereal.play();
            cerealInBowl = true;
            correct.play();
            UIView.transition(with: self.bowl, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.bowl.setImage(self.cerealBowl, for: UIControlState())}, completion: nil)
            
            cereal.isHidden = true;
            cereal.isEnabled = false;
            
        }
        
        
        if (cerealTapped && milkTapped) {
            correct.play();
            UIView.transition(with: self.bowl, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.bowl.setImage(self.milkCerealBowl, for: UIControlState())}, completion: nil)
            
            if (cerealTapped) {
                pourCereal.play();
            }
            else {
                pour.play();
            }
            
            let delay = DispatchTime.now() + 3 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.great.play();
            }
            
            
            cereal.isHidden = true;
            cereal.isEnabled = false;
            
            milk.isHidden = true;
            milk.isEnabled = false;
            
            
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
