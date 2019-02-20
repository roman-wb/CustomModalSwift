//
//  ModalDismissAnimationController.swift
//  CustomModal
//
//  Created by Roman Dobynda on 19/02/2019.
//  Copyright © 2019 roman. All rights reserved.
//

import UIKit

final class ModalDismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    let offset: CGFloat = 60

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let fromView = fromVC.view,
            let toVC = transitionContext.viewController(forKey: .to),
            let toView = toVC.view
            else {
                return
        }

        let offset = self.offset
        let duration = transitionDuration(using: transitionContext)
        let containerView = transitionContext.containerView

        guard let fromSnapshot = fromView.snapshotView(afterScreenUpdates: true),
            let toSnapshot = containerView.subviews.first else {
                return
        }

        containerView.addSubview(fromSnapshot)
        fromView.isHidden = true
        fromSnapshot.frame = CGRect(x: 0,
                                    y: offset,
                                    width: containerView.frame.width,
                                    height: containerView.frame.height - offset)

        toView.isHidden = true

        UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseInOut], animations: {
            fromSnapshot.frame.origin.y = containerView.frame.height
            toSnapshot.layer.cornerRadius = 0
            toSnapshot.alpha = 1
            toSnapshot.transform = CGAffineTransform.identity
        }) { _ in
            if transitionContext.transitionWasCancelled {
                fromView.isHidden = false
                toView.removeFromSuperview()
            } else {
                toView.isHidden = false
                toSnapshot.removeFromSuperview()
            }
            fromSnapshot.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }

}
