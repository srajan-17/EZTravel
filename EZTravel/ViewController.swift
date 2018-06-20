//
//  ViewController.swift
//  EZTravel
//
//  Created by Siddharth Rajan on 6/17/18.
//  Copyright © 2018 CodeOfSid. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var originTextField: NSTextField!
    @IBOutlet weak var destTextField: NSTextField!
    
    @IBOutlet weak var monthTextField: NSTextField!
    @IBOutlet weak var dayTextField: NSTextField!
    @IBOutlet weak var yearTextField: NSTextField!
    
    @IBOutlet weak var endMonthTextField: NSTextField!
    @IBOutlet weak var endDayTextField: NSTextField!
    @IBOutlet weak var endYearTextField: NSTextField!
    
    @IBOutlet weak var durStartTextField: NSTextField!
    @IBOutlet weak var durEndTextField: NSTextField!
    
    @IBOutlet weak var maxPriceTextField: NSTextField!
    
    @IBOutlet weak var oneWayYesCheck: NSButton!
    @IBOutlet weak var oneWayNoCheck: NSButton!
    
    @IBOutlet weak var dirFlightYesCheck: NSButton!
    @IBOutlet weak var dirFlightNoCheck: NSButton!
    
    @IBAction func iataCodeButton(_ sender: NSButton) {
        if let url = URL(string: "http://www.nationsonline.org/oneworld/IATA_Codes/IATA_Code_A.htm"), NSWorkspace.shared.open(url) {
            print("default browser was successfully opened")
        }
    }
    @IBAction func submitButton(_ sender: NSButton) {
        
        // call API and print result in new window
        let apiKey = "*"
        var url = "https://api.sandbox.amadeus.com/v1.2/flights/inspiration-search?apikey=\(apiKey)"
        
        if originTextField.stringValue != "" {
            url += "&origin=\(originTextField.stringValue)"
        }
        
        if destTextField.stringValue != "" {
            url += "&destination=\(destTextField.stringValue)"
        }
        
        if monthTextField.stringValue != "" && dayTextField.stringValue != "" && yearTextField.stringValue != "" && endMonthTextField.stringValue != "" && endDayTextField.stringValue != "" && endYearTextField.stringValue != "" {
            url += "&departure_date=\(yearTextField.stringValue)-\(monthTextField.stringValue)-\(dayTextField.stringValue)--\(endYearTextField.stringValue)-\(endMonthTextField.stringValue)-\(endDayTextField.stringValue)"
        }
        else if monthTextField.stringValue != "" && dayTextField.stringValue != "" && yearTextField.stringValue != "" && endMonthTextField.stringValue == "" && endDayTextField.stringValue == "" && endYearTextField.stringValue == "" {
            url += "&departure_date=\(yearTextField.stringValue)-\(monthTextField.stringValue)-\(dayTextField.stringValue)"
        }
        else if monthTextField.stringValue == "" && dayTextField.stringValue == "" && yearTextField.stringValue == "" && endMonthTextField.stringValue != "" && endDayTextField.stringValue != "" && endYearTextField.stringValue != "" {
            url += "&departure_date=\(endYearTextField.stringValue)-\(endMonthTextField.stringValue)-\(endDayTextField.stringValue)"
        }
        
        if (oneWayYesCheck.state.rawValue == 1 && oneWayNoCheck.state.rawValue == 0) || (oneWayYesCheck.state.rawValue == 1 && oneWayNoCheck.state.rawValue == 1) {
            url += "&one-way=true"
        }
        else {
            url += "&one-way=false"
        }
        
        if durStartTextField.stringValue != "" && durEndTextField.stringValue != "" {
            url += "&duration=\(durStartTextField.stringValue)--\(durEndTextField.stringValue)"
        }
        else if durStartTextField.stringValue != "" && durEndTextField.stringValue == "" {
            url += "&duration=\(durStartTextField.stringValue)"
        }
        else if durStartTextField.stringValue == "" && durEndTextField.stringValue != "" {
            url += "&duration=\(durEndTextField.stringValue)"
        }
        
        if (dirFlightYesCheck.state.rawValue == 1 && dirFlightNoCheck.state.rawValue == 0) || (dirFlightYesCheck.state.rawValue == 1 && dirFlightNoCheck.state.rawValue == 1) {
            url += "&direct=true"
        }
        else {
            url += "&direct=false"
        }
        
        if maxPriceTextField.stringValue != "" {
            url += "&max_price=\(maxPriceTextField.stringValue)"
        }
        
        print("\nURL = \(url)\n")
        
        /*
        let urlString = URL(string: url)
        
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url) {
                (data, response, error) in
                if error != nil {
                    print("\n\nerror = \(error!)\n\n")
                }
                else {
                    if let usableData = data {
                        print("\n\nusableDate = \(usableData)\n\n")
                    }
                }
            }
            task.resume()
        }*/
        
        // Create NSURL Ibject
        let myUrl = NSURL(string: url);
        
        // Creaste URL Request
        let request = NSMutableURLRequest(url:myUrl! as URL);
        
        // Set request HTTP method to GET. It could be POST as well
        request.httpMethod = "GET"
        
        // Excute HTTP Request
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            // Check for error
            if error != nil
            {
                print("\nerror=\(String(describing: error))\n")
                return
            }
            
            // Print out response string
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("\nresponseString = \(String(describing: responseString))\n")
            
            
            // Convert server json response to NSDictionary
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                    
                    // Print out dictionary
                    print("\nJSON = \(convertedJsonIntoDict)\n")
                    
                }
            } catch let error as NSError {
                print("\nerror = \(error.localizedDescription)\n")
            }
            
        }
        
        task.resume()
        
        
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

