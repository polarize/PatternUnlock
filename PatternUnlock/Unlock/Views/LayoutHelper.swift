import UIKit

class LayoutHelper {
	typealias Static = LayoutHelper

	static func canvasViewConstraints(in parent: UIView, viewModel: UnLockPatternViewModel) -> CanvasView {
		let canvas = CanvasView(viewModel: viewModel)
		canvas.backgroundColor = .white

		parent.addSubview(canvas)
		canvas.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			canvas.centerXAnchor.constraint(equalTo: parent.centerXAnchor),

			canvas.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -100),

			canvas.widthAnchor.constraint(equalTo: parent.widthAnchor, constant: -20),
			canvas.heightAnchor.constraint(equalTo: parent.widthAnchor, constant: -20)
		])

		return canvas
	}
	
	static func dotViewConstraints(in parent: UIView, dotModel: UnlockDotModel) {

		let dotView = DotView(model: dotModel)

		parent.addSubview(dotView)
		dotView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			dotView.widthAnchor.constraint(equalToConstant: 64.0),
			dotView.heightAnchor.constraint(equalToConstant: 64.0),
		])

		switch dotModel.identifier {
			case .first:
				NSLayoutConstraint.activate([

					dotView.topAnchor.constraint(equalTo: parent.topAnchor),
					dotView.leadingAnchor.constraint(equalTo: parent.leadingAnchor)
				])

			case .second:
				NSLayoutConstraint.activate([
					dotView.topAnchor.constraint(equalTo: parent.topAnchor),
					dotView.centerXAnchor.constraint(equalTo: parent.centerXAnchor)
				])

			case .third:
				NSLayoutConstraint.activate([
					dotView.topAnchor.constraint(equalTo: parent.topAnchor),
					dotView.trailingAnchor.constraint(equalTo: parent.trailingAnchor)
				])

			case .fourth:
				NSLayoutConstraint.activate([
					dotView.centerYAnchor.constraint(equalTo: parent.centerYAnchor),
					dotView.leadingAnchor.constraint(equalTo: parent.leadingAnchor)
				])

			case .fifth:
				NSLayoutConstraint.activate([
					dotView.centerYAnchor.constraint(equalTo: parent.centerYAnchor),
					dotView.centerXAnchor.constraint(equalTo: parent.centerXAnchor)
				])


			case .sixth:
				NSLayoutConstraint.activate([
					dotView.centerYAnchor.constraint(equalTo: parent.centerYAnchor),
					dotView.trailingAnchor.constraint(equalTo: parent.trailingAnchor)
				])

			case .seventh:
				NSLayoutConstraint.activate([
					dotView.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
					dotView.bottomAnchor.constraint(equalTo: parent.bottomAnchor)
				])

			case .eighth:
				NSLayoutConstraint.activate([
					dotView.centerXAnchor.constraint(equalTo: parent.centerXAnchor),
					dotView.bottomAnchor.constraint(equalTo: parent.bottomAnchor)
				])

			case .ninth:
				NSLayoutConstraint.activate([
					dotView.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
					dotView.bottomAnchor.constraint(equalTo: parent.bottomAnchor)
				])
		}
	}
}
