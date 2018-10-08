//
//  NibView.swift
//  NIBFileUIView
//
//  Created by Quân Đinh on 08.10.18.
//  Copyright © 2018 urjhams. All rights reserved.
//

import UIKit

class NibView: UIView {
    
    var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.xibSetUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.xibSetUp()
    }
}

private extension NibView {
    /// Set up the view from xib file
    func xibSetUp() {
        backgroundColor = .clear
        self.view = loadNib()
        self.view.frame = bounds
        addSubview(self.view)
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView" : self.view]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView" : self.view]))
    }
}

extension UIView {
    /// Load instance from nib with the same name
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}
