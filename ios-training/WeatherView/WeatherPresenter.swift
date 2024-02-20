//
//  WeatherPresenter.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/13.
//

import UIKit

final class WeatherPresenter: WeatherPresenterInput {
    // MARK: Properties - Dependencies
    
    private weak var view: WeatherPresenterOutput!
    private var weatherInfoRepository: WeatherInfoRepositoryProtocol
    
    // MARK: Lifecycle
    
    init(view: WeatherPresenterOutput, weatherInfoRepository: WeatherInfoRepositoryProtocol) {
        self.view = view
        self.weatherInfoRepository = weatherInfoRepository
        
        NotificationCenter.default.addObserver(
            forName: UIApplication.willEnterForegroundNotification,
            object: nil,
            queue: nil
        ) { [weak self] _ in
            self?.loadWeather()
        }
    }
    
    func didTapCloseButton() {
        view.dismiss()
    }
    
    func didTapReloadButton() {
        loadWeather()
    }
    
    func didTapRetry() {
        loadWeather()
    }
}

// MARK: - Private

private extension WeatherPresenter {
    /// 天気を読み込む
    func loadWeather() {
        view.読み込み前()
        DispatchQueue.global().async {
            defer {
                DispatchQueue.main.async {
                    self.view.読み込み完了()
                }
            }
            do {
                let weatherInfo = try self.weatherInfoRepository.fetch(at: "tokyo", date: Date())
                // 読み込み成功
                DispatchQueue.main.async {
                    self.view.読み込み成功(weatherInfo: weatherInfo)
                }
            } catch {
                // 読み込み失敗
                DispatchQueue.main.async {
                    self.view.読み込み失敗()
                }
            }
        }
    }
    
}

// MARK: - Preview

//#Preview {
//    let view = WeatherView()
//    view.weatherImageView.backgroundColor = .green.withAlphaComponent(0.2)
//    return PreviewViewController(view: view)
//}
