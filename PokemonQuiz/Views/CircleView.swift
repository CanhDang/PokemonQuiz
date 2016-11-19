//
//  CircleView.swift
//  PokemonQuiz
//
//  Created by Enrik on 11/17/16.
//  Copyright © 2016 Enrik. All rights reserved.
//

import UIKit

//@IBDesignable
class CircleView: UIView {
    
    @IBInspectable var angle: CGFloat = CGFloat(2*M_PI) {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var alphaColor: CGFloat = 1 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        let centerPoint = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        
        let circle = UIBezierPath(arcCenter: centerPoint, radius: self.frame.width / 2, startAngle: CGFloat(3 * M_PI / 2), endAngle: self.angle, clockwise: true)
        
        
        UIColor.white.withAlphaComponent(self.alphaColor).setFill()
        
        circle.fill()
        
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.path = circle.cgPath
//        
//        shapeLayer.fillColor = UIColor.white.withAlphaComponent(self.alphaColor).cgColor
//        
//        self.layer.addSublayer(shapeLayer)
    }

    
}
