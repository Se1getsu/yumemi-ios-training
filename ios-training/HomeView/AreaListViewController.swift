//
//  AreaListViewController.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/15.
//

import UIKit

/// 起動時に表示されるホーム画面
final class AreaListViewController: UIViewController {
    // MARK: Properties - UI
    
    private let myView = AreaListView()
    
    // MARK: Properties - Dependencies
    
    private var presenter: AreaListPresenterInput!
    
    // MARK: Lifecycle
    
    func inject(presenter: AreaListPresenterInput) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "地域を選択"
        view = myView
        myView.eventHandler = self
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        presenter.viewIsAppearing()
    }
}

// MARK: - AreaListViewEventHandler

extension AreaListViewController: AreaListViewEventHandler {
    var areas: [Area] {
        presenter.areas
    }
    
    func weatherInfoAt(_ area: Area) -> WeatherInfo? {
        presenter.weatherInfoAt(area)
    }
    
    func didSelectRowAt(_ index: Int) {
        presenter.didSelectRowAt(index)
    }
    
    func onRefresh() {
        presenter.onRefresh()
    }
}

// MARK: - AreaListPresetnerOutput

extension AreaListViewController: AreaListPresetnerOutput {
    func transitToWeatherView(area: Area, weatherInfo: WeatherInfo?) {
        let vc = WeatherViewController()
        let presenter = WeatherPresenter(
            view: vc,
            weatherInfoRepository: WeatherInfoRepository(
                apiEncoder: YumemiWeatherAPIEncoder(),
                apiDecoder: YumemiWeatherAPIDecoder()
            ),
            area: area,
            weatherInfo: weatherInfo
        )
        vc.inject(presenter: presenter)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func startLoading() {
        myView.activityIndicator.startAnimating()
    }
    
    func finishLoading() {
        myView.activityIndicator.stopAnimating()
    }
    
    func finishRefreshing() {
        myView.refreshControl.endRefreshing()
    }
    
    func reloadData() {
        myView.tableView.reloadData()
    }
    
    func showFetchErrorAlert() {
        let alert = AlertMaker.retryOrCancelAlert(
            title: "天気の取得に失敗しました",
            message: "再試行しますか？",
            didTapRetry: { [unowned self] _ in
                presenter.didTapRetry()
            },
            didTapCancel: nil
        )
        present(alert, animated: true)
    }
    
    func deselectRow() {
        guard let index = myView.tableView.indexPathForSelectedRow else { return }
        myView.tableView.deselectRow(at: index, animated: true)
    }
}

// MARK: - Preview

#Preview {
    let vc = AreaListViewController()
    let presenter = AreaListPresenter(
        view: vc,
        weatherInfoRepository: WeatherInfoRepository(
            apiEncoder: YumemiWeatherAPIEncoder(),
            apiDecoder: YumemiWeatherAPIDecoder()
        )
    )
    vc.inject(presenter: presenter)
    return UINavigationController(rootViewController: vc)
}
