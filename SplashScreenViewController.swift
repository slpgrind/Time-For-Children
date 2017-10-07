//
//  SplashScreenViewController.swift
//  Alex
//
//  Created by Alex Panganiban on 4/6/17.
//  Copyright © 2017 TFC. All rights reserved.
//

import UIKit
import AVFoundation

class SplashScreenViewController: UIViewController {
    @IBOutlet weak var touch: UIButton!
    
 
    
    
    
    
    
    
    var tapBookToStart = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "colorSplashScreen", ofType: "mp3")!));

    override func viewDidLoad() {
        touch.adjustsImageWhenDisabled = false;
        self.touch.isEnabled = false;
        tapBookToStart.play();
        
        let when = DispatchTime.now() + 6 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.touch.isEnabled = true;
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
