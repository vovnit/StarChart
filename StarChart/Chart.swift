//
//  Chart.swift
//  StarChart
//
//  Created by Vladimir Nitochkin on 27.10.2020.
//

import UIKit

@IBDesignable open class Chart: UIView {
    
    @IBInspectable open var verticesCount: Int = 3 {
        didSet {
            drawStar()
        }
    }
    
    @IBInspectable open var centerOffset: CGFloat = 20 {
        didSet {
            drawStar()
        }
    }
    
    @IBInspectable open var fillColor: UIColor = .clear {
        didSet {
            drawStar()
        }
    }
    
    @IBInspectable lazy open var strokeColor: UIColor = tintColor {
        didSet {
            drawStar()
        }
    }
    
    @IBInspectable open var drawPoints: Bool {
        get {
            isDrawingPoints
        }
        set {
            isDrawingPoints = newValue
        }
    }
    
    private var isDrawingPoints: Bool = false {
        didSet {
            drawStar()
        }
    }
    
    private lazy var starLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        self.layer.addSublayer(layer)
        return layer
    }()
    
    open func drawStar() {
        
        var allPoints: [CGPoint] = []
        
        let isWidthBigger = bounds.width > bounds.height
        let side = isWidthBigger ? bounds.height : bounds.width
        let star = UIBezierPath()
        let startPoint = CGPoint(x: frame.width / 2, y: 0)
        let center = CGPoint(x: frame.width / 2, y: frame.height / 2)
        allPoints.append(startPoint)
        star.move(to: startPoint)
        for i in 0..<verticesCount {
            let delta: CGFloat = .pi / CGFloat(verticesCount)
            let currentAngle: CGFloat = delta - .pi / 2 + CGFloat(i) * (2 * .pi / CGFloat(verticesCount))
            let innerPoint = CGPoint(x: center.x + centerOffset * cos(currentAngle), y: center.y + centerOffset * sin(currentAngle))
            star.addLine(to: innerPoint)
            allPoints.append(innerPoint)
            
            let outerCurrentAngle: CGFloat = delta + currentAngle
            let outerPoint = CGPoint(x: center.x + (side / 2) * cos(outerCurrentAngle), y: center.y + (side / 2) * sin(outerCurrentAngle))
            star.addLine(to: outerPoint)
            allPoints.append(outerPoint)
        }
        star.close()
        star.lineWidth = 1
        
        star.fill()
        star.stroke()
        
        if isDrawingPoints {
            for point in allPoints {
                UIBezierPath(arcCenter: point, radius: 5, startAngle: 0, endAngle: 2 * .pi, clockwise: true).fill()
            }
        }
        
        starLayer.fillColor = fillColor.cgColor
        starLayer.strokeColor = strokeColor.cgColor
        starLayer.path = star.cgPath
    }
    
    func configureView() {
        backgroundColor = .clear
        drawStar()
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        configureView()
    }
    
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configureView()
        draw(frame)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
}
