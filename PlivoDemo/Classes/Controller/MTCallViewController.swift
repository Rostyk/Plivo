//
//  MTCallViewController.swift
//  PlivoDemo
//
//  Created by Rostyslav.Stepanyak on 3/3/17.
//  Copyright © 2017 Prabaharan Elangovan. All rights reserved.
//

import UIKit
import Foundation

class MTCallViewController: UIViewController {
    @IBOutlet weak var logTextView: UITextView!
    @IBOutlet weak var callStatusLabel: UILabel!
    @IBOutlet weak var recipientLabel: UILabel!
    @IBOutlet weak var callMuteButton: UIButton!
    @IBOutlet weak var callKeypadButton: UIButton!
    @IBOutlet weak var callSpeakerButton: UIButton!
    
    var recipient: MTContact!
    
    // MARK: - Lifycycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        self.recipientLabel.text = self.recipient.getPrimaryPhone()
        
        MTCallManager.shared().delegate = self
        
        if (MTCallManager.shared().prepared) {
            callRecipient()
        }
        else {
           MTCallManager.shared().prepare()
        }
        
    }
    
    // MARK: Main calling actions
    
    func callRecipient() {
        MTCallManager.shared().makeCall(recipient) { [weak self] (success, error) in
            if let error = error {
                self?.appendLog(error.localizedDescription)
            }
            else {
                self?.appendLog("Call started\n")
            }
        }
    }
    
    // MARK: - UI outlet event handlers
    
    @IBAction func muteCallButtonClicked(_ sender: Any) {
        MTCallManager.shared().mute()
    }
    
    @IBAction func speakerButtonClicked(_ sender: Any) {
        MTCallManager.shared().speaker(true)
    }
    
    @IBAction func rejectCallButtonClicked(_ sender: Any) {
        MTCallManager.shared().hangUp()
       
        self.dismiss(animated: true, completion: nil)
    }
}

extension MTCallViewController : CallDelegate {
    func onLogin() {
        self.appendLog("Endpoint logged in\n")

        
        self.callRecipient()
    }
    
    func onLoginFailed() {
        self.appendLog("Endpoint loggin failed\n")
    }
    
    func onOutgoingCallAnswered(_ call: PlivoOutgoing) {
        self.appendLog("Call answered\n")
    }
    
    func onOutgoingCallHangup(_ call: PlivoOutgoing) {
        self.appendLog("Call hung up\n")
    }
    
    func onCalling(_ call: PlivoOutgoing) {
        self.appendLog("Calling...\n")
    }
    
    func onOutgoingCallRinging(_ call: PlivoOutgoing) {
        self.appendLog("Calling ringing\n")
    }
    
    func onOutgoingCallRejected(_ call: PlivoOutgoing) {
        self.appendLog("Call rejected\n")
    }
    
    func onOutgoingCallInvalid(_ call: PlivoOutgoing) {
        self.appendLog("Invalid call\n")
    }

    func appendLog(_ log: String) {
        DispatchQueue.main.async {
            if let logView = self.logTextView {
                logView.text = logView.text + "[Plivo]" + log
            }
            
            if let logStatus = self.callStatusLabel {
                logStatus.text = log
            }
            
        }
    }
}
