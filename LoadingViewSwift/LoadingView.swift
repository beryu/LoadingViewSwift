//
//  LoadingView.swift
//  LoadingViewSwift
//
//  Created by beryu on 2015/05/07.
//  Copyright (c) 2015年 blk. All rights reserved.
//

import UIKit

public class LoadingView: UIView {

    @IBOutlet weak var hudView: UIView?
    @IBOutlet weak var hudContainerView: UIView?
    @IBOutlet weak var backgroundView: UIView?
    @IBOutlet weak var messageLabel: UILabel?
    private static let _sharedView = LoadingView()
    var isRotation = true

    public static func sharedView() -> LoadingView {
        return _sharedView;
    }

    public func showInView(view: UIView, withAnimated: Bool) {
        self.showInView(view, message: nil, animated: true)
    }

    public func showInView(view: UIView, message: String?, animated: Bool) {
        if self.superview != view {
            view.addSubview(self)
        }

        self.messageLabel?.text = message;
        self.hudContainerView?.transform = CGAffineTransformIdentity;

        if (self.isRotation) {
            var anim = CABasicAnimation(keyPath: "transform")
            anim.fromValue = 0.0
            anim.toValue = 2 * M_PI
            anim.valueFunction = CAValueFunction(name: kCAValueFunctionRotateZ)
            anim.duration = 1
            anim.repeatCount = Float.infinity

            self.hudView?.layer.addAnimation(anim, forKey: nil)
        }

        if (animated) {
            self.hudContainerView?.transform = CGAffineTransformScale(self.hudContainerView!.transform, 2, 2);

            UIView.animateWithDuration(0.15,
                    delay: 0,
                    options: .CurveEaseInOut,
                    animations: {
                        () in
                        self.hudContainerView?.transform = CGAffineTransformScale(self.hudContainerView!.transform, 0.5, 0.5);
                        self.hudContainerView?.alpha = 1;
                        self.backgroundView?.alpha = 1;
                    },
                    completion: {
                        finished in
                        self.setNeedsLayout()
                    }
            )

            self.setNeedsDisplay()
        } else {
            self.hudContainerView?.transform = CGAffineTransformIdentity;
            self.hudContainerView?.alpha = 1;
            self.backgroundView?.alpha = 1;
            self.setNeedsLayout()
        }

    }

    public func dismissWithAnimated(animated: Bool) {
        if (animated) {
            UIView.animateWithDuration(0.15,
                    delay: 0,
                    options: .CurveEaseInOut,
                    animations: {
                        () in
                        self.hudContainerView?.transform = CGAffineTransformScale(self.hudContainerView!.transform, 0.5, 0.5);
                        self.hudContainerView?.alpha = 0;
                        self.backgroundView?.alpha = 0;
                    },
                    completion: {
                        finished in
                        if (self.isRotation) {
                            self.hudView?.layer.removeAllAnimations()
                        }
                        self.removeFromSuperview()
                        self.setNeedsLayout()
                    }
            )

            self.setNeedsDisplay()
        } else {
            self.hudContainerView?.transform = CGAffineTransformIdentity;
            self.hudContainerView?.alpha = 0;
            self.backgroundView?.alpha = 0;
            self.hudView?.layer.removeAllAnimations()
            self.removeFromSuperview()
            self.setNeedsLayout()
        }
    }

    public func replaceHudView(hudView:UIView!) {
        if let subviews = self.hudContainerView?.subviews as? [UIView] {
            for subview in subviews {
                subview.removeFromSuperview()
            }
        }

        self.hudView = hudView
        self.hudView!.frame = self.hudContainerView!.bounds
        self.hudContainerView?.addSubview(self.hudView!)
    }
}
