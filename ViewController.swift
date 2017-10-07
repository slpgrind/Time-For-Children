//
//  ViewController.swift
//  Alex
//
//  Created by Alex Panganiban on 4/3/17.
//  Copyright © 2017 TFC. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let isUserLoggedIn = UserDefaults.standard.bool (forKey: "userLoggedIn");
        if (!isUserLoggedIn) {
            self.performSegue(withIdentifier: "loginView", sender: self);
        }
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        
        UserDefaults.standard.set(true, forKey: "userLoggedIn");
        UserDefaults.standard.synchronize();
        
        self.performSegue(withIdentifier: "loginView", sender: self);
    
        
    }
    


}

