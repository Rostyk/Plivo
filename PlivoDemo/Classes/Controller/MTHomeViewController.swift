//
//  ViewController.swift
//  PlivoDemo
//
//  Created by Rostyslav.Stepanyak on 03/02/17.
//  Copyright © 2016 Dark Matter LLC. All rights reserved.
//

import UIKit

class MTHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onTouchShowMeContactsButton(_ sender: AnyObject) {
        let contactPickerScene = MTContactsViewController(delegate: self, multiSelection: false, subtitleCellType: SubtitleCellValue.email)
        self.navigationController?.pushViewController(contactPickerScene, animated: true)
    }
}

extension MTHomeViewController : MTPickerDelegate {
    func epContactPicker(_: MTContactsViewController, didContactFetchFailed error: NSError) {
        print("Failed with error \(error.description)")
    }
    
    func epContactPicker(_: MTContactsViewController, didSelectContact contact: MTContact) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let callController = storyboard.instantiateViewController(withIdentifier: "MTCallViewController") as! MTCallViewController
        callController.recipient = contact
        
        self.navigationController?.present(callController, animated: true, completion: nil)
    }
    
    func epContactPicker(_: MTContactsViewController, didCancel error: NSError) {
        print("User canceled the selection")
    }
    
    func  epContactPicker(_: MTContactsViewController, didSelectMultipleContacts contacts: [MTContact]) {
        print("The following contacts are selected")
        for contact in contacts {
            print("\(contact.displayName())")
        }
    }
}
