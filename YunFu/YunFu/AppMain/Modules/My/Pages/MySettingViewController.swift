//
//  MySettingViewController.swift
//  YunFu
//
//  Author: Frank
//  Date: 2025-11-21
//
//  页面用途:
//  -------------------------------
//  「我的」模块 → 设置页面
//  展示：账号信息 / 常规设置 / 隐私协议 / 退出登录
//  架构：UIKit + MVVM
//  -------------------------------
//

import UIKit

final class MySettingViewController: UIViewController {
    
    // MARK: - ViewModel
    private let viewModel = MySettingViewModel()
    
    // MARK: - UI
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "设置"
        
        setupTableView()
        bindViewModel()
    }
}

// MARK: - UI Setup
private extension MySettingViewController {
    
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorColor = UIColor.white.withAlphaComponent(0.1)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func bindViewModel() {
        // 将来可以用 Combine 或 RxSwift，这里先用简单回调
        viewModel.onReload = { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource / Delegate
extension MySettingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].items.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let item = viewModel.sections[indexPath.section].items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var config = cell.defaultContentConfiguration()
        config.text = item.title
        config.textProperties.color = .white
        config.image = UIImage(named: item.icon)
        config.imageProperties.tintColor = .white
        
        cell.contentConfiguration = config
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.sections[indexPath.section].items[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        
        item.action?()
    }
}
