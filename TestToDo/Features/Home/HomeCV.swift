import UIKit

public final class HomeCV: UIView {
    lazy var emptyImageView = makeBgImage()
    lazy var filledImageView = makeBgImage()
    
    lazy var locationView = makeLocationView()
    lazy var locationImage = makeImageView()
    lazy var locationLabel = makeLabel(font: .systemFont(ofSize: 18))
    lazy var greetingLabel = makeLabel(font: .boldSystemFont(ofSize: 24))
    lazy var greetingEmojiImage = makeImageView()
    lazy var sunImageView = makeImageView()
    lazy var viewForCollection = makeViewForCollection(color: .clear, cornerRadius: 12.adaptToScreenSize)
    lazy var collectionView = makeCollectionView()
    lazy var infoView = makeInfoView(image: Asset.rightArrow.image)
    
    private let locationSpacing = 15.adaptToScreenSize
    private let spacingInsideLocation = 7.adaptToScreenSize
    private let greetingSpacing = 15.adaptToScreenSize
    private let sunImageSpacing = 40.adaptToScreenSize
    private let collectionTrailing = 15.adaptToScreenSize
    private let locationViewHeight = 32.adaptToScreenSize
    private let locationViewWidth = 200.adaptToScreenSize
    private let locationImageHeight = 25.adaptToScreenSize
    private let greetingLabelHeight = 35.adaptToScreenSize
    private let sunImageHeight = 78.adaptToScreenSize
    private let collectionBottomSpacing = 140.adaptToScreenSize
    private let lineViewInsideViewWidth = 4.adaptToScreenSize
    private let completedHeight = 592.adaptToScreenSize
    private let infoViewSpacing = 24.adaptToScreenSize
    private let collectionViewWidth = 32.adaptToScreenSize
    
    var filledBgImageViewHeightConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
        setProperties()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup subviews and constraints
extension HomeCV: Customizable {
    func setSubviews() {
        addSubview(emptyImageView)
        emptyImageView.addSubview(filledImageView)
        addSubview(locationView)
        locationView.addSubview(locationImage)
        locationView.addSubview(locationLabel)
        addSubview(greetingEmojiImage)
        addSubview(greetingLabel)
        addSubview(sunImageView)
        addSubview(viewForCollection)
        viewForCollection.addSubview(collectionView)
        viewForCollection.addSubview(infoView)
    }
    
    func setConstraints() {
        filledBgImageViewHeightConstraint = filledImageView.heightAnchor.constraint(equalToConstant: 0)
        
        emptyImageView.anchor(
            .leading(leadingAnchor),
            .trailing(trailingAnchor),
            .bottom(bottomAnchor),
            .height(completedHeight)
        )
        
        filledImageView.anchor(
            .leading(emptyImageView.leadingAnchor),
            .trailing(emptyImageView.trailingAnchor),
            .bottom(emptyImageView.bottomAnchor)
        )
        // MARK: Rebuild!
        NSLayoutConstraint.activate([
            filledBgImageViewHeightConstraint!
        ])
        
        locationView.anchor(
            .top(safeAreaLayoutGuide.topAnchor, constant: locationSpacing),
            .leading(leadingAnchor, constant: locationSpacing),
            .height(locationViewHeight),
            .widthGreaterThanConstant(locationViewWidth)
        )
        
        locationImage.anchor(
            .leading(locationView.leadingAnchor, constant: spacingInsideLocation),
            .centerY(locationView.centerYAnchor),
            .height(locationImageHeight),
            .trailing(locationLabel.leadingAnchor, constant: spacingInsideLocation)
        )
        
        locationLabel.anchor(
            .centerY(locationView.centerYAnchor),
            .trailing(locationView.trailingAnchor, constant: spacingInsideLocation),
            .height(locationImageHeight)
        )
        
        greetingLabel.anchor(
            .top(locationView.bottomAnchor, constant: greetingSpacing),
            .leading(leadingAnchor, constant: greetingSpacing),
            .height(locationViewHeight * 2)
        )
        
        greetingEmojiImage.anchor(
            .leading(greetingLabel.trailingAnchor, constant: greetingSpacing / 2),
            .centerY(greetingLabel.centerYAnchor),
            .height(locationViewHeight * 2)
        )
        
        sunImageView.anchor(
            .top(greetingLabel.bottomAnchor, constant: sunImageSpacing),
            .leading(leadingAnchor, constant: sunImageSpacing),
            .height(sunImageHeight),
            .width(sunImageHeight)
        )
        
        viewForCollection.anchor(
            .top(sunImageView.centerYAnchor),
            .trailing(trailingAnchor, constant: collectionTrailing),
            .width(collectionViewWidth),
            .bottom(bottomAnchor, constant: collectionBottomSpacing)
        )
        
        collectionView.anchor(
            .top(viewForCollection.topAnchor),
            .leading(viewForCollection.leadingAnchor),
            .trailing(viewForCollection.trailingAnchor),
            .bottom(viewForCollection.bottomAnchor)
        )
        
        infoView.anchor(
            .trailing(collectionView.leadingAnchor, constant: infoViewSpacing),
            .centerY(collectionView.topAnchor)
        )
    }
    
    func setProperties() {
        switch DeviceScreenSize.current {
        case .small:
            emptyImageView.image = Asset.emptySuperSmall.image
            filledImageView.image = Asset.filledSuperSmall.image
        case .normal:
            emptyImageView.image = Asset.emptySmall.image // MARK: - small set for ipod touch 7
            filledImageView.image = Asset.filledSmall.image
        case .large:
            emptyImageView.image = Asset.emptyMiddle.image
            filledImageView.image = Asset.filled.image
        }
        
        backgroundColor = Asset.lightBg.color
    }
}

// MARK: Calculate Percents
extension HomeCV {
    func setCompleted(percent: CGFloat) {
        filledBgImageViewHeightConstraint?.isActive = false
        filledBgImageViewHeightConstraint = filledImageView.heightAnchor.constraint(equalToConstant: completedHeight * percent)
        filledBgImageViewHeightConstraint?.isActive = true
        filledImageView.isHidden = (percent == 0)
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}

// MARK: Factory Methods
private extension HomeCV {
    func makeBgImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .bottom
        imageView.clipsToBounds = true
        return imageView
    }
    
    func makeLocationView() -> UIView {
        let view = UIView()
        view.backgroundColor = Asset.topView.color
        view.layer.cornerRadius = 6
        return view
    }
    
    func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    func makeLabel(font: UIFont) -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.font = font
        return label
    }
    
    func makeViewForCollection(color: UIColor? = .white, cornerRadius: CGFloat) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        view.layer.cornerRadius = cornerRadius
        return view
    }
    
    func makeCollectionView() -> CollectionView {
        let collection = CollectionView(scrollDirection: .vertical,
                                        cells: [
                                            ResultCVCell.self
                                        ])
        collection.isScrollEnabled = true
        return collection
    }
    
    func makeInfoView(image: UIImage) -> InfoView {
        let view = InfoView()
        view.imageView.image = image
        return view
    }
}

