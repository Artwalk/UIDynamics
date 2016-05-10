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
    
    @IBOutlet weak var cheers: UIImageView!
    @IBOutlet weak var oyster: UIImageView!
    @IBOutlet weak var meican: UIImageView!
    
    
    var attachment: UIAttachmentBehavior!
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    
    override func viewDidLoad() {
        let icons = [meican, oyster, cheers]
        
        animator = UIDynamicAnimator(referenceView: view)
        
        
        let b = UIDynamicItemBehavior()
        b.friction = 0
        b.resistance = 0
        b.addItem(cheers)
        b.addItem(meican)
        b.addItem(oyster)
        animator.addBehavior(b)
        
        for v in icons {
            attachment = UIAttachmentBehavior(item: v, attachedToAnchor: CGPointMake(anchorView.center.x, anchorView.center.y))
            animator.addBehavior(attachment)
            
            let instantaneousPush: UIPushBehavior = UIPushBehavior(items: [v], mode: UIPushBehaviorMode.Instantaneous)
            
            instantaneousPush.setAngle( -CGFloat(M_PI_2) , magnitude:
                2)
            animator.addBehavior(instantaneousPush)
        }
        
        performSelector(#selector(AttachViewController.remove(_:)), withObject: cheers, afterDelay: 5)
        
        performSelector(#selector(AttachViewController.remove(_:)), withObject: oyster, afterDelay: 7)
    }
    
    func remove(v:UIView) {
        v.removeFromSuperview()
    }
    
    @IBAction func handlePan(sender: UIPanGestureRecognizer) {
        attachment.anchorPoint = sender.locationInView(view)
        anchorView.center = sender.locationInView(view)
    }

}