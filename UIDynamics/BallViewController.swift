//
//  BallViewController.swift
//  UIDynamics
//
//  Created by Art on 5/10/16.
//  Copyright © 2016 Art. All rights reserved.
//

import UIKit

class Ellipse: CRView {
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return .Ellipse
    }
}

class Ball: UIImageView {
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return .Ellipse
    }
}

class BallViewController: UIViewController {

    var animator: UIDynamicAnimator?
    
    var hoopPosition: CGPoint!
    
    @IBOutlet weak var board: UIView!
    @IBOutlet weak var floor: UIView!
    
    @IBOutlet weak var hoop: CRView!
    
    @IBOutlet weak var leftHoop: Ellipse!
    @IBOutlet weak var rightHoop: Ellipse!
    
    let ball: Ball = {
        let ball = Ball(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
        ball.image = UIImage(named: "ball")
        return ball
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: self.view)
        
        ball.center = CGPoint(x: 40, y: view.frame.size.height - 100)
        view.addSubview(ball)
        view.bringSubviewToFront(hoop)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BallViewController.shoot)))
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        hoopPosition = board.frame.origin
        
        setupBehaviors()
    }

    func setupBehaviors() {
        animator?.removeAllBehaviors()
        
        let bolts = [
            CGPoint(x: hoopPosition.x + 25, y: hoopPosition.y + 85),
            CGPoint(x: hoopPosition.x + 75, y: hoopPosition.y + 85),
            CGPoint(x: hoopPosition.x + 25, y: hoopPosition.y + 85),
            CGPoint(x: hoopPosition.x + 75, y: hoopPosition.y + 85)]
        
        // Attach
        zip([hoop, hoop, leftHoop, rightHoop], bolts).forEach({
            (item, offset) in
            animator?.addBehavior(UIAttachmentBehavior.pinAttachmentWithItem(item, attachedToItem: board, attachmentAnchor: offset))
        })
        
        animator?.addBehavior({
            let attachment = UIAttachmentBehavior(item: board, attachedToAnchor: CGPoint(x: hoopPosition.x, y: hoopPosition.y))
            attachment.length = 2
            attachment.damping = 5
            return attachment
            }())
        
        // Set the density of the hoop, and fix its angle
        animator?.addBehavior({
            let behavior = UIDynamicItemBehavior(items: [leftHoop, rightHoop])
            behavior.density = 10
            behavior.allowsRotation = false
            return behavior
            }())
        
        animator?.addBehavior({
            let behavior = UIDynamicItemBehavior(items: [board])
            behavior.allowsRotation = false
            return behavior
            }())
        
        // Set the elasticity and density of the ball
        animator?.addBehavior({
            let behavior = UIDynamicItemBehavior(items: [ball])
            behavior.elasticity = 1
            behavior.density = 3
            behavior.action = {
                if !CGRectIntersectsRect(self.ball.frame, self.view.frame) {
                    self.setupBehaviors()
                    self.ball.center = CGPoint(x: 40, y: self.view.frame.size.height - 100)
                }
            }
            return behavior
            }())
        
        // Anchor the floor
        animator?.addBehavior({
            let behavior = UIDynamicItemBehavior(items: [floor])
            behavior.anchored = true
            return behavior
            }())
        
        // Collision
        animator?.addBehavior(UICollisionBehavior(items: [leftHoop, rightHoop, floor, ball]))
        
        // Gravity
        animator?.addBehavior(UIGravityBehavior(items: [ball]))
    }
    
    func shoot() {
        animator?.addBehavior(pushForPosition(CGPointZero))
    }
    
    func pushForPosition(position: CGPoint) -> UIPushBehavior {
        let push = UIPushBehavior(items: [ball], mode: .Instantaneous)
        
        push.angle = -1.35
        push.magnitude = 1.56
        return push
    }

}
