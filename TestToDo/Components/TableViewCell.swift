import UIKit

class TableViewCell<ContentView: Customizable>: UITableViewCell {
    public let mainContentView = ContentView()
    private let highlightionView = UIView(backgroundColor: UIColor.white.withAlphaComponent(0.4))
    var shouldHighlightOnTap: Bool {
        return false
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.addSubview(mainContentView)
        self.mainContentView.fillSuperview()
        self.highlightionView.alpha = 0
        self.contentView.addSubview(highlightionView)
        self.highlightionView.fillSuperview()
        self.backgroundColor = .clear
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override open func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        guard shouldHighlightOnTap else {
            return
        }
        UIView.animate(withDuration: 0.25) {
            self.highlightionView.alpha = highlighted ? 1 : 0
        }
    }
}
