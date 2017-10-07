//
//  KitchenSplash2ViewController.swift
//  Alex
//
//  Created by Alex Panganiban on 5/20/17.
//  Copyright © 2017 TFC. All rights reserved.
//

import UIKit
import AVFoundation

class KitchenSplash2ViewController: UIViewController {
    var location = CGPoint(x: 0, y: 0);
    @IBOutlet weak var egg: UIImageView!
    @IBOutlet weak var inSink: UIImageView!
    @IBOutlet weak var brokenEgg: UIImageView!
    var touchEgg = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "touchEgg3", ofType: "mp3")!));
    
    var wowEgg = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "wowEgg", ofType: "mp3")!));
    
    var correct = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Correct", ofType: "mp3")!));
    
    var broke = UIImage(named: "egg.png");
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var touch : UITouch! = touches.first! as UITouch;
        
        location = touch.location(in: self.view);
        
        if egg.frame.contains(location){
            egg.center = location;
        }
            
    
    }
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        var touch : UITouch! = touches.first! as UITouch;
        
        location = touch.location(in: self.view);
        
        if egg.frame.contains(location) {
            egg.center = location;
        }
        
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        var touch : UITouch! = touches.first! as UITouch;
        
        
        location = touch.location(in: self.view);
        
        if inSink.frame.contains(egg.center) {
            self.view.isUserInteractionEnabled = false
            correct.play()
            brokenEgg.image = broke;
            egg.center = CGPoint(x: (inSink.frame.origin.x) + 100, y: (inSink.frame.origin.y) + 100);
        
            
            egg.isHidden = true;
            
            let wait = DispatchTime.now() + 1.4 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: wait) {
                self.wowEgg.play()
            }

            
            let when = DispatchTime.now() + 8 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "spoonapple")
                self.show(vc as! UIViewController, sender: vc)
            }
            
        }
        
        
        
        
    }

    override func viewDidLoad() {
        touchEgg.play();
        self.view.isUserInteractionEnabled = false
        
        let when = DispatchTime.now() + 4 // change 2 to desired number of seconds
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
