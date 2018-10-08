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
        let customView = CustomView()
        customView.frame = view.frame
        view.addSubview(customView)
    }


}

