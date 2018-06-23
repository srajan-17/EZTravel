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
    
    var json = NSDictionary()
    
    @IBAction func iataCodeButton(_ sender: NSButton) {
        if let url = URL(string: "http://www.nationsonline.org/oneworld/IATA_Codes/IATA_Code_A.htm"), NSWorkspace.shared.open(url) {
            print("default browser was successfully opened")
        }
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        callAPI()
        let second = segue.destinationController as! ResultsController
        second.str1 = "Hello"
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
        
        print("\nURL = \(url)\n")
        
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
                print(fullResults.results[0].airline)
                print(fullResults.results[1].departure_date)
                print(fullResults.results[2].destination)
                
                
                
            } catch let error as NSError {
                print("\nerror = \(error.localizedDescription)\n")
            }
            
        }
        
        task.resume()
    }
    
    func getResults() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

