//
//  ViewController.swift
//  EZTravel
//
//  Created by Siddharth Rajan on 6/17/18.
//  Copyright © 2018 CodeOfSid. All rights reserved.
//

import Cocoa

struct FullResults: Decodable {
    let origin: String?
    let currency: String?
    let results: [Result]
}

struct Result: Decodable {
    let destination: String
    let departure_date: String
    let return_date: String
    let price: String
    let airline: String
}

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
    
    var results = [Result]()
    
    @IBAction func iataCodeButton(_ sender: NSButton) {
        if let url = URL(string: "http://www.nationsonline.org/oneworld/IATA_Codes/IATA_Code_A.htm"), NSWorkspace.shared.open(url) {
            print("default browser was successfully opened")
        }
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        callAPI()                                                           // Gives results variable
        let second = segue.destinationController as! ResultsController      // Gives variable for second screen
        print("In prepare segue, size = \(self.results.count)")
        if results.count >= 1 {
            second.r1 = "\(results[0].destination)"
            second.r2 = "\(results[0].departure_date)"
            second.r3 = "\(results[0].return_date)"
            second.r4 = "\(results[0].price)"
            second.r5 = "\(results[0].airline)"
        }
        if results.count >= 2 {
            second.r6 = "\(results[1].destination)"
            second.r7 = "\(results[1].departure_date)"
            second.r8 = "\(results[1].return_date)"
            second.r9 = "\(results[1].price)"
            second.r10 = "\(results[1].airline)"
        }
        if results.count >= 3 {
            second.r11 = "\(results[2].destination)"
            second.r12 = "\(results[2].departure_date)"
            second.r13 = "\(results[2].return_date)"
            second.r14 = "\(results[2].price)"
            second.r15 = "\(results[2].airline)"
        }
        if results.count >= 4 {
            second.r16 = "\(results[3].destination)"
            second.r17 = "\(results[3].departure_date)"
            second.r18 = "\(results[3].return_date)"
            second.r19 = "\(results[3].price)"
            second.r20 = "\(results[3].airline)"
        }
        if results.count >= 5 {
            second.r21 = "\(results[4].destination)"
            second.r22 = "\(results[4].departure_date)"
            second.r23 = "\(results[4].return_date)"
            second.r24 = "\(results[4].price)"
            second.r25 = "\(results[4].airline)"
        }
        
    }
    
    func callAPI() {
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
        
        //print("\nURL = \(url)\n")
        
        // Get JSON
        let myUrl = NSURL(string: url);
        
        let request = NSMutableURLRequest(url:myUrl! as URL);
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil
            {
                print("\nerror=\(String(describing: error))\n")
                return
            }
            guard let data = data else { return }
            
            // Convert server JSON response to NSDictionary
            do {
                let fullResults = try JSONDecoder().decode(FullResults.self, from: data)
                self.results = fullResults.results
                print("In API, size = \(self.results.count)")
                
            } catch let error as NSError {
                print("\nerror = \(error.localizedDescription)\n")
            }
            
        }
        
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

