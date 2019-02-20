//
//  ModalViewController.swift
//  CustomModal
//
//  Created by Roman Dobynda on 18/02/2019.
//  Copyright © 2019 roman. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {

    var interactionTransition: UIPercentDrivenInteractiveTransition!

    private var isInteractionTransition = false
    private var shouldCompleteTransition = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        transitioningDelegate = self
        interactionTransition = UIPercentDrivenInteractiveTransition()
        let gesture = UIPanGestureRecognizer(target: self,
                                             action: #selector(handleGesture(_:)))
        view.addGestureRecognizer(gesture)
        
        guard let navigationController = children.first as? UINavigationController,
            let settingsController = navigationController.children.first as? SettingsViewController
            else {
                return
        }
        
        settingsController.customModalViewController = self
    }

    @objc func handleGesture(_ gesture: UIPanGestureRecognizer) {
        guard let superview = gesture.view?.superview else {
            return
        }

        let translation = gesture.translation(in: superview)
        var progress = translation.y / superview.frame.height
        progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))

        switch gesture.state {
        case .began:
            isInteractionTransition = true
            dismiss(animated: true, completion: nil)
        case .changed:
            shouldCompleteTransition = progress > 0.5
            interactionTransition.update(progress)
        case .cancelled:
            isInteractionTransition = false
            interactionTransition.cancel()
        case .ended:
            isInteractionTransition = false
            if shouldCompleteTransition {
                interactionTransition.finish()
            } else {
                interactionTransition.cancel()
            }
        default:
            break
        }
    }
    
}

extension ModalViewController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
            return ModalPresentAnimator()
    }

    func animationController(forDismissed dismissed: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
            return ModalDismissAnimator()
    }

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning)
        -> UIViewControllerInteractiveTransitioning? {
        guard isInteractionTransition else {
            return nil
        }
        return interactionTransition
    }

}
