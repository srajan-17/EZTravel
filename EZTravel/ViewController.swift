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
        let apiKey = "mXqBSjV7MM1Q73zaS7AGI51F2844WeGd"
        var url = "http://api.sandbox.amadeus.com/v1.2/flights/inspiration-search?apikey=\(apiKey)"
        
        var origin_input = ""
        if originTextField.stringValue != "" {
            origin_input = "&origin=\(originTextField.stringValue)"
        }
        
        var dest_input = ""
        if destTextField.stringValue != "" {
            dest_input = "&destination=\(destTextField.stringValue)"
        }
        
        var depart_input = ""
        if monthTextField.stringValue != "" && dayTextField.stringValue != "" && yearTextField.stringValue != "" && endMonthTextField.stringValue != "" && endDayTextField.stringValue != "" && endYearTextField.stringValue != "" {
            depart_input = "&departure_date=\(yearTextField.stringValue)-\(monthTextField.stringValue)-\(dayTextField.stringValue)--\(endYearTextField.stringValue)-\(endMonthTextField.stringValue)-\(endDayTextField.stringValue)"
        }
        else if monthTextField.stringValue != "" && dayTextField.stringValue != "" && yearTextField.stringValue != "" && endMonthTextField.stringValue == "" && endDayTextField.stringValue == "" && endYearTextField.stringValue == "" {
            depart_input = "&departure_date=\(yearTextField.stringValue)-\(monthTextField.stringValue)-\(dayTextField.stringValue)"
        }
        else if monthTextField.stringValue == "" && dayTextField.stringValue == "" && yearTextField.stringValue == "" && endMonthTextField.stringValue != "" && endDayTextField.stringValue != "" && endYearTextField.stringValue != "" {
            depart_input = "&departure_date=\(endYearTextField.stringValue)-\(endMonthTextField.stringValue)-\(endDayTextField.stringValue)"
        }
        
        var one_way_input = ""
        if (oneWayYesCheck.state.rawValue == 1 && oneWayNoCheck.state.rawValue == 0) || (oneWayYesCheck.state.rawValue == 1 && oneWayNoCheck.state.rawValue == 1) {
            one_way_input = "&one-way=true"
        }
        else {
            one_way_input = "&one-way=false"
        }
        
        var duration_input = ""
        if durStartTextField.stringValue != "" && durEndTextField.stringValue != "" {
            duration_input = "&duration=\(durStartTextField.stringValue)--\(durEndTextField.stringValue)"
        }
        else if durStartTextField.stringValue != "" && durEndTextField.stringValue == "" {
            duration_input = "&duration=\(durStartTextField.stringValue)"
        }
        else if durStartTextField.stringValue == "" && durEndTextField.stringValue != "" {
            duration_input = "&duration=\(durEndTextField.stringValue)"
        }
        
        var direct_input = ""
        if (dirFlightYesCheck.state.rawValue == 1 && dirFlightNoCheck.state.rawValue == 0) || (dirFlightYesCheck.state.rawValue == 1 && dirFlightNoCheck.state.rawValue == 1) {
            direct_input = "&direct=true"
        }
        else {
            direct_input = "&direct=false"
        }
        
        var price_input = ""
        if maxPriceTextField.stringValue != "" {
            price_input = "&max_price=\(maxPriceTextField.stringValue)"
        }
        
        
        print(url)
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

