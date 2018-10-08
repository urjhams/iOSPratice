//
//  ViewController.swift
//  NIBFileUIView
//
//  Created by Quân Đinh on 08.10.18.
//  Copyright © 2018 urjhams. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customView = CustomView().loadNib()     // as! CustomView will cause error that cannot cast type
        
        // set class to avoid the error "cannot cast type from UIView to CustomView"
        object_setClass(customView, CustomView.self)
        
        customView.frame = view.frame
        customView.backgroundColor = .cyan
        
        view.addSubview(customView)
    }


}

