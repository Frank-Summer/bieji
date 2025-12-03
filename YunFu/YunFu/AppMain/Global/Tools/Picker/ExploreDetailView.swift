
import UIKit

class ExploreDetailView: UIView, UITableViewDelegate, UITableViewDataSource {
    private let container = UIView()
    private let handleBar = UIView()
    
    lazy var tufuh_tabV: UITableView = {
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

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        self.backgroundColor = .black
        self.alpha = 0.7
        setupUI()
        setupGesture()
    }

    required init?(coder: NSCoder) { fatalError() }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissByPan()
    }

    private func setupUI() {
        let height: CGFloat = TUOKOUXIUSwiftSCRE_H - (TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 12)
        container.backgroundColor = TUOKOUXIUWhiteA10
        container.layer.cornerRadius = 32
        container.clipsToBounds = true
        self.addSubview(container)
        container.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: height)
        
        handleBar.backgroundColor = TUOKOUXIUWhiteA30
        handleBar.layer.cornerRadius = 3
        container.addSubview(handleBar)
        handleBar.frame = CGRect(x: (UIScreen.main.bounds.width - 36)/2, y: 12, width: 36, height: 6)
        
        self.tufuh_tabV.frame = CGRect(x: 0, y: 40, width: TUOKOUXIUSwiftSCRE_W, height: height - 40 )
        container.addSubview(self.tufuh_tabV)
        
        self.tufuh_tabV.delegate = self
        self.tufuh_tabV.dataSource = self
        
        self.tufuh_tabV.register(UITableViewCell.self, forCellReuseIdentifier: "TUOKOUXIUHHHTabVVDefCellId")
        
        self.tufuh_tabV.register(HomeSubContentCell1.self, forCellReuseIdentifier: "HomeSubContentCell1Id")
        self.tufuh_tabV.register(HomeSubContentCell2.self, forCellReuseIdentifier: "HomeSubContentCell2Id")
        self.tufuh_tabV.register(HomeSubContentCell3.self, forCellReuseIdentifier: "HomeSubContentCell3Id")
        self.tufuh_tabV.register(HomeSubContentCell4.self, forCellReuseIdentifier: "HomeSubContentCell4Id")
        self.tufuh_tabV.register(HomeSubContentCell5.self, forCellReuseIdentifier: "HomeSubContentCell5Id")
        self.tufuh_tabV.register(HomeSubContentCell6.self, forCellReuseIdentifier: "HomeSubContentCell6Id")
        self.tufuh_tabV.register(HomeSubContentCell7.self, forCellReuseIdentifier: "HomeSubContentCell7Id")
        self.tufuh_tabV.register(HomeSubContentCell8.self, forCellReuseIdentifier: "HomeSubContentCell8Id")
    }

    private func setupGesture() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        container.addGestureRecognizer(pan)
    }

    @objc private func handlePan(_ ges: UIPanGestureRecognizer) {
        let translation = ges.translation(in: container)
        switch ges.state {
        case .changed:
            if translation.y > 0 {
                container.transform = CGAffineTransform(translationX: 0, y: translation.y)
            }
        case .ended, .cancelled:
            if translation.y > 100 {
                dismissByPan()
            } else {
                UIView.animate(withDuration: 0.25) { self.container.transform = .identity }
            }
        default: break
        }
    }

    // ✅ 新增方法：下滑销毁浮层
    private func dismissByPan() {
        UIView.animate(withDuration: 0.25, animations: {
            self.container.frame.origin.y = UIScreen.main.bounds.height
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
        }
    }

    @objc private func cancelAction() {
        dismissByPan()
    }

    @objc private func confirmAction() {
        dismissByPan()
    }

    func show(in view: UIView) {
        view.addSubview(self)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.alpha = 1
            self.container.frame.origin.y = UIScreen.main.bounds.height - self.container.frame.height
        }, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        if self.tufuh_dataTreArr.isEmpty { return 0 }
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 418  //content 224
        } else if indexPath.row == 1 {
            return 185 * TUOKOUXIUDeviceInfo.scaleX + 28 + 32 + 16
        } else if indexPath.row == 2 {
            return 320 * TUOKOUXIUDeviceInfo.scaleX + 32
        } else if indexPath.row == 3 {
            return 16 + 24 + 10 + 20 + 80 + 20 //content 80
        } else if indexPath.row == 4 {
            return 10 + 20 + 10 + 120 //content 120
        } else if indexPath.row == 5 {
            return 10 + 20 + 10 + 80  //content 80
        } else if indexPath.row == 6 {
            return 16 + 24 + 10 + 262 + 12 //content 262
        } else if indexPath.row == 7 {
            return 16 + 16 + 134
        }
        
        return 0.01
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tufuh_v = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 0.01))
        tufuh_v.backgroundColor = TUOKOUXIUSwiftwuseC
        return tufuh_v
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 100.0))
        footerView.backgroundColor = TUOKOUXIUSwiftwuseC
        return footerView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSubContentCell1Id", for: indexPath) as! HomeSubContentCell1
            cell.backgroundColor = TUOKOUXIUSwiftwuseC
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSubContentCell2Id", for: indexPath) as! HomeSubContentCell2
            cell.backgroundColor = TUOKOUXIUSwiftwuseC
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSubContentCell3Id", for: indexPath) as! HomeSubContentCell3
            cell.backgroundColor = TUOKOUXIUSwiftwuseC
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSubContentCell4Id", for: indexPath) as! HomeSubContentCell4
            cell.backgroundColor = TUOKOUXIUSwiftwuseC
            return cell
        } else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSubContentCell5Id", for: indexPath) as! HomeSubContentCell5
            cell.backgroundColor = TUOKOUXIUSwiftwuseC
            return cell
        } else if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSubContentCell6Id", for: indexPath) as! HomeSubContentCell6
            cell.backgroundColor = TUOKOUXIUSwiftwuseC
            return cell
        } else if indexPath.row == 6 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSubContentCell7Id", for: indexPath) as! HomeSubContentCell7
            cell.backgroundColor = TUOKOUXIUSwiftwuseC
            return cell
        } else if indexPath.row == 7 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeSubContentCell8Id", for: indexPath) as! HomeSubContentCell8
            cell.backgroundColor = TUOKOUXIUSwiftwuseC
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUHHHTabVVDefCellId", for: indexPath)
        cell.backgroundColor = TUOKOUXIUSwiftwuseC
        return cell
    }
}
