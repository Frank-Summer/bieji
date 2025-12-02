final class FeedbackTypeViewModel {

    private(set) var selectedIndex: Int = -1 {
        didSet { onSelectedChange?(selectedIndex) }
    }

    let items: [String]

    // UI 回调
    var onSelectedChange: ((Int) -> Void)?

    init(items: [String]) {
        self.items = items
    }

    func select(index: Int) {
        selectedIndex = index
    }
}
