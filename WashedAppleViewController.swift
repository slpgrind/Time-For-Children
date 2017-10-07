//
//  WashedAppleViewController.swift
//  Alex
//
//  Created by Alex Panganiban on 5/10/17.
//  Copyright © 2017 TFC. All rights reserved.
//

import UIKit
import AVFoundation

class WashedAppleViewController: UIViewController {

    
    var shine = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Apple and Spoon Shining", ofType: "mp3")!));
    
    
    override func viewDidLoad() {
        self.view.isUserInteractionEnabled = false;
        
        super.viewDidLoad()
        
        shine.play();
            
        let when = DispatchTime.now() + 3 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "washSpoon")
            self.show(vc as! UIViewController, sender: vc)
        }

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
