//
//  TabBarControllerAnimator.swift
//  YiDaIOSSwiftPractices
//
//  Created by Mudox on 20/10/2016.
//  Copyright © 2016 Mudox. All rights reserved.
//

import UIKit

class TabBarControllerAnimator: NSObject {

}

extension TabBarControllerAnimator: UIViewControllerAnimatedTransitioning {
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.3
  }

  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

    let containerView = transitionContext.containerView
    let toView = transitionContext.view(forKey: .to)!
    let fromView = transitionContext.view(forKey: .from)!
    let toViewController = transitionContext.viewController(forKey: .to)!
    let tabIndex = toViewController.tabBarController!.viewControllers!.index(of: toViewController)!

    let onstageFrame = transitionContext.finalFrame(for: toViewController)
    let fadeAlpha: CGFloat = 0

    let spacing = containerView.bounds.width / 5
    let y = containerView.bounds.height - 24
    var fadeInPoint = CGPoint(x: spacing, y: y)

    fadeInPoint.x += spacing * CGFloat(tabIndex)
    let fadeInFrame = CGRect(origin: fadeInPoint, size: .zero)

    toView.alpha = fadeAlpha
    toView.frame = fadeInFrame
    containerView.addSubview(toView)
    containerView.backgroundColor = toView.backgroundColor

    UIView.animate(withDuration: transitionDuration(using: transitionContext),
                   delay: 0,
                   options: [.curveEaseIn],
                   animations: {
        toView.alpha = 1
        toView.frame = onstageFrame
      },
                   completion: {
        fromView.transform = .identity
        transitionContext.completeTransition($0)
    })
  }
}
