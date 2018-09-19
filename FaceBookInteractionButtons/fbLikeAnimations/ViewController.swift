//
//  ViewController.swift
//  fbLikeAnimations
//
//  Created by Quân Đinh on 9/19/18.
//  Copyright © 2018 urjhams. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // - MARK: set up
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "6sBg"))
        return imageView
    }()
    
    let iconContainerView: UIView = {
        
        let containerView = UIView()
        containerView.backgroundColor = .white
        
        // configuration option values
        let iconHeight: CGFloat = 36
        let padding: CGFloat = 6
        
        let images = [#imageLiteral(resourceName: "blue_like"), #imageLiteral(resourceName: "red_heart"), #imageLiteral(resourceName: "cry_laugh"), #imageLiteral(resourceName: "surprised"), #imageLiteral(resourceName: "cry"), #imageLiteral(resourceName: "angry")]
        let arrangedSubviews = images.map({ (image) -> UIView in
            let view = UIImageView(image: image)
            view.layer.cornerRadius = iconHeight / 2
            view.isUserInteractionEnabled = true
            return view
        })
        
        // Create stack view
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.distribution = .fillEqually
        
        // Margins of stack view
        stackView.spacing = padding
        stackView.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        stackView.isLayoutMarginsRelativeArrangement = true // set true to active the layout through layoutMargins
        
        // set frame for container view and add stack view inside it
        containerView.addSubview(stackView)
        let numberOfIcons = CGFloat(arrangedSubviews.count)
        containerView.frame = CGRect(x: 0, y: 0,
                                     width: iconHeight * numberOfIcons + padding * (numberOfIcons + 1),
                                     height: iconHeight + padding * 2)
        containerView.layer.cornerRadius = containerView.frame.height / 2
        stackView.frame = containerView.frame
        
        //Shadow
        containerView.layer.shadowColor = UIColor(white: 0.4, alpha: 0.4).cgColor
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowRadius = 8
        containerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        return containerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(backgroundImageView)
        backgroundImageView.frame = self.view.frame
        setupLongGesture()
    }
}

extension ViewController {
    // - MARK: Custom functions
    fileprivate func setupLongGesture() {
        self.view.addGestureRecognizer(UILongPressGestureRecognizer(target: self,
                                                                    action: #selector(handleLongPress(gesture:))))
    }
    
    @objc fileprivate func handleLongPress(gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            handleGestureBegan(gesture: gesture)
        case .changed:
            handleGestureChanged(gesture: gesture)
        case .ended:
            
            // clean up animations
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
                // knew definitely the first element of iconContainerView is stack view, and then image views above
                if let stackview = self?.iconContainerView.subviews.first {
                    
                    stackview.subviews.forEach({ (imageView) in
                        imageView.transform = .identity
                    })
                }
                if let strongSelf = self {
                    strongSelf.iconContainerView.transform = strongSelf.iconContainerView.transform.translatedBy(x: 0, y: strongSelf.iconContainerView.frame.height)
                    strongSelf.iconContainerView.alpha = 0
                }
                
            }) { [weak self] (_) in
                self?.iconContainerView.removeFromSuperview()
            }
        default:
            break
        }
    }
    
    fileprivate func handleGestureChanged(gesture: UILongPressGestureRecognizer) {
        let pressedLocation = gesture.location(in: self.iconContainerView)
        
        let fixedPressedLocation = CGPoint(x: pressedLocation.x, y: self.iconContainerView.frame.height / 2)
        
        // Return the farthest view above of others view in view hierachy
        let hitTestView = iconContainerView.hitTest(fixedPressedLocation, with: nil)
        
        if hitTestView is UIImageView {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
                
                // knew definitely the first element of iconContainerView is stack view, and then image views above
                if let stackview = self?.iconContainerView.subviews.first {
                    stackview.subviews.forEach({ (imageView) in
                        imageView.transform = .identity
                    })
                }
                hitTestView?.transform = CGAffineTransform(translationX: 0, y: -24)
            })
        }
    }
    
    fileprivate func handleGestureBegan(gesture: UILongPressGestureRecognizer) {
        view.addSubview(iconContainerView)
        
        let pressLocation = gesture.location(in: self.view)
        
        let centeredX = (view.frame.width - iconContainerView.frame.width) / 2
        iconContainerView.alpha = 0
        
        // transform to begin location of container box
        self.iconContainerView.transform = CGAffineTransform(translationX: centeredX,
                                                             y: pressLocation.y)
        
        // hàm animate này cho phép tăng tốc (accelerate) và giảm tốc (deaccelerate)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [weak self] in
                        
            self?.iconContainerView.alpha = 1
                        
            // final position of container box
            self?.iconContainerView.transform = CGAffineTransform(translationX: centeredX, y: pressLocation.y - (self?.iconContainerView.frame.height)!)
        })
    }

}

