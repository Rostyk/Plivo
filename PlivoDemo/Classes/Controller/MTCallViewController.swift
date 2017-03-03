//
//  MTCallViewController.swift
//  PlivoDemo
//
//  Created by Rostyslav.Stepanyak on 3/3/17.
//  Copyright © 2017 Prabaharan Elangovan. All rights reserved.
//

import UIKit

class MTCallViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBOutlet weak var recipientLabel: UILabel!
    @IBOutlet weak var callMuteButton: UIButton!
    @IBOutlet weak var callKeypadButton: UIButton!
    @IBOutlet weak var callSpeakerButton: UIButton!
    
    // MARK: UI outlet event handlers
    @IBAction func rejectCallButtonClicked(_ sender: Any) {
        
    }
}
