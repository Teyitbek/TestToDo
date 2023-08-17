import UIKit

final class HomeCV: UIView {
    public lazy var emptyImageView = makeBgImage()
    public lazy var filledImageView = makeBgImage()
    
    public lazy var locationView = makeLocationView()
    public lazy var locationImage = makeImageView()
    public lazy var locationLabel = makeLabel(font: .systemFont(ofSize: 18))
    public lazy var greetingLabel = makeLabel(font: .boldSystemFont(ofSize: 24))
    public lazy var hiEmojiImage = makeImageView()
    public lazy var sunImage = makeImageView()
    public lazy var viewForCollection = makeViewForCollection(color: UIColor(white: 1, alpha: 0.3),
                                                              cornerRadius: 8.adaptToScreenSize)
    public lazy var lineViewInsideView = makeViewForCollection(cornerRadius: 5)
    public lazy var collectionView = makeCollectionView()
    
    let topSpacing = 15.adaptToScreenSize
    let locationViewHeight = 32.adaptToScreenSize
    let locationViewWidth = 200.adaptToScreenSize
    let locationImageHeight = 25.adaptToScreenSize
    let greetingLabelHeight = 35.adaptToScreenSize
    let sunImageHeight = 78.adaptToScreenSize
    let collectionBottomSpacing = 140.adaptToScreenSize
    let lineViewInsideViewWidth = 4.adaptToScreenSize
    let completedHeight = 592.adaptToScreenSize
    
    var filledBgImageViewHeightConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
        setProperties()
    }
    
    override func layoutSubviews() {
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
        addSubview(hiEmojiImage)
        addSubview(greetingLabel)
        addSubview(sunImage)
        addSubview(viewForCollection)
        viewForCollection.addSubview(lineViewInsideView)
        viewForCollection.addSubview(collectionView)
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
            .top(safeAreaLayoutGuide.topAnchor, constant: topSpacing),
            .leading(leadingAnchor, constant: topSpacing),
            .height(locationViewHeight),
            .widthGreaterThanConstant(locationViewWidth)
        )
        
        locationImage.anchor(
            .leading(locationView.leadingAnchor, constant: topSpacing / 2),
            .centerY(locationView.centerYAnchor),
            .height(locationImageHeight),
            .trailing(locationLabel.leadingAnchor, constant: topSpacing / 2)
        )
        
        locationLabel.anchor(
            .centerY(locationView.centerYAnchor),
            .trailing(locationView.trailingAnchor, constant: topSpacing / 2),
            .height(locationImageHeight)
        )
        
        greetingLabel.anchor(
            .top(locationView.bottomAnchor, constant: topSpacing),
            .leading(leadingAnchor, constant: topSpacing),
            .height(locationViewHeight * 2)
        )
        
        hiEmojiImage.anchor(
            .leading(greetingLabel.trailingAnchor, constant: topSpacing / 2),
            .centerY(greetingLabel.centerYAnchor),
            .height(locationViewHeight * 2)
        )
        
        sunImage.anchor(
            .top(greetingLabel.bottomAnchor, constant: topSpacing * 3),
            .leading(leadingAnchor, constant: topSpacing * 2),
            .height(sunImageHeight),
            .width(sunImageHeight)
        )
        
        viewForCollection.anchor(
            .top(sunImage.centerYAnchor),
            .trailing(trailingAnchor, constant: topSpacing),
            .width(locationViewHeight),
            .bottom(bottomAnchor, constant: collectionBottomSpacing)
        )
        
        lineViewInsideView.anchor(
            .top(viewForCollection.topAnchor, constant: topSpacing / 2),
            .bottom(viewForCollection.bottomAnchor, constant: topSpacing / 2),
            .centerX(viewForCollection.centerXAnchor),
            .width(lineViewInsideViewWidth)
        )
        
        collectionView.anchor(
            .top(viewForCollection.topAnchor),
            .leading(viewForCollection.leadingAnchor, constant: topSpacing / 3),
            .trailing(viewForCollection.trailingAnchor, constant: topSpacing / 3),
            .bottom(viewForCollection.bottomAnchor)
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
            emptyImageView.image = Asset.empty.image
            filledImageView.image = Asset.filled.image
        }
    }
}

// MARK: Calculate Percents
extension HomeCV {
    func setCompleted(percent: CGFloat) {
        filledBgImageViewHeightConstraint?.isActive = false
        filledBgImageViewHeightConstraint = filledImageView.heightAnchor.constraint(equalToConstant: completedHeight * percent)
        filledBgImageViewHeightConstraint?.isActive = true
        filledImageView.isHidden = (percent == 0)
        layoutIfNeeded()
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
//        collection.isScrollEnabled = false
        return collection
    }
    
}

