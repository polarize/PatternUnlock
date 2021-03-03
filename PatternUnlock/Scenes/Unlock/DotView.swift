import UIKit
import Combine

final class DotView: UIView {

	private var imageView: UIImageView!

	private lazy var textLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.textColor = .white
		return label
	}()

	var isHighlighted: Bool = false {
		didSet {
			imageView.isHighlighted = isHighlighted
		}
	}

	let identifier: Int
	let viewModel: DotViewModel

	init(frame: CGRect = .zero, viewModel: DotViewModel) {
		identifier = viewModel.identifier
		self.viewModel = viewModel
		super.init(frame: frame)
		setup(with: viewModel)
	}

	required public init?(coder aDecoder: NSCoder) {
		return nil
	}

	private func setup(with model: DotViewModel) {

		imageView = UIImageView(
			image: UIImage(named: model.normalImageName),
			highlightedImage: UIImage(named: model.highlightedImageName))

		addSubview(imageView)
		textLabelConstraints()
		textLabel.text = "\(model.identifier)"
	}

	private func textLabelConstraints() {
		addSubview(textLabel)
		textLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
			textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
			textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
			textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
		])
	}
}
