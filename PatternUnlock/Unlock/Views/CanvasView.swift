import UIKit
import Combine


extension CanvasView {
	func CGPointDistanceSquared(from: CGPoint, to: CGPoint) -> CGFloat {
		return (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)
	}
}

final class CanvasView: UIView {

	private var viewModel: UnLockPatternViewModel
	private var cancellables = Set<AnyCancellable>()

	private var trackPoint: CGPoint?
	private var dotViews = [UIView]()


	private var needsRedraw: Bool = false {
		didSet {
			if needsRedraw {
				setNeedsDisplay()
			}
		}
	}

	init(frame: CGRect = .zero, viewModel: UnLockPatternViewModel) {
		self.viewModel = viewModel
		super.init(frame: frame)
//		bind(to: viewModel)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


	override func draw(_ rect: CGRect) {

		super.draw(rect)
		guard let context = UIGraphicsGetCurrentContext() else {
			return
		}

		guard let trackPoint = trackPoint else { return }

		for (i, dot) in dotViews.enumerated() {

			if i == 0 {
				context.move(to: dot.center)
			} else {
				context.addLine(to: dot.center)
			}
		}

		context.addLine(to: trackPoint)

		context.setStrokeColor(UIColor.black.cgColor)
		context.setLineWidth(10.0)

		context.setLineCap(.round)
		context.strokePath()

		self.trackPoint = nil
	}

	private func clearDotViews() {
		for dotView in dotViews {
			guard let imageView = dotView as? DotView else {
				return
			}
			imageView.isHighlighted = false
		}

		dotViews.removeAll()

		setNeedsDisplay()
	}

	private func addDotView(_ view: DotView) {

		guard dotViews.contains(view) == false else {
			return
		}

		guard dotViews.count < 8 else {
			return
		}

		if let last = dotViews.last, last != view {
			let distance = CGPointDistanceSquared(from: view.center, to: last.center)

			let surface = frame.height * frame.width

			guard distance <= surface/2 else {
				return
			}
		}

		viewModel.addDot(identifier: view.identifier)
		dotViews.append(view)
		view.isHighlighted = true
	}

	func drawLineFromLastDot(to point: CGPoint) {
		self.trackPoint = point

		setNeedsDisplay()
	}
}

extension CanvasView {

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		clearDotViews()
		viewModel.didStartDrawing()
	}

	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let point = touches.first?.location(in: self) else {
			return
		}

		guard let touched = hitTest(point, with: event) else {
			return
		}

		if let dotView = touched as? DotView {
			addDotView(dotView)
		}
		drawLineFromLastDot(to: point)
	}

	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		
		clearDotViews()
		viewModel.didFinishDrawing()
	}
}
