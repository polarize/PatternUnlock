import UIKit
import Combine


final class CanvasView: UIView {

	private var viewModel: UnlockViewModelIO
	private var cancellables = Set<AnyCancellable>()

	private var trackPoint: CGPoint?
	private var dotViews = [CGPoint]()

	init(frame: CGRect = .zero, viewModel: UnlockViewModelIO) {
		self.viewModel = viewModel
		super.init(frame: frame)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupSubviews(with dots: [DotViewModel]) {
		for dot in dots {
			CanvasView.dotViewConstraints(in: self, dotModel: dot)
		}

		viewModel.output
			.touchedDotsPublisher
			.receive(on: DispatchQueue.main)
			.map { $0.compactMap { $0.point?.toCGPoint } }
			.assign(to: \.dotViews, on: self)
			.store(in: &cancellables)

		viewModel.output
			.trackPointPublisher
			.receive(on: DispatchQueue.main)
			.sink { point in
				if let point = point {
					self.drawLineFromLastDot(to: point.toCGPoint)
				}
			}
			.store(in: &cancellables)

		viewModel.output
			.shouldRedrawPublisher
			.receive(on: DispatchQueue.main)
			.sink { draw in
				if draw {
					self.setNeedsDisplay()
				}
			}
			.store(in: &cancellables)
	}

	override func draw(_ rect: CGRect) {

		super.draw(rect)
		guard let context = UIGraphicsGetCurrentContext() else {
			return
		}



		for (i, point) in dotViews.enumerated() {

			if i == 0 {
				context.move(to: point)
			} else {
				context.addLine(to: point)
			}
		}

		if let trackPoint = trackPoint {
			context.addLine(to: trackPoint)
		}

		context.setStrokeColor(UIColor.black.cgColor)
		context.setLineWidth(10.0)

		context.setLineCap(.round)
		context.strokePath()

		self.trackPoint = nil
	}


	func drawLineFromLastDot(to point: CGPoint) {
		self.trackPoint = point
		setNeedsDisplay()
	}
}

extension CanvasView {

	static func dotViewConstraints(in parent: UIView, dotModel: DotViewModel) {

		let dotView = DotView(viewModel: dotModel)

		parent.addSubview(dotView)
		dotView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			dotView.widthAnchor.constraint(equalToConstant: 64.0),
			dotView.heightAnchor.constraint(equalToConstant: 64.0),
		])

		switch dotModel.identifier {
			case 0:
				NSLayoutConstraint.activate([

					dotView.topAnchor.constraint(equalTo: parent.topAnchor),
					dotView.leadingAnchor.constraint(equalTo: parent.leadingAnchor)
				])

			case 1:
				NSLayoutConstraint.activate([
					dotView.topAnchor.constraint(equalTo: parent.topAnchor),
					dotView.centerXAnchor.constraint(equalTo: parent.centerXAnchor)
				])

			case 2:
				NSLayoutConstraint.activate([
					dotView.topAnchor.constraint(equalTo: parent.topAnchor),
					dotView.trailingAnchor.constraint(equalTo: parent.trailingAnchor)
				])

			case 3:
				NSLayoutConstraint.activate([
					dotView.centerYAnchor.constraint(equalTo: parent.centerYAnchor),
					dotView.leadingAnchor.constraint(equalTo: parent.leadingAnchor)
				])

			case 4:
				NSLayoutConstraint.activate([
					dotView.centerYAnchor.constraint(equalTo: parent.centerYAnchor),
					dotView.centerXAnchor.constraint(equalTo: parent.centerXAnchor)
				])

			case 5:
				NSLayoutConstraint.activate([
					dotView.centerYAnchor.constraint(equalTo: parent.centerYAnchor),
					dotView.trailingAnchor.constraint(equalTo: parent.trailingAnchor)
				])

			case 6:
				NSLayoutConstraint.activate([
					dotView.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
					dotView.bottomAnchor.constraint(equalTo: parent.bottomAnchor)
				])

			case 7:
				NSLayoutConstraint.activate([
					dotView.centerXAnchor.constraint(equalTo: parent.centerXAnchor),
					dotView.bottomAnchor.constraint(equalTo: parent.bottomAnchor)
				])

			case 8:
				NSLayoutConstraint.activate([
					dotView.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
					dotView.bottomAnchor.constraint(equalTo: parent.bottomAnchor)
				])

			default: return
		}
	}
}
