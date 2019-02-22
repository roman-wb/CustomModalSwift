//
//  SecondViewController.swift
//  CustomModal
//
//  Created by roman on 20/02/2019.
//  Copyright © 2019 roman. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backDidTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

}
