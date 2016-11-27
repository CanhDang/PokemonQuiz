//
//  CustomTransition.swift
//  PokemonQuiz
//
//  Created by Enrik on 11/24/16.
//  Copyright © 2016 Enrik. All rights reserved.
//

import UIKit

class CustomTransition: NSObject, UIViewControllerAnimatedTransitioning, CAAnimationDelegate{
    
    var isPresent = true
    var button: UIButton!
    var transitionDuration: TimeInterval!
    var transitionContext: UIViewControllerContextTransitioning?
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return self.transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        self.transitionContext = transitionContext
       
        let fromVC = transitionContext.viewController(forKey: .from)
        let toVC = transitionContext.viewController(forKey: .to)
        let container = transitionContext.containerView
            
        if isPresent {
            container.addSubview((toVC?.view)!)
        } else {
            container.addSubview((toVC?.view)!)
            container.addSubview((fromVC?.view)!)
        }
        
        let smallWidth = self.button.frame.width * 0.4
        let largeWidth = (toVC?.view.frame.height)! * 2
        
        let initialTriangleLayer = isPresent ? drawTriangle(button: self.button, width: smallWidth) : drawTriangle(button: self.button, width: largeWidth)
        let finalTriangleLayer = isPresent ? drawTriangle(button: self.button, width: largeWidth) : drawTriangle(button: self.button, width: smallWidth)
        
        var maskLayer = CAShapeLayer()
        maskLayer.path = finalTriangleLayer.path
        
        if isPresent {
            toVC?.view.layer.mask = maskLayer
            toVC?.view.layer.masksToBounds = true
        } else {
            fromVC?.view.layer.mask = maskLayer
        }
        
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = initialTriangleLayer.path
        maskLayerAnimation.toValue = finalTriangleLayer.path
        maskLayerAnimation.duration = self.transitionDuration
        maskLayerAnimation.delegate = self
        
        maskLayer.add(maskLayerAnimation, forKey: "path")
        
//        UIView.animate(withDuration: 1.0, animations: { 
//            if self.isPresented{
//                toView?.frame.origin = CGPoint(x: 0.0, y: 0.0)
//            } else {
//                fromView?.frame.origin = CGPoint(x: 0, y: -fromView!.frame.height)
//            }
//            }) { (_) in
//                
//                transitionContext.completeTransition(true)
//     
//        }
       /*
         toView.layer = tamgiac
         toViewLayermasktobound 
         
         CAShapeLayer
         layer.topath = 
         layer.conerRadius
         
         phong to tam giac
         toView.layer = nil 
         */
        
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.transitionContext?.completeTransition(!(self.transitionContext?.transitionWasCancelled)!)
        if isPresent {
            self.transitionContext?.viewController(forKey: .to)?.view.layer.mask = nil
        } else {
            self.transitionContext?.viewController(forKey: .from)?.view.layer.mask = nil
            self.transitionContext?.view(forKey: .from)?.removeFromSuperview()
        }
    }
    
    func drawTriangle(button: UIButton, width: CGFloat) -> CAShapeLayer {
        let mask = CAShapeLayer()

        let centerPoint = button.center
        
        let path = CGMutablePath()
        
        path.move(to: CGPoint(x: centerPoint.x - width/3, y: centerPoint.y - width / sqrt(3)))
        path.addLine(to: CGPoint(x: centerPoint.x + 2 * width/3, y: centerPoint.y))
        path.addLine(to: CGPoint(x: centerPoint.x - width/3, y: centerPoint.y + width/sqrt(3)))
        path.closeSubpath()
        
        mask.path = path
        
        mask.cornerRadius = 2
        
        return mask
    }

}
