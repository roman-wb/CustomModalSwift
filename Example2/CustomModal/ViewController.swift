//
//  ViewController.swift
//  CustomModal
//
//  Created by Roman Dobynda on 18/02/2019.
//  Copyright © 2019 roman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBAction func buttonDidTapped(_ sender: UIButton? = nil) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ModalViewController")
            as? ModalViewController else {
                return
        }
        present(vc, animated: true, completion: nil)
    }

}
