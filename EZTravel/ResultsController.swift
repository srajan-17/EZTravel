//
//  ResultsController.swift
//  EZTravel
//
//  Created by Siddharth Rajan on 6/22/18.
//  Copyright © 2018 CodeOfSid. All rights reserved.
//

import Cocoa

class ResultsController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        label1.stringValue = str1
        
    }
    
    @IBOutlet weak var label1: NSTextField!
    
    var str1 = ""
    
    
    
    
    
    
}
