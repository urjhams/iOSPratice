//
//  ViewController.swift
//  lottiePlayground
//
//  Created by Quân Đinh on 24.10.18.
//  Copyright © 2018 urjhams. All rights reserved.
//

import UIKit
import Lottie

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let animationView = LOTAnimationView(name: "servishero_loading")
        animationView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        animationView.center = view.center
        
        animationView.contentMode = .scaleAspectFill
        animationView.loopAnimation = true
        animationView.animationSpeed = 0.9
        
        let minimizeTransform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        animationView.transform = minimizeTransform
        UIView.animate(withDuration: 3.0, delay: 0.0, options: [.repeat, .autoreverse], animations: {
            animationView.transform = CGAffineTransform.identity
        }, completion: nil)
        
        view.addSubview(animationView)
        animationView.play()
    }


}

