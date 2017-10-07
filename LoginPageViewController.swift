//
//  LoginPageViewController.swift
//  Alex
//
//  Created by Alex Panganiban on 4/6/17.
//  Copyright © 2017 TFC. All rights reserved.
//

import UIKit

class LoginPageViewController: UIViewController {
    @IBOutlet weak var userInitialsTextField: UITextField!
    @IBOutlet weak var todaysDate: UILabel!
    @IBOutlet weak var childsBirthdate: UIDatePicker!
    @IBOutlet weak var childsAge: UILabel!

    override func viewDidLoad() {
        childsBirthdate.maximumDate = Date();
        
        let userCalendar = Calendar.current;
        let dateFormatter = DateFormatter();
        let today = Date();
        dateFormatter.dateStyle = DateFormatter.Style.long;
        
        let result = dateFormatter.string(from: today);
        todaysDate.text = "Today's Date: \(result)";
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func birthdateChosen(_ sender: Any) {
        let date: Date = childsBirthdate.date
        let userCalendar = Calendar.current
        let dateFormatter = DateFormatter()
        let today = Date()
        dateFormatter.dateStyle = DateFormatter.Style.long
        
        
        let requestedComponent: Set<Calendar.Component> = [.year, .month, .day,]
        let timeDifference = userCalendar.dateComponents(requestedComponent, from: date, to: today)
        
        
        
        childsAge.text = "Child's age: \(timeDifference.year!) Year(s), \(timeDifference.month!) Months and \(timeDifference.day!) Days old"
        
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        let userInitials = userInitialsTextField.text
        
        //Check for empty fields
        if userInitials == "" {
            displayMyAlert(userMessage: "Please ensure all fields are filled out.")
            return;
        }
        
        
        //Display alert message
        
        var myAlert = UIAlertController(title: "Login Successful!", message: "Please hand the device over to the child.", preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default) {
            action in self.dismiss(animated: true, completion: nil);
            
            UserDefaults.standard.set(true, forKey: "userLoggedIn");
            UserDefaults.standard.synchronize();
            
        }
        
        myAlert.addAction(okAction);
        self.present(myAlert, animated: true, completion: nil);
    }
    
    func displayMyAlert(userMessage: String) {
        
        var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated: true, completion: nil);
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
