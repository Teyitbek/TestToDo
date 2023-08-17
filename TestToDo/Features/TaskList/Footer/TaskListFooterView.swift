import UIKit

class TaskListFooterView: UITableViewHeaderFooterView {
    lazy var bottomView = makeView()
        
    override public init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setProperties()
    }
}

extension TaskListFooterView {
    func setSubviews() {
        addSubview(bottomView)
    }
    
    func setConstraints() {
        bottomView.anchor(
            .top(topAnchor),
            .leading(leadingAnchor),
            .trailing(trailingAnchor),
            .bottom(bottomAnchor)
        )
    }
    
    func setProperties() {
        //
    }
}

extension TaskListFooterView {
    func makeView() -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
}
