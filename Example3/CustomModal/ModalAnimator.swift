//
//  ModalPresentAnimationController.swift
//  CustomModal
//
//  Created by Roman Dobynda on 19/02/2019.
//  Copyright © 2019 roman. All rights reserved.
//

import UIKit

extension UIView {
    // Replacement of `snapshotView` on iOS 10.
    // Fixes the issue of `snapshotView` returning a blank white screen.
    func snapshotImageView() -> UIImageView? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 1)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        layer.render(in: context)
        let viewImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return UIImageView(image: viewImage, highlightedImage: viewImage)
    }
}

final class ModalAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    var isPresenting: Bool
    
    let duration: TimeInterval = 3
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?)
        -> TimeInterval {
            return duration
    }
    

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let fromView = fromVC.view,
            let toVC = transitionContext.viewController(forKey: .to),
            let toView = toVC.view
            else {
                return
        }
        
        let duration = transitionDuration(using: transitionContext)
        let containerView = transitionContext.containerView
        
        containerView.addSubview(toView)
        
        fromView.isHidden = false
        let fromSnapshot = fromView.snapshotImageView()!
        
        toView.isHidden = false
        let toSnapshot = toView.snapshotImageView()!
        if isPresenting {
            toSnapshot.frame.origin.x = containerView.frame.width
        } else {
            toSnapshot.frame.origin.x = -(containerView.frame.width / 2)
        }
        
        if isPresenting {
            containerView.addSubview(fromSnapshot)
            containerView.addSubview(toSnapshot)
        } else {
            containerView.addSubview(toSnapshot)
            containerView.addSubview(fromSnapshot)
        }
        
        fromView.isHidden = true
        toView.isHidden = true
        
        UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseInOut], animations: {
            [unowned self] in
            if self.isPresenting {
                fromSnapshot.frame.origin.x = -(containerView.frame.width / 2.0)
            } else {
                fromSnapshot.frame.origin.x = containerView.frame.width
            }
            toSnapshot.frame.origin.x = 0
        }) { _ in
            toView.isHidden = false
            fromSnapshot.removeFromSuperview()
            toSnapshot.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }

}
