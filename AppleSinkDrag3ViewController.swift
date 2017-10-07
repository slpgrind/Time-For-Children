//
//  AppleSinkDrag3ViewController.swift
//  Alex
//
//  Created by Alex Panganiban on 5/18/17.
//  Copyright © 2017 TFC. All rights reserved.
//

import UIKit
import AVFoundation

class AppleSinkDrag3ViewController: UIViewController {
    var location = CGPoint(x: 0, y: 0);
    
    @IBOutlet weak var spoon: UIImageView!
    @IBOutlet weak var inSink: UIImageView!
    @IBOutlet weak var washed: UIImageView!
    @IBOutlet weak var inSink2: UIImageView!

    var waterdropsSpoon = UIImage(named: "Waterdrops_Spoon.png");
    
    var prompt = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "spoonUnderWater", ofType: "wav")!));
    
    var correct = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Correct", ofType: "mp3")!));
    
    
    var incorrect = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Incorrect", ofType: "mp3")!));
    
    var water = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Water Sink", ofType: "wav")!));
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var touch : UITouch! = touches.first! as UITouch;
        
        location = touch.location(in: self.view);
        
            
        if spoon.frame.contains(location){
            spoon.center = location;
        }
    }
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        var touch : UITouch! = touches.first! as UITouch;
        
        location = touch.location(in: self.view);
        
            
        if spoon.frame.contains(location){
            spoon.center = location;
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        var touch : UITouch! = touches.first! as UITouch;
        
        location = touch.location(in: self.view);
        
        if inSink.frame.contains(spoon.center) {
            correct.play();
            self.water.play();
            self.inSink.isHidden = true;
            self.inSink2.isHidden = true;
            self.view.isUserInteractionEnabled = false;
            inSink.isUserInteractionEnabled = false;
            inSink2.isUserInteractionEnabled = false;
            washed.image = waterdropsSpoon;
            spoon.center = CGPoint(x: (inSink.frame.origin.x) + 100, y: (inSink.frame.origin.y) + 100);
            inSink.isHidden = false;
            
            spoon.isHidden = true;
            let when = DispatchTime.now() + 4 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "washedSpoon")
                self.show(vc as! UIViewController, sender: vc)
            }
            
        }
        
        if inSink2.frame.contains(spoon.center) {
            correct.play();
            self.water.play();
            self.inSink.isHidden = true;
            self.inSink2.isHidden = true;
            self.view.isUserInteractionEnabled = false;
            inSink2.isUserInteractionEnabled = false;
            inSink.isUserInteractionEnabled = false;
            washed.image = waterdropsSpoon;
            spoon.center = CGPoint(x: (inSink.frame.origin.x) + 100, y: (inSink.frame.origin.y) + 100);
            inSink.isHidden = false;
            
            spoon.isHidden = true;
            let when = DispatchTime.now() + 4 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "washedSpoon")
                self.show(vc as! UIViewController, sender: vc)
            }
            
        }
        
        
    }
    

    override func viewDidLoad() {
        self.view.isUserInteractionEnabled = false;
        let wait = DispatchTime.now() + 1 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: wait) {
            self.prompt.play();
        }
        
        let when = DispatchTime.now() + 4 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.view.isUserInteractionEnabled = true;
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
