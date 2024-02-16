//
//  HomeViewController.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/15.
//

import UIKit

/// 起動時に表示されるホーム画面
final class HomeViewController: UIViewController {
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        transitToWeatherView()
    }
}

// MARK: - Private

private extension HomeViewController {
    func transitToWeatherView() {
        let vc = WeatherViewController(
            weatherInfoRepository: WeatherInfoRepository()
        )
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

// MARK: - Preview

#Preview {
    return HomeViewController()
}
