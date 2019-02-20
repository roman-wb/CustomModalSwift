//
//  SettingsViewController.swift
//  CustomModal
//
//  Created by roman on 20/02/2019.
//  Copyright © 2019 roman. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    weak var customModalViewController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonDidTapped(_ sender: Any) {
        customModalViewController.dismiss(animated: true, completion: nil)
    }

}
