//
//  HelpView.swift
//  MSC
//
//  Created by Đinh Quân on 12/2/17.
//  Copyright © 2017 MP ITO. All rights reserved.
//

import UIKit

//----------- just create an instace, set the frame and use addSubView function
class HelpView: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var botImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    private func nibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        addSubview(view)
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "HelpView", bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
    }
    
}
