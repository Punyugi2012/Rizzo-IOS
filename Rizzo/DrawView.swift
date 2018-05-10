//
//  DrawView.swift
//  DrawingApp
//
//  Created by punyawee  on 2/5/61.
//  Copyright © พ.ศ. 2561 punyawee . All rights reserved.
//

import UIKit

struct Stroke {
    var startPoint: CGPoint
    var lastPoint: CGPoint
    var color: CGColor
    var mark: Bool
    var strokeWidth: CGFloat
}

class DrawView: UIView {
    
    var lastPoint: CGPoint!
    var currentStrockColor = UIColor.black.cgColor
    var currentWidth: CGFloat!
    var strokes: [Stroke] = []
    var isDrawing = false
    var isUndo = false
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !isDrawing else {return}
        isDrawing = true
        guard let touch = touches.first else {return}
        let currentPoint = touch.location(in: self)
        strokes.append(Stroke(startPoint: currentPoint, lastPoint: currentPoint, color: currentStrockColor, mark: true, strokeWidth: currentWidth))
        lastPoint = currentPoint
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawing else {return}
        guard let touch = touches.first else {return}
        let currentPoint = touch.location(in: self)
        strokes.append(Stroke(startPoint: lastPoint, lastPoint: currentPoint, color: currentStrockColor, mark: false, strokeWidth: currentWidth))
        lastPoint = currentPoint
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDrawing else {return}
        isDrawing = false
        guard let touch = touches.first else {return}
        let currentPoint = touch.location(in: self)
        strokes.append(Stroke(startPoint: lastPoint, lastPoint: currentPoint, color: currentStrockColor, mark: false, strokeWidth: currentWidth))
        lastPoint = nil
        self.setNeedsDisplay()
    
//        for stroke in self.strokes {
//            print("\(stroke.lastPoint.x) \(stroke.lastPoint.y)")
//            print("------------------------------")
//        }
        
//        for point in self.points {
//            print("\(point.x) \(point.y)")
//            print("-----------------")
//        }
        
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineCap(.round)
        if isUndo {
            while !strokes.isEmpty {
                context?.setLineWidth(strokes.last!.strokeWidth)
                context?.beginPath()
                context?.move(to: strokes.last!.startPoint)
                context?.addLine(to: strokes.last!.lastPoint)
                context?.setStrokeColor((self.backgroundColor?.cgColor)!)
                context?.strokePath()
                if strokes.last!.mark {
                    strokes.removeLast()
                    break
                }
                strokes.removeLast()
            }
            isUndo = false
        }
        for stroke in strokes {
            context?.setLineWidth(stroke.strokeWidth)
            context?.beginPath()
            context?.move(to: stroke.startPoint)
            context?.addLine(to: stroke.lastPoint)
            context?.setStrokeColor(stroke.color)
            context?.strokePath()
        }
    }
    
    func clearDraw() {
        strokes = []
        self.setNeedsDisplay()
    }
    
    func undo() {
        isUndo = true
        self.setNeedsDisplay()
    }
  
}

extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: image!.cgImage!)
    }
}
