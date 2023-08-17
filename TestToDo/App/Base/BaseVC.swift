import Combine
import UIKit

class BaseVC<ContentView: Customizable, ViewModel: ViewModelType>: UIViewController {
    var bag = Set<AnyCancellable>() 
    var contentView: ContentView
    var viewModel: ViewModel
    
    init(contentView: ContentView, viewModel: ViewModel) {
        self.contentView = contentView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTargets()
        setLocalization()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTargets() {}
    func localize(with string: Initialize) {}
    func setLocalization() {}
    
}
