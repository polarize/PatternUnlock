import UIKit

extension UnlockViewController {
	typealias Static = UnlockViewController

	static func dotViewConstraints(in parent: UIView, dotModel: UnlockDotModel) {

		let dotView = DotsView(model: dotModel)

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
