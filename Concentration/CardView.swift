//
//  CardView.swift
//  Set
//
//  Created by Cole Turner on 1/18/18.
//  Copyright © 2018 Cole Turner. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    var shape: String = "oval" { didSet { setNeedsDisplay(); setNeedsLayout() }}
//
    var number: Int = 2 { didSet { setNeedsDisplay(); setNeedsLayout() }}

    var color: String = "green"
    
    var cardAlpha: CGFloat = 1.0
    
    var selected = false
    var isFaceUp = false
    var partOfSet = false
    var borderSelect = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        setBasicLayoutForBorder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.clipsToBounds = true
        setBasicLayoutForBorder()
    }
    
    private func setBasicLayoutForBorder () {
        layer.borderWidth = LayOutMetricsForCardView.borderWidth
        layer.borderColor = LayOutMetricsForCardView.borderColor
        layer.cornerRadius = LayOutMetricsForCardView.cornerRadius
    }
    
    //this draws the card with the correct drawing on it
    override func draw(_ rect: CGRect) {
        
        var cardColor: UIColor = UIColor.purple
        var lineColor: UIColor = UIColor.black
        if color == "blue" {
            cardColor = UIColor(red:0.0, green:0.0, blue:1.0, alpha:cardAlpha)
            lineColor = UIColor(red:0.0, green:0.0, blue:1.0, alpha:1.0)
        } else if color == "red" {
            cardColor = UIColor(red:1.0, green:0.0, blue:0.0, alpha:cardAlpha)
            lineColor = UIColor(red:1.0, green:0.0, blue:0.0, alpha:1.0)
        } else if color == "green" {
            cardColor = UIColor(red:0.0, green:1.0, blue:0.0, alpha:cardAlpha)
            lineColor = UIColor(red:0.0, green:1.0, blue:0.0, alpha:1.0)
        }
        
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius:cornerRadius)
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
        
        
        //oval
        if (shape == "oval") {
            if number == 1 {
                let path = UIBezierPath()
                path.addArc(withCenter: CGPoint(x: bounds.midX - bounds.midX/2, y: bounds.midY), radius: radius, startAngle: 3*CGFloat.pi/2, endAngle: CGFloat.pi/2, clockwise: false)
                path.addArc(withCenter: CGPoint(x: bounds.midX + bounds.midX/2, y: bounds.midY), radius: radius, startAngle: CGFloat.pi/2, endAngle: 3*CGFloat.pi/2, clockwise: false)
                path.lineWidth = 5.0
                path.close()
                cardColor.setFill()
                lineColor.setStroke()
                path.stroke()
                path.fill()
                
            } else if number == 2 {
                
                let thirdPath = UIBezierPath()
                thirdPath.addArc(withCenter: CGPoint(x: bounds.midX - bounds.midX/2, y: bounds.midY - radius*3), radius: radius, startAngle: 3*CGFloat.pi/2, endAngle: CGFloat.pi/2, clockwise: false)
                
                thirdPath.addArc(withCenter: CGPoint(x: bounds.midX + bounds.midX/2, y: bounds.midY - radius*3), radius: radius, startAngle: CGFloat.pi/2, endAngle: 3*CGFloat.pi/2, clockwise: false)
                thirdPath.lineWidth = 5.0
                thirdPath.close()
                cardColor.setFill()
                lineColor.setStroke()
                thirdPath.stroke()
                thirdPath.fill()
                
                let secondPath = UIBezierPath()
                secondPath.addArc(withCenter: CGPoint(x: bounds.midX - bounds.midX/2, y: bounds.midY + radius*3), radius: radius, startAngle: 3*CGFloat.pi/2, endAngle: CGFloat.pi/2, clockwise: false)
                secondPath.addArc(withCenter: CGPoint(x: bounds.midX + bounds.midX/2, y: bounds.midY + radius*3), radius: radius, startAngle: CGFloat.pi/2, endAngle: 3*CGFloat.pi/2, clockwise: false)
                secondPath.lineWidth = 5.0
                secondPath.close()
                cardColor.setFill()
                lineColor.setStroke()
                secondPath.stroke()
                secondPath.fill()
                
            } else if number == 3 {
                
                let path = UIBezierPath()
                path.addArc(withCenter: CGPoint(x: bounds.midX - bounds.midX/2, y: bounds.midY), radius: radius, startAngle: 3*CGFloat.pi/2, endAngle: CGFloat.pi/2, clockwise: false)
                path.addArc(withCenter: CGPoint(x: bounds.midX + bounds.midX/2, y: bounds.midY), radius: radius, startAngle: CGFloat.pi/2, endAngle: 3*CGFloat.pi/2, clockwise: false)
                path.lineWidth = 5.0
                path.close()
                cardColor.setFill()
                lineColor.setStroke()
                path.stroke()
                path.fill()
                path.addArc(withCenter: CGPoint(x: bounds.midX - bounds.midX/2, y: bounds.midY), radius: radius, startAngle: 3*CGFloat.pi/2, endAngle: CGFloat.pi/2, clockwise: false)
    
                let secondPath = UIBezierPath()
                secondPath.addArc(withCenter: CGPoint(x: bounds.midX - bounds.midX/2, y: bounds.midY + radius*3), radius: radius, startAngle: 3*CGFloat.pi/2, endAngle: CGFloat.pi/2, clockwise: false)
    
                secondPath.addArc(withCenter: CGPoint(x: bounds.midX + bounds.midX/2, y: bounds.midY + radius*3), radius: radius, startAngle: CGFloat.pi/2, endAngle: 3*CGFloat.pi/2, clockwise: false)
                secondPath.lineWidth = 5.0
                secondPath.close()
                cardColor.setFill()
                lineColor.setStroke()
                secondPath.stroke()
                secondPath.fill()
    
                let thirdPath = UIBezierPath()
                thirdPath.addArc(withCenter: CGPoint(x: bounds.midX - bounds.midX/2, y: bounds.midY - radius*3), radius: radius, startAngle: 3*CGFloat.pi/2, endAngle: CGFloat.pi/2, clockwise: false)
    
                thirdPath.addArc(withCenter: CGPoint(x: bounds.midX + bounds.midX/2, y: bounds.midY - radius*3), radius: radius, startAngle: CGFloat.pi/2, endAngle: 3*CGFloat.pi/2, clockwise: false)
                thirdPath.lineWidth = 5.0
                thirdPath.close()
                cardColor.setFill()
                lineColor.setStroke()
                thirdPath.stroke()
                thirdPath.fill()
                
            } else {
                print("there should be ovals but that is not happenning with an issue in numbers")
            }
            //diamond
        } else if shape == "diamond" {
            if number == 1 {
                
                let path = UIBezierPath()
                path.move(to: CGPoint(x: bounds.midX - bounds.midX/2 - radius, y: bounds.midY))
                path.addLine(to: CGPoint(x: bounds.midX, y: bounds.midY - radius))
                path.addLine(to: CGPoint(x: bounds.midX + bounds.midX/2 + radius, y:bounds.midY))
                path.addLine(to: CGPoint(x: bounds.midX, y: bounds.midY + radius))
                path.close()
    
                path.lineWidth = 5.0
                cardColor.setFill()
                lineColor.setStroke()
                path.stroke()
                path.fill()
                
            } else if number == 2 {
                
                let path = UIBezierPath()
                path.move(to: CGPoint(x: bounds.midX - bounds.midX/2 - radius, y: bounds.midY + radius*3))
                path.addLine(to: CGPoint(x: bounds.midX, y: bounds.midY - radius + radius*3))
                path.addLine(to: CGPoint(x: bounds.midX + bounds.midX/2 + radius, y:bounds.midY + radius*3))
                path.addLine(to: CGPoint(x: bounds.midX, y: bounds.midY + radius + radius*3))
                path.close()
    
                path.lineWidth = 5.0
                cardColor.setFill()
                lineColor.setStroke()
                path.stroke()
                path.fill()
    
                let thirdPath = UIBezierPath()
                thirdPath.move(to: CGPoint(x: bounds.midX - bounds.midX/2 - radius, y: bounds.midY - radius*3))
                thirdPath.addLine(to: CGPoint(x: bounds.midX, y: bounds.midY - radius - radius*3))
                thirdPath.addLine(to: CGPoint(x: bounds.midX + bounds.midX/2 + radius, y:bounds.midY - radius*3))
                thirdPath.addLine(to: CGPoint(x: bounds.midX, y: bounds.midY + radius - radius*3))
                thirdPath.close()
    
                thirdPath.lineWidth = 5.0
                cardColor.setFill()
                lineColor.setStroke()
                thirdPath.stroke()
                thirdPath.fill()
                
            } else if number == 3 {
                
                let path = UIBezierPath()
                path.move(to: CGPoint(x: bounds.midX - bounds.midX/2 - radius, y: bounds.midY + radius*3))
                path.addLine(to: CGPoint(x: bounds.midX, y: bounds.midY - radius + radius*3))
                path.addLine(to: CGPoint(x: bounds.midX + bounds.midX/2 + radius, y:bounds.midY + radius*3))
                path.addLine(to: CGPoint(x: bounds.midX, y: bounds.midY + radius + radius*3))
                path.close()
    
                path.lineWidth = 5.0
                cardColor.setFill()
                lineColor.setStroke()
                path.stroke()
                path.fill()
    
                let secondPath = UIBezierPath()
                secondPath.move(to: CGPoint(x: bounds.midX - bounds.midX/2 - radius, y: bounds.midY))
                secondPath.addLine(to: CGPoint(x: bounds.midX, y: bounds.midY - radius))
                secondPath.addLine(to: CGPoint(x: bounds.midX + bounds.midX/2 + radius, y:bounds.midY))
                secondPath.addLine(to: CGPoint(x: bounds.midX, y: bounds.midY + radius))
                secondPath.close()
    
                secondPath.lineWidth = 5.0
                cardColor.setFill()
                lineColor.setStroke()
                secondPath.stroke()
                secondPath.fill()
    
                let thirdPath = UIBezierPath()
                thirdPath.move(to: CGPoint(x: bounds.midX - bounds.midX/2 - radius, y: bounds.midY - radius*3))
                thirdPath.addLine(to: CGPoint(x: bounds.midX, y: bounds.midY - radius - radius*3))
                thirdPath.addLine(to: CGPoint(x: bounds.midX + bounds.midX/2 + radius, y:bounds.midY - radius*3))
                thirdPath.addLine(to: CGPoint(x: bounds.midX, y: bounds.midY + radius - radius*3))
                thirdPath.close()
    
                thirdPath.lineWidth = 5.0
                cardColor.setFill()
                lineColor.setStroke()
                thirdPath.stroke()
                thirdPath.fill()
                
            } else {
                print("there should be diamonds but something is broken with numbers")
            }
            
            //squiggle
        } else if shape == "squiggle" {
            if number == 1 {
                
                let path = UIBezierPath()
                path.addArc(withCenter: CGPoint(x: bounds.midX - bounds.midX/2, y: bounds.midY - radius/2), radius: radius, startAngle: 0, endAngle: CGFloat.pi/2, clockwise: false)
                path.addArc(withCenter: CGPoint(x: bounds.midX + bounds.midX/2, y: bounds.midY + radius - radius/2), radius: radius, startAngle: CGFloat.pi, endAngle: 3*CGFloat.pi/2, clockwise: false)
                path.lineWidth = 5.0
                path.close()
                cardColor.setFill()
                lineColor.setStroke()
                path.stroke()
                path.fill()
                
            } else if number == 2 {
                
                let secondPath = UIBezierPath()
                secondPath.addArc(withCenter: CGPoint(x: bounds.midX - bounds.midX/2, y: bounds.midY - radius*3 - radius/2), radius: radius, startAngle: 0, endAngle: CGFloat.pi/2, clockwise: false)
                secondPath.addArc(withCenter: CGPoint(x: bounds.midX + bounds.midX/2, y: bounds.midY + radius  - radius*3 - radius/2), radius: radius, startAngle: CGFloat.pi, endAngle: 3*CGFloat.pi/2, clockwise: false)
                secondPath.lineWidth = 5.0
                secondPath.close()
                cardColor.setFill()
                lineColor.setStroke()
                secondPath.stroke()
                secondPath.fill()
    
                let thirdPath = UIBezierPath()
                thirdPath.addArc(withCenter: CGPoint(x: bounds.midX - bounds.midX/2, y: bounds.midY + radius*3 - radius/2), radius: radius, startAngle: 0, endAngle: CGFloat.pi/2, clockwise: false)
                thirdPath.addArc(withCenter: CGPoint(x: bounds.midX + bounds.midX/2, y: bounds.midY + radius  + radius*3 - radius/2), radius: radius, startAngle: CGFloat.pi, endAngle: 3*CGFloat.pi/2, clockwise: false)
                thirdPath.lineWidth = 5.0
                thirdPath.close()
                cardColor.setFill()
                lineColor.setStroke()
                thirdPath.stroke()
                thirdPath.fill()
                
            } else if number == 3 {
                
                let path = UIBezierPath()
                path.addArc(withCenter: CGPoint(x: bounds.midX - bounds.midX/2, y: bounds.midY - radius/2), radius: radius, startAngle: 0, endAngle: CGFloat.pi/2, clockwise: false)
                path.addArc(withCenter: CGPoint(x: bounds.midX + bounds.midX/2, y: bounds.midY + radius - radius/2), radius: radius, startAngle: CGFloat.pi, endAngle: 3*CGFloat.pi/2, clockwise: false)
                path.lineWidth = 5.0
                path.close()
                cardColor.setFill()
                lineColor.setStroke()
                path.stroke()
                path.fill()
    
                let secondPath = UIBezierPath()
                secondPath.addArc(withCenter: CGPoint(x: bounds.midX - bounds.midX/2, y: bounds.midY - radius*3 - radius/2), radius: radius, startAngle: 0, endAngle: CGFloat.pi/2, clockwise: false)
                secondPath.addArc(withCenter: CGPoint(x: bounds.midX + bounds.midX/2, y: bounds.midY + radius  - radius*3 - radius/2), radius: radius, startAngle: CGFloat.pi, endAngle: 3*CGFloat.pi/2, clockwise: false)
                secondPath.lineWidth = 5.0
                secondPath.close()
                cardColor.setFill()
                lineColor.setStroke()
                secondPath.stroke()
                secondPath.fill()
    
                let thirdPath = UIBezierPath()
                thirdPath.addArc(withCenter: CGPoint(x: bounds.midX - bounds.midX/2, y: bounds.midY + radius*3 - radius/2), radius: radius, startAngle: 0, endAngle: CGFloat.pi/2, clockwise: false)
                thirdPath.addArc(withCenter: CGPoint(x: bounds.midX + bounds.midX/2, y: bounds.midY + radius  + radius*3 - radius/2), radius: radius, startAngle: CGFloat.pi, endAngle: 3*CGFloat.pi/2, clockwise: false)
                thirdPath.lineWidth = 5.0
                thirdPath.close()
                cardColor.setFill()
                lineColor.setStroke()
                thirdPath.stroke()
                thirdPath.fill()
            } else {
                print("there should be squigglies but something is broken with numbers")
            }
        }
    }
}

