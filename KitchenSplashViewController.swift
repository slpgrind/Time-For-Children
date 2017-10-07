//
//  KitchenSplashViewController.swift
//  Alex
//
//  Created by Alex Panganiban on 5/5/17.
//  Copyright © 2017 TFC. All rights reserved.
//

import UIKit
import AVFoundation

class KitchenSplashViewController: UIViewController {
    @IBOutlet weak var splashButton: UIButton!
    
    var touchEgg = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "touchEgg", ofType: "mp3")!));
    
    var wowEgg = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "wowEgg", ofType: "mp3")!));

    override func viewDidLoad() {
        splashButton.adjustsImageWhenDisabled = false;
        splashButton.isEnabled = false;
        
        touchEgg.play();
        
        let when = DispatchTime.now() + 3.5 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.splashButton.isEnabled = true;
        }
        
        

        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func splashTapped(_ sender: Any) {
        
        let delay = DispatchTime.now() + 0 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: delay) {
            self.wowEgg.play();
        }
        
        
        
        
        let wait = DispatchTime.now() + 6.2 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: wait) {
            let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "spoonapple")
            self.show(vc as! UIViewController, sender: vc)
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
