import UIKit

class ImageButton: UIButton {
    private let imageButton = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupImageView()
    }

    private func setupImageView() {
        addSubview(imageButton)
        imageButton.anchor(
            .top(topAnchor),
            .leading(leadingAnchor),
            .trailing(trailingAnchor),
            .bottom(bottomAnchor)
        )
    }

    override func setImage(_ image: UIImage?, for state: UIControl.State) {
        imageButton.image = image
    }
}
