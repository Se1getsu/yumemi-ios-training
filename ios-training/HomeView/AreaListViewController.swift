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
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = myView
        myView.eventHandler = self
    }
}

// MARK: - AreaListViewEventHandler

extension AreaListViewController: AreaListViewEventHandler {
    var areas: [Area] {
        Area.allCases
    }
    
    func didSelectRowAt(_ index: Int) {
        transitToWeatherView()
    }
}

// MARK: - Private

private extension AreaListViewController {
    func transitToWeatherView() {
        let vc = WeatherViewController()
        let presenter = WeatherPresenter(
            view: vc,
            weatherInfoRepository: WeatherInfoRepository(
                apiEncoder: YumemiWeatherAPIEncoder(),
                apiDecoder: YumemiWeatherAPIDecoder()
            )
        )
        vc.inject(presenter: presenter)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

// MARK: - Preview

#Preview {
    return AreaListViewController()
}
