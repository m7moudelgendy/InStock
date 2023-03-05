//
//  helper.swift
//  InStock
//
//  Created by Hader on 5/3/23.
//

import Foundation
import UIKit
class  Helper {
    

     
        func addWaveBackground(to view: UIView){
            let leftDrop:CGFloat = 0.4
            let rightDrop: CGFloat = 0.3
            let leftInflexionX: CGFloat = 0.4
            let leftInflexionY: CGFloat = 0.47
            let rightInflexionX: CGFloat = 0.6
            let rightInflexionY: CGFloat = 0.22
            
          
            let backLayer = CAShapeLayer()
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x:0, y: view.frame.height * leftDrop))
            path.addCurve(to: CGPoint(x:view.frame.width, y: view.frame.height * rightDrop),
                          controlPoint1: CGPoint(x: view.frame.width * leftInflexionX, y: view.frame.height * leftInflexionY),
                          controlPoint2: CGPoint(x: view.frame.width * rightInflexionX, y: view.frame.height * rightInflexionY))
            path.addLine(to: CGPoint(x:view.frame.width, y: 0))
            path.close()
            backLayer.fillColor = #colorLiteral(red: 0.568627451, green: 0.1921568627, blue: 0.4588235294, alpha: 1)
            backLayer.path = path.cgPath
            view.layer.addSublayer(backLayer)
          //  backLayer.addSublayer(imageView)
            
        }
    }
