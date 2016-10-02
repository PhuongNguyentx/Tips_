//
//  ViewController.swift
//  Tips
//
//  Copyright © 2016 Phuong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billControl: UISegmentedControl!
    var billFieldContentsKey = "billFieldContentsKey"
    let tipLabelContentsKey = "0"
    let totalLabelContentsKey = "0"
    var darkOn = Bool()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.billControl.tintColor = UIColor(red: 60.0/255.0, green: 125.0/255.0, blue: 208.0/255.0, alpha: 1.0)
        let defaultsPercentage = UserDefaults.standard
        billControl.selectedSegmentIndex = defaultsPercentage.integer(forKey: "tipDefault")
        let defaultsBillField = UserDefaults.standard
        let billFieldContentsKey = defaultsBillField.string(forKey: "billFieldKey")
        
        if billFieldContentsKey == "" || billFieldContentsKey == nil {
            updateTip()
        } else {
            let currentDate = Date()
            let defaultsDateReset = UserDefaults.standard
            let dateSave = defaultsDateReset.object(forKey: "dateReset") as? Date
            if (dateSave != nil) && (currentDate.compare(dateSave!) == ComparisonResult.orderedAscending) {
                self.billField.delegate = self
                self.billField.becomeFirstResponder()
                self.billField.text = billFieldContentsKey
                tipTotalMoney(bill: billFieldContentsKey!, segmentIndex: billControl.selectedSegmentIndex)
                
            } else {
                updateTip()
            }
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.billField.borderStyle = UITextBorderStyle.none
        super.viewWillAppear(animated)
        let darkDefault = UserDefaults.standard
        darkOn = darkDefault.bool(forKey: "darkDefault")
        if (darkOn == true) {
            darkTheme()
        } else {
            lightTheme()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func darkTheme() {
        self.view.backgroundColor =  UIColor(red: 220.0/255.0, green: 225.0/255.0, blue: 229.0/255.0, alpha: 1.0)
        self.billField.backgroundColor = UIColor(red: 220.0/255.0, green: 225.0/255.0, blue: 229.0/255.0, alpha: 1.0)

    }
    
    func lightTheme() {
        self.view.backgroundColor = UIColor.white
        self.billField.backgroundColor = UIColor.white

    }
    
    func saveBill() {
        let defaultsBillField = UserDefaults.standard
        defaultsBillField.setValue(billField.text, forKey: "billFieldKey")
        defaultsBillField.synchronize()

    }
    
    func tipTotalMoney(bill: String, segmentIndex: Int){
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency

        var tipPercentages = [0.1, 0.2, 0.3]
        let tipPercentage =  tipPercentages[segmentIndex]
        let billAmount = Double(bill) ?? 0
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        
        self.tipLabel.text = formatter.string(from: tip as NSNumber)
        self.totalLabel.text = formatter.string(from: total as NSNumber)
    }
    
    func updateTip() {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        self.billField.placeholder = formatter.currencySymbol
        self.billField.delegate = self
        self.billField.becomeFirstResponder()
        self.billField.text = ""
        self.tipLabel.text = formatter.string(from: 0 as NSNumber)
        self.totalLabel.text = formatter.string(from: 0 as NSNumber)
        saveBill()
    }

    @IBAction func onClear(_ sender: AnyObject) {
        updateTip()
    }

    
    @IBAction func onEditingChanged(_ sender: AnyObject) {

        self.tipLabel.alpha = 0
        self.totalLabel.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0.1, animations: {
            // This causes first view to fade in and second view to fade out
            self.tipLabel.alpha = 1
            self.totalLabel.alpha = 1
        })
        
        let segmentIndex = billControl.selectedSegmentIndex
        let billAmount = billField.text
        tipTotalMoney(bill: billAmount!,segmentIndex: segmentIndex)
        saveBill()
    }

    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
}