//sets up my bounds
extension CardView {
    //how to make constants
    private struct SizeRatio {
        static let radiusBounds: CGFloat = 0.10
        static let cornerFontSizeToBoundsHeight: CGFloat = 0.085
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let cornerOffsetToCornerRadius: CGFloat = 0.33
        static let faceCardImageSizeToBoundsSize: CGFloat = 0.75
    }
    private var radius: CGFloat {
        return bounds.size.height * SizeRatio.radiusBounds
    }
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    private var cornerOffset: CGFloat {
        return cornerRadius * SizeRatio.cornerOffsetToCornerRadius
    }
    private var cornerFontSize: CGFloat{
        return bounds.size.height * SizeRatio.cornerFontSizeToBoundsHeight
    }
}


extension CGRect {
    var leftHalf: CGRect {
        return CGRect(x: minX, y: minY, width: width/2, height: height)
    }

    var rightHalf: CGRect {
        return CGRect(x: midX, y: minY, width: width/2, height: height)
    }
    func inset(by size: CGSize) -> CGRect {
        return insetBy(dx: size.width, dy: size.height)
    }
    func sized(to size: CGSize) -> CGRect {
        return CGRect(origin: origin, size: size)
    }
    func zoom(by scale: CGFloat) -> CGRect {
        let newWidth = width * scale
        let newHeight = height * scale
        return insetBy(dx: (width - newWidth)/2, dy:(height - newHeight)/2)
    }
}

extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x+dx, y: y+dy)
    }
}

