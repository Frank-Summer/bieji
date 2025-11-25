//
//  MySettingViewController.swift
//  YunFu
//
//  Author: Frank
//  Date: 2025-11-21
//
//  「我的」模块 → 设置页面
//  使用 TopBarView 实现自定义顶部栏（左返回，中标题）
//

import UIKit

final class MySettingViewController: UIViewController {
    
    // MARK: - ViewModel
    private let viewModel = MySettingViewModel()
    
    // MARK: - UI
    private let topBar = TopBarView()
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)

    
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        // 使用自定义 TopBar 隐藏系统导航栏
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        setupTopBar()
        setupTableView()
    }
}


// MARK: - 顶部栏
private extension MySettingViewController {

    func setupTopBar() {
        topBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topBar)
        
        topBar.title = "设置"
        
        topBar.onLeftTap = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        NSLayoutConstraint.activate([
            topBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topBar.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}


// MARK: - TableView 初始化
private extension MySettingViewController {

    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // 注册普通 cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


extension MySettingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        viewModel.sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = viewModel.sections[indexPath.section].items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        configureCell(cell, with: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.sections[indexPath.section].items[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        item.action?()
    }
}


private extension MySettingViewController {
    
    func configureCell(_ cell: UITableViewCell, with item: SettingItem) {

        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        // 清空复用内容
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        
        // MARK: 1. 外层容器（背景 + 圆角）
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = UIColor(white: 1, alpha: 0.9)  // rgba(255,255,255,0.1)
        container.layer.cornerRadius = 12
        
        cell.contentView.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
            container.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
            container.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 16),
            container.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -16)
        ])
        
        
        // MARK: 2. 左侧图标（licon）
        let leftIcon = UIImageView()
        leftIcon.translatesAutoresizingMaskIntoConstraints = false
        leftIcon.image = UIImage(named: item.licon)
        leftIcon.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            leftIcon.widthAnchor.constraint(equalToConstant: 24),
            leftIcon.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        
        // MARK: 3. 标题（title）
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = item.title
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.textColor = .white
        
        
        // MARK: 4. 右侧图标（ricon）
        let rightIcon = UIImageView()
        rightIcon.translatesAutoresizingMaskIntoConstraints = false
        rightIcon.image = UIImage(named: item.ricon)
        rightIcon.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            rightIcon.widthAnchor.constraint(equalToConstant: 24),
            rightIcon.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        
        // MARK: 5. 添加到 container
        container.addSubview(leftIcon)
        container.addSubview(titleLabel)
        container.addSubview(rightIcon)
        
        
        // MARK: 6. 内部布局（左 → 中 → 右）
        NSLayoutConstraint.activate([
            
            // 左侧图标
            leftIcon.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            leftIcon.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            // 标题
            titleLabel.leadingAnchor.constraint(equalTo: leftIcon.trailingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            // 右侧图标
            rightIcon.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            rightIcon.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            

        ])
    }
}
