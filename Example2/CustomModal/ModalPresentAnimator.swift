//
//  ModalPresentAnimationController.swift
//  CustomModal
//
//  Created by Roman Dobynda on 19/02/2019.
//  Copyright © 2019 roman. All rights reserved.
//

import UIKit

final class ModalPresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    let cornerRadius: CGFloat = 20
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

        let duration = transitionDuration(using: transitionContext)
        let containerView = transitionContext.containerView

        let fromSnapshot = fromView.snapshotView(afterScreenUpdates: true)!
        containerView.addSubview(fromSnapshot)
        fromSnapshot.layer.masksToBounds = true
        fromView.removeFromSuperview()

        containerView.addSubview(toView)
        toView.layer.cornerRadius = cornerRadius
        toView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        toView.layer.masksToBounds = true
        toView.frame = CGRect(x: 0,
                              y: offset,
                              width: containerView.frame.width,
                              height: containerView.frame.height - offset)

        guard let toSnapshot = toView.snapshotView(afterScreenUpdates: true) else {
            return
        }

        containerView.addSubview(toSnapshot)
        toSnapshot.layer.cornerRadius = cornerRadius
        toSnapshot.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        toSnapshot.layer.masksToBounds = true
        toSnapshot.frame = CGRect(x: 0,
                                  y: containerView.frame.height,
                                  width: containerView.frame.width,
                                  height: containerView.frame.height - offset)

        toView.isHidden = true

        UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseInOut], animations: {
            [unowned self] in

            fromSnapshot.layer.cornerRadius = self.cornerRadius
            fromSnapshot.alpha = 0.5
            fromSnapshot.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            toSnapshot.frame.origin.y = self.offset
        }) { _ in
            toView.isHidden = false
            toSnapshot.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }

}
