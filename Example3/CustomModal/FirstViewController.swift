//
//  ViewController.swift
//  CustomModal
//
//  Created by Roman Dobynda on 18/02/2019.
//  Copyright © 2019 roman. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.delegate = self
    }
    
    @IBAction func nextDidTapped(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else {
            return
        }
        vc.view.backgroundColor = .red
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension FirstViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
            return ModalAnimator(isPresenting: operation == .push)
    }
}
