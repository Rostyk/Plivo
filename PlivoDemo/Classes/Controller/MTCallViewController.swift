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
    
    // MARK: Main calling actions
    
    func callRecipient() {
        MTCallManager.shared().makeCall(recipient) { [weak self] (success, error) in
            if let error = error {
                self?.logTextView.text = (self?.logTextView.text)!  + error.localizedDescription
            }
            else {
                self?.logTextView.text =  (self?.logTextView.text)!  + "[Plivo] Call started\n"
            }
        }
    }
}

extension MTCallViewController : CallDelegate {
    func onLogin() {
        self.appendLog("[Plivo] Endpoint logged in\n")
        self.callStatusLabel.text = "Dialing..."

        /*This is very ugly but Plivo SDK has a bug with concurremcy which doesn't allow
         * to use GCD (any dispatch_async) here*/
        DispatchQueue.main.async {
            self.callRecipient()
        }
    }
    
    func onLoginFailed() {
        self.appendLog("[Plivo] Endpoint loggin failed\n")
    }
    
    func onOutgoingCallAnswered(_ call: PlivoOutgoing) {
        self.appendLog("[Plivo] Call answered\n")
    }
    
    func onOutgoingCallHangup(_ call: PlivoOutgoing) {
        self.appendLog("[Plivo] Call hung up\n")
    }
    
    func onCalling(_ call: PlivoOutgoing) {
        self.appendLog("[Plivo] Calling...\n")
        self.callStatusLabel.text = "Calling..."
    }
    
    func onOutgoingCallRinging(_ call: PlivoOutgoing) {
        self.appendLog("[Plivo] Calling ringing\n")
        self.callStatusLabel.text = "Call ringing"
    }
    
    func onOutgoingCallRejected(_ call: PlivoOutgoing) {
        self.appendLog("[Plivo] Call rejected\n")
        self.callStatusLabel.text = "Call rejected"
    }
    
    func onOutgoingCallInvalid(_ call: PlivoOutgoing) {
        self.appendLog("[Plivo] Invalid call\n")
        self.callStatusLabel.text = "Invlid call"
    }

    func appendLog(_ log: String) {
        DispatchQueue.main.async {
            self.logTextView.text =  (self.logTextView.text)! + log
        }
    }
}
