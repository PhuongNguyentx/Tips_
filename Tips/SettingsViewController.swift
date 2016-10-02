//
//  SettingsViewController.swift
//  Tips
//
//  Copyright © 2016 Phuong. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var darkSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard
        tipControl.selectedSegmentIndex = defaults.integer(forKey: "tipDefault")
        let darkDefault = UserDefaults.standard
        self.darkSwitch.isOn = darkDefault.bool(forKey: "darkDefault")
        
        self.darkSwitch.tintColor = UIColor(red: 60.0/255.0, green: 125.0/255.0, blue: 208.0/255.0, alpha: 1.0)
        self.darkSwitch.onTintColor = UIColor(red: 60.0/255.0, green: 125.0/255.0, blue: 208.0/255.0, alpha: 1.0)
        self.tipControl.tintColor = UIColor(red: 60.0/255.0, green: 125.0/255.0, blue: 208.0/255.0, alpha: 1.0)
        
        if (darkSwitch.isOn == true){
            self.view.backgroundColor = UIColor(red: 220.0/255.0, green: 225.0/255.0, blue: 229.0/255.0, alpha: 1.0)
        } else {
            self.view.backgroundColor = UIColor.white
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func darkAction(_ sender: AnyObject) {
        let darkDefault = UserDefaults.standard
        if (darkSwitch.isOn == true){
            darkDefault.set(true, forKey: "darkDefault")
            self.view.backgroundColor = UIColor(red: 220.0/255.0, green: 225.0/255.0, blue: 229.0/255.0, alpha: 1.0)
        } else {
            darkDefault.set(false, forKey: "darkDefault")
            self.view.backgroundColor = UIColor.white
        }
        darkDefault.synchronize()
    }
    @IBAction func onTipChanged(_ sender: AnyObject) {
        
        let defaults = UserDefaults.standard
        let tipIndex = tipControl.selectedSegmentIndex
        defaults.set(tipIndex, forKey: "tipDefault")
        defaults.synchronize()

        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


