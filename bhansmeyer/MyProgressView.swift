import UIKit

@IBDesignable
class MyProgressView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()

        if fullCircleLayer.superlayer !== layer {
            fullCircleLayer.fillColor = nil
            fullCircleLayer.strokeColor = #colorLiteral(red: 0.7022589445, green: 0.8972243667, blue: 0.9819455743, alpha: 1).cgColor
            fullCircleLayer.lineWidth = 23
            layer.addSublayer(fullCircleLayer)

            partialCircleLayer.fillColor = nil
            partialCircleLayer.strokeColor = #colorLiteral(red: 0, green: 0.6794941425, blue: 0.8981570601, alpha: 1).cgColor
            partialCircleLayer.lineWidth = fullCircleLayer.lineWidth
            partialCircleLayer.lineCap = kCALineCapRound
            layer.addSublayer(partialCircleLayer)
        }

        let bounds = self.bounds
        if bounds.size != priorSize {
            priorSize = bounds.size
            let inset = fullCircleLayer.lineWidth / 2
            let pathBounds = bounds.insetBy(dx: inset, dy: inset)

            fullCircleLayer.path = CGPath(ellipseIn: pathBounds, transform: nil)

            let partialPath = UIBezierPath(arcCenter: .zero, radius: 0.5, startAngle: -0.5 * .pi, endAngle: .pi * 0.6, clockwise: true)
            partialPath.apply(.init(scaleX: pathBounds.width, y: pathBounds.height))
            partialPath.apply(.init(translationX: pathBounds.midX, y: pathBounds.midY))
            partialCircleLayer.path = partialPath.cgPath
        }
    }

    private let fullCircleLayer = CAShapeLayer()
    private let partialCircleLayer = CAShapeLayer()
    private var priorSize = CGSize.zero

}
