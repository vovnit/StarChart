//
//  ChartMath.swift
//  StarChart
//
//  Created by Vladimir Nitochkin on 29.10.2020.
//

import UIKit

public protocol ChartMathCapable {
    
    func prepareInnerPoint(
        withChartProperties chartProperties: ChartProperties,
        verticeNumber: Int
    ) -> CGPoint
    
    func prepareOuterPoint(
        withChartProperties chartProperties: ChartProperties,
        verticeNumber: Int
    ) -> CGPoint
}

public struct ChartProperties {
    let verticesCount: Int
    let centerOffset: CGFloat
    let center: CGPoint
    let drawingSquareSide: CGFloat
}

public struct ChartMath: ChartMathCapable {
    
    public func getDelta(forCount count: Int) -> CGFloat {
        .pi / CGFloat(count)
    }
    
    public func getInnerAngle(withDelta delta: CGFloat, count: Int, verticeNumber: Int) -> CGFloat {
        delta - .pi / 2 + CGFloat(verticeNumber) * (2 * .pi / CGFloat(count))
    }
    
    public func getOuterAngle(withDelta delta: CGFloat, count: Int, verticeNumber: Int) -> CGFloat {
        delta + getInnerAngle(withDelta: delta, count: count, verticeNumber: verticeNumber)
    }
    
    public func prepareInnerPoint(withChartProperties chartProperties: ChartProperties, verticeNumber: Int) -> CGPoint {
        let delta: CGFloat = .pi / CGFloat(chartProperties.verticesCount)
        let currentAngle: CGFloat = delta - .pi / 2 + CGFloat(verticeNumber) * (2 * .pi / CGFloat(chartProperties.verticesCount))
        return CGPoint(
            x: chartProperties.center.x + chartProperties.centerOffset * cos(currentAngle),
            y: chartProperties.center.y + chartProperties.centerOffset * sin(currentAngle)
        )
    }
    
    public func prepareOuterPoint(withChartProperties chartProperties: ChartProperties, verticeNumber: Int) -> CGPoint {
        let delta: CGFloat = .pi / CGFloat(chartProperties.verticesCount)
        let currentAngle: CGFloat = 2 * delta - .pi / 2 + CGFloat(verticeNumber) * (2 * .pi / CGFloat(chartProperties.verticesCount))
        return CGPoint(
            x: chartProperties.center.x + (chartProperties.drawingSquareSide / 2) * cos(currentAngle),
            y: chartProperties.center.y + (chartProperties.drawingSquareSide / 2) * sin(currentAngle)
        )
    }
}
