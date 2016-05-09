//
//  SnapViewController.swift
//  UIDynamics
//
//  Created by Art on 5/9/16.
//  Copyright © 2016 Art. All rights reserved.
//

import UIKit

class SnapViewController: UIViewController {

    @IBOutlet weak var squareView: UIImageView!
    
    var snap: UISnapBehavior!
    var animator: UIDynamicAnimator!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: view)
    }
    
    @IBAction func handleTap(sender: UITapGestureRecognizer) {
        
        let tapPoint: CGPoint = sender.locationInView(view)
        
        if (snap != nil) {
            animator.removeBehavior(snap)
        }
        
        snap = UISnapBehavior(item: squareView, snapToPoint: tapPoint)
        animator.addBehavior(snap)
    }

}
