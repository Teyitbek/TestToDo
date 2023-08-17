import UIKit
import Factory

final class HomeVC: BaseVC<HomeCV, HomeVM> {
    @Injected(\.taskManager) var taskManager: TasksManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Asset.lightBg.color
        contentView.collectionView.delegate = self
        contentView.collectionView.dataSource = self
        
        viewModel.taskManager.tasksUpdatedSubject.sink { [weak self] tasks in
            self?.updateItems()
        }.store(in: &bag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentView.setCompleted(percent: viewModel.taskManager.getCompletedPercentage())
    }
    
    override func setLocalization() {
        contentView.locationImage.image = Asset.location.image
        contentView.locationLabel.text = "California, San Diego"
        contentView.greetingLabel.text = "Hello, Blake Gorgon"
        contentView.hiEmojiImage.image = Asset.hiEmoji.image
        contentView.sunImage.image = Asset.sun.image
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
        if viewModel.taskManager.getFilteredTasks()[indexPath.row].isCompleted {
            cell.mainContentView.insideView.backgroundColor = .lightGray
        } else {
            cell.mainContentView.insideView.backgroundColor = .green
        }
        switch indexPath.row {
        case 0: cell.mainContentView.position = .top
        case -1: cell.mainContentView.position = .bottom
        default: cell.mainContentView.position = .center
        }
                
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsCount = viewModel.taskManager.tasks.count
        let collectionHeight = collectionView.bounds.height
        let minimumItemHeight: CGFloat = 5 // Minimum height for each item
        let calculatedItemHeight = max(minimumItemHeight, collectionHeight / CGFloat(itemsCount))
        collectionView.reloadData()
            
        return CGSize(width: collectionView.bounds.width, height: calculatedItemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

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


