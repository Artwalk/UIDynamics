//
//  AttachViewController.swift
//  UIDynamics
//
//  Created by Art on 5/9/16.
//  Copyright © 2016 Art. All rights reserved.
//

import UIKit

class AttachViewController: UIViewController {
    
    @IBOutlet weak var anchorView: CRView!
    @IBOutlet weak var squareView: CRView!
    
    var attachment: UIAttachmentBehavior!
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    
    override func viewDidLoad() {
        
        animator = UIDynamicAnimator(referenceView: view)
        
        attachment = UIAttachmentBehavior(item: squareView, attachedToAnchor: CGPointMake(anchorView.center.x, anchorView.center.y))
        animator.addBehavior(attachment)
        
        gravity = UIGravityBehavior(items: [squareView])
        animator.addBehavior(gravity)
    }
    
    
    @IBAction func handlePan(sender: UIPanGestureRecognizer) {
        attachment.anchorPoint = sender.locationInView(view)
        anchorView.center = sender.locationInView(view)
    }

}
