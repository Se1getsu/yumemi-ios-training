//
//  AreaListView.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/21.
//

import UIKit

/// AreaListViewControllerのUIの配置を行う
final class AreaListView: UIView {
    // MARK: Properties
    
    weak var eventHandler: AreaListViewEventHandler?
    
    // MARK: Properties - UI
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(AreaCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    let refreshControl = UIRefreshControl()
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        tableView.refreshControl = refreshControl
        addSubviewUIs()
        setUpLayout()
        registerEvent()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UITableViewDataSource

extension AreaListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        eventHandler?.areas.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AreaCell // swiftlint:disable:this force_cast
        cell.setInfo(   // swiftlint:disable:this trailing_closure
            area: eventHandler?.areas[indexPath.row],
            weatherInfo: { area in
                eventHandler?.weatherInfoAt(area)
            }
        )
        return cell
    }
}

// MARK: - UITableViewDelegate

extension AreaListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventHandler?.didSelectRowAt(indexPath.row)
    }
}

// MARK: - Private

private extension AreaListView {
    /// UIをaddSubViewする処理
    func addSubviewUIs() {
        addSubview(tableView)
        addSubview(activityIndicator)
    }
    
    /// オートレイアウトの設定処理
    func setUpLayout() {
        let safeArea = safeAreaLayoutGuide
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: safeArea.topAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            activityIndicator.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
    
    /// 画面のイベント処理を登録する
    func registerEvent() {
        refreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
    }
    
    @objc private func onRefresh() {
        eventHandler?.onRefresh()
    }
}

// MARK: - Preview
#Preview {
    let view = AreaListView()
    view.tableView.backgroundColor = .green.withAlphaComponent(0.2)
    return PreviewViewController(view: view)
}
