
import UIKit
import SnapKit

class HomeSubContentCell7: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
    
    private let tufuh_titleL: UILabel = {
        let label = UILabel()
        label.textColor = TUOKOUXIUSwiftbaiseC
        label.font = TUOKOUXIUSwiftFont.semibold(16)
        return label
    }()
    
    private lazy var tufuh_lineV: UIView = {
        let v = UIView()
        v.backgroundColor = TUOKOUXIUWhiteA10
        return v
    }()
    private var tufuh_instrumentsArray: [AcousticSection] = []
    private lazy var tufuh_tabV: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.contentInsetAdjustmentBehavior = .never

        tableView.sectionHeaderTopPadding = 0

        tableView.backgroundColor = TUOKOUXIUSwiftwuseC
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 0.01))
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 0.01)
        
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.backgroundColor = TUOKOUXIUSwiftwuseC
        tukou_initV()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func tukou_initV() {
        contentView.addSubview(tufuh_titleL)
        
        tufuh_tabV.frame = CGRect(x: 0, y: 50, width: TUOKOUXIUSwiftSCRE_W, height: 272)
        contentView.addSubview(self.tufuh_tabV)
        
        tufuh_tabV.delegate = self
        tufuh_tabV.dataSource = self
        
        tufuh_tabV.register(UITableViewCell.self, forCellReuseIdentifier: "TUOKOUXIUHHHTabVVDefCellId")
        tufuh_tabV.register(HomeSubContentCell9.self, forCellReuseIdentifier: "HomeSubContentCell9Id")
        
        contentView.addSubview(tufuh_lineV)
        
        tufuh_titleL.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.top.equalToSuperview().offset(12)
            make.width.equalTo(TUOKOUXIUSwiftSCRE_W-48)
            make.height.equalTo(40)
        }
        
        tufuh_lineV.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.bottom.equalToSuperview().offset(-1)
            make.width.equalTo(TUOKOUXIUSwiftSCRE_W-48)
            make.height.equalTo(1)
        }
    }
    
    func tukou_resModel(tufuh_instrumentsArray: [AcousticSection]) {
        self.tufuh_instrumentsArray = tufuh_instrumentsArray
        let model: AcousticSection = self.tufuh_instrumentsArray[0]
        tufuh_titleL.text = model.tag
        tufuh_tabV.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let aco: AcousticSection = self.tufuh_instrumentsArray[0]
        if aco.items.count > 0 {
            let itemsArray:[AcousticItem] = aco.items
            let item:AcousticItem = itemsArray[indexPath.row]
            let nameStr = item.name ?? ""
            let width = TUOKOUXIUSSStringUtils.tukou_sizWithT(
                nameStr,
                font: TUOKOUXIUSwiftFont.semibold(14),
                maxSize: CGSize(width: TUOKOUXIUSwiftSCRE_W, height: 24)
            ).width
            let itemStr = item.description
            
            let height = TUOKOUXIUSSStringUtils.tukou_textSize(text:
                itemStr,
                font: TUOKOUXIUSwiftFont.regular(14),
                maxSize: CGSize(width: TUOKOUXIUSwiftSCRE_W - width - 48 - 34, height: .greatestFiniteMagnitude), lineSpacing: 6
            ).height
            return height + 10
        } else {
            return 0.01
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tufuh_instrumentsArray.isEmpty {
            return 0
        }
        let acousticSection: AcousticSection = self.tufuh_instrumentsArray[0]
        return acousticSection.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSubContentCell9Id", for: indexPath) as! HomeSubContentCell9

        cell.backgroundColor = TUOKOUXIUSwiftwuseC
        let acousticSection: AcousticSection = self.tufuh_instrumentsArray[0]
        let items: [AcousticItem] = acousticSection.items
        if items.count > 0 {
            cell.tukou_resModel(acousticItem: items[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tufuh_v = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 0.01))
        tufuh_v.backgroundColor = TUOKOUXIUSwiftheiseC
        return tufuh_v
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 0.01))
        footerView.backgroundColor = TUOKOUXIUSwiftheiseC
        return footerView
    }
}
