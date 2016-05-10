//
//  PushViewController.swift
//  UIDynamics
//
//  Created by Art on 5/9/16.
//  Copyright © 2016 Art. All rights reserved.
//

import UIKit

class PushViewController: UIViewController {

    @IBOutlet weak var blueSquareView: CRView!
    @IBOutlet weak var redSquareView: CRView!
    
    var animator: UIDynamicAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let continuousPush: UIPushBehavior = UIPushBehavior(items: [redSquareView], mode: UIPushBehaviorMode.Continuous)
        let instantaneousPush: UIPushBehavior = UIPushBehavior(items: [blueSquareView], mode: UIPushBehaviorMode.Instantaneous)
        
        continuousPush.setAngle( -CGFloat(M_PI_2) , magnitude: 1)
        instantaneousPush.setAngle( -CGFloat(M_PI_2) , magnitude: 1)
        
        animator = UIDynamicAnimator(referenceView: view)
        animator.addBehavior(continuousPush)
        animator.addBehavior(instantaneousPush)
    }

}
