//
//  ViewController.swift
//  UIDynamics
//
//  Created by Art on 5/9/16.
//  Copyright © 2016 Art. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var squareView: UIView!
    
    // 1
    var gravity: UIGravityBehavior!
    var animator: UIDynamicAnimator!
    
    // 3
    var collision: UICollisionBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 2
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [squareView])
        animator.addBehavior(gravity)
        
        
        // 4
        collision = UICollisionBehavior(items: [squareView])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        // 5
//        collision.addBoundaryWithIdentifier("barrier", fromPoint: CGPointMake(self.view.frame.origin.x, 350), toPoint: CGPointMake(self.view.frame.origin.x + self.view.frame.width, 350))
    }
    
}

