//
//  ViewController.swift
//  ParallaxEffect
//
//  Created by Quân Đinh on 03.11.18.
//  Copyright © 2018 urjhams. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var backGroundView: UIImageView!
    var iconView: UIImageView!
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initbackgroundView()
        initIconView()
        applyMotionEffect(to: backGroundView, magnitude: 20)
        applyMotionEffect(to: iconView, magnitude: -20)
    }
}

extension ViewController {
    private func initbackgroundView() {
        let currentFrame = view.frame
        backGroundView = UIImageView(frame: currentFrame)
        backGroundView.image = #imageLiteral(resourceName: "BackGround")
        backGroundView.contentMode = .center
        view.addSubview(backGroundView)
    }
    
    private func initIconView() {
        let currentFrame = view.frame
        let lengthOfEdge: CGFloat = 100
        let originX = currentFrame.size.width / 2 - lengthOfEdge / 2
        let originY = currentFrame.size.height / 2 - lengthOfEdge / 2
        iconView = UIImageView(frame: CGRect(x: originX, y: originY, width: lengthOfEdge, height: lengthOfEdge))
        iconView.image = #imageLiteral(resourceName: "icon")
        iconView.contentMode = .scaleAspectFit
        view.addSubview(iconView)
    }
    
    func applyMotionEffect(to view: UIView, magnitude: Float) {
        let xMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        xMotion.maximumRelativeValue = magnitude
        xMotion.minimumRelativeValue = -magnitude
        
        let yMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        yMotion.maximumRelativeValue = magnitude
        yMotion.minimumRelativeValue = -magnitude
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [xMotion, yMotion]
        
        view.addMotionEffect(group)
    }
}

