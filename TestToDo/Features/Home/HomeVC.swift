import UIKit
import Factory

final class HomeVC: BaseVC<HomeCV, HomeVM> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Asset.lightBg.color
        contentView.locationView.isHidden = true
        contentView.collectionView.delegate = self
        contentView.collectionView.dataSource = self
    
        viewModel.taskManager.tasksUpdatedSubject.sink { [weak self] tasks in
            guard let self = self else { return }
            self.updateItems()
            self.contentView.infoView.isHidden = true
        }.store(in: &bag)
        
        viewModel.locationManager.locationUpdatedSubject.sink { [weak self] city, country in
            guard let self = self,
                  let city = city,
                  let country = country else { return }
            self.contentView.locationLabel.text = "\(city), \(country)"
            self.contentView.locationView.isHidden = false
        }.store(in: &bag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentView.setCompleted(percent: viewModel.taskManager.getCompletedPercentage())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.contentView.setCompleted(percent: self.viewModel.taskManager.getCompletedPercentage())
    }
    
    override func setLocalization() {
        contentView.locationImage.image = Asset.location.image
        contentView.greetingLabel.text = "Hello, Blake Gorgon"
        contentView.greetingEmojiImage.image = Asset.hiEmoji.image
        contentView.sunImageView.image = Asset.sun.image
        contentView.infoView.isHidden = true
    }
    
    override func setTargets() {
    }
}

// MARK: - Actions
@objc
extension HomeVC {
    func onBackAction() {
        viewModel.onBackAction?()
    }
}

// MARK: CollectionView
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.taskManager.getFilteredTasks().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ResultCVCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setup(isCompleted: viewModel.taskManager.getFilteredTasks()[indexPath.row].isCompleted,
                   isFirst: indexPath.row == 0,
                   isLast: indexPath.row == (viewModel.taskManager.getFilteredTasks().count - 1))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsCount = viewModel.taskManager.tasks.count
        let collectionHeight = collectionView.bounds.height
        let calculatedItemHeight = collectionHeight / CGFloat(itemsCount)
        return CGSize(width: collectionView.bounds.width, height: calculatedItemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let radius = 12 * Constants.ScreenSizeConstant
        
        if viewModel.taskManager.getFilteredTasks().count == 1 {
            (cell as! ResultCVCell).mainContentView.backgroundView.roundCorners(corners: [.layerMaxXMinYCorner,
                                                                                          .layerMinXMinYCorner,
                                                                                          .layerMaxXMaxYCorner,
                                                                                          .layerMinXMaxYCorner],
                                                                                radius: radius)
        } else {
            if indexPath.item == 0 {
                (cell as! ResultCVCell).mainContentView.backgroundView.roundCorners(corners: [.layerMaxXMinYCorner,
                                                                                              .layerMinXMinYCorner],
                                                                                    radius: radius)
            }
            
            if viewModel.taskManager.getFilteredTasks().count - 1 == indexPath.item {
                (cell as! ResultCVCell).mainContentView.backgroundView.roundCorners(corners: [.layerMaxXMaxYCorner,
                                                                                              .layerMinXMaxYCorner],
                                                                                    radius: radius)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        contentView.infoView.isHidden = false
        selected(at: indexPath)
    }
}

// MARK: Methods CollectionView
extension HomeVC {
    func updateItems() {
        contentView.collectionView.reloadData()
        contentView.setCompleted(percent: viewModel.taskManager.getCompletedPercentage())
        let allTask = viewModel.taskManager.getCompletedPercentage()
        if allTask == 1.0 {
            contentView.backgroundColor = Asset.darkBg.color
        } else {
            contentView.backgroundColor = Asset.lightBg.color
        }
    }
}

extension HomeVC {
    func selected(at indexPath: IndexPath) {
        let selectedItem = viewModel.taskManager.tasks[indexPath.row].title
        guard let cell = contentView.collectionView.cellForItem(at: indexPath) as? ResultCVCell else { return }
        let cellCenterY = cell.frame.midY
        let infoViewY = cellCenterY - contentView.infoView.frame.height / 2.0 - 20.adaptToScreenSize
        contentView.infoView.frame.origin.y = infoViewY
        contentView.infoView.label.text = selectedItem
    }
}

