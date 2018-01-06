//
//  GetLocation.swift
//  LAB6
//
//  Created by Marcus Williams on 10/30/17.
//  Copyright © 2017 Marcus Williams. All rights reserved.
//

import UIKit
var city = "";
var state = "";
var country = "";
var str = "";
class GetLocation: ViewController {

    @IBOutlet var StateTextField: UITextField!
    @IBOutlet var cityTextField: UITextField!
    
    @IBOutlet var empty: UILabel!
    @IBAction func Geocode(_ sender: UIButton) {
        if StateTextField.text == "" || cityTextField.text == ""
        {
            empty.isHidden  = false
        }
        else{
            empty.isHidden = true
            state = StateTextField.text!;
            city = cityTextField.text!;
            country = "United States";
            str = "\(country), \(state), \(city)"
            performSegue(withIdentifier: "mapit" , sender: (Any).self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        empty.isHidden = true
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
