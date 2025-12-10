import UIKit

// MARK: - 全局缓存（只加载一次）
final class CountryCodeCache {
    static let shared = CountryCodeCache()

    var allItems: [CountryCodeItem] = []
    var sections: [String] = []
    var dataSource: [String: [CountryCodeItem]] = [:]

    private init() {
        loadData()
        buildCache()
    }

    private func loadData() {
        guard let url = Bundle.main.url(forResource: "CountryCodes", withExtension: "json") else {
            print("❌ CountryCodes.json 未找到")
            return
        }
        let data = try! Data(contentsOf: url)
        allItems = try! JSONDecoder().decode([CountryCodeItem].self, from: data)
    }

    // ⭐ 修正：变 public，避免 private 导致无法访问
    static func pinyin(_ text: String) -> String {
        let mutable = NSMutableString(string: text) as CFMutableString
        CFStringTransform(mutable, nil, kCFStringTransformToLatin, false)
        CFStringTransform(mutable, nil, kCFStringTransformStripDiacritics, false)
        return (mutable as String).uppercased()
    }

    private func buildCache() {
        print("⚙️ 开始预处理区号（只执行一次）")

        let lang = Locale.preferredLanguages.first ?? "en"
        let isZH = lang.hasPrefix("zh")

        let localized: (CountryCodeItem) -> String = { item in
            isZH ? item.country.zh : item.country.en
        }

        let sorted = allItems.sorted {
            CountryCodeCache.pinyin(localized($0)) <
            CountryCodeCache.pinyin(localized($1))
        }

        var tempSections: [String] = []
        var tempData: [String: [CountryCodeItem]] = [:]

        for item in sorted {
            let name = localized(item)
            let letter = String(CountryCodeCache.pinyin(name).prefix(1))

            if tempData[letter] == nil {
                tempData[letter] = []
                tempSections.append(letter)
            }
            tempData[letter]?.append(item)
        }

        self.sections = tempSections
        self.dataSource = tempData

        print("✅ 区号缓存构建完成（弹窗将瞬间打开）")
    }
}


final class AreaCodeSheetController: UIViewController {

    var onSelect: ((CountryCodeItem) -> Void)?

    private var sections: [String] = []
    private var dataSource: [String: [CountryCodeItem]] = [:]   // 修正 {}

    private let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false

        tv.backgroundColor = .clear
        tv.separatorStyle = .none

        tv.sectionIndexColor = .white
        tv.sectionIndexBackgroundColor = .clear
        tv.sectionIndexTrackingBackgroundColor = UIColor.white.withAlphaComponent(0.2)

        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear

        print("🌍 当前系统语言:", Locale.preferredLanguages.first ?? "unknown")

        // ⭐ 直接从缓存拿，瞬开
        let cache = CountryCodeCache.shared
        sections = cache.sections
        dataSource = cache.dataSource

        setupTable()
    }

    private func setupTable() {
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}


// MARK: - UITableViewDataSource
extension AreaCodeSheetController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        let key = sections[section]
        return dataSource[key]?.count ?? 0
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell()
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.textLabel?.textColor = .white

        let lang = Locale.preferredLanguages.first ?? "en"
        let isZH = lang.hasPrefix("zh")

        let key = sections[indexPath.section]
        if let item = dataSource[key]?[indexPath.row] {
            let name = isZH ? item.country.zh : item.country.en
            cell.textLabel?.text = "\(name)   \(item.code)"
        }

        return cell
    }

    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        sections[section]
    }

    func tableView(_ tableView: UITableView,
                   willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = .white
            header.tintColor = .clear
        }
    }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        sections
    }
}


// MARK: - UITableViewDelegate
extension AreaCodeSheetController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {

        let key = sections[indexPath.section]
        if let item = dataSource[key]?[indexPath.row] {
            onSelect?(item)
        }
    }
}
