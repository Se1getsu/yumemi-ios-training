//
//  WeatherPresenter.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/13.
//

import Foundation

@MainActor
final class WeatherPresenter {
    // MARK: Properties
    
    private let area: Area
    
    // MARK: Properties - Dependencies
    
    private weak var view: WeatherPresenterOutput!
    private var weatherInfoRepository: WeatherInfoRepositoryProtocol
    
    // MARK: Lifecycle
    
    /// - Parameters:
    ///   - area: 表示する地域
    ///   - weatherInfo: 初期状態で表示する天気の情報
    init(
        view: WeatherPresenterOutput,
        weatherInfoRepository: WeatherInfoRepositoryProtocol,
        area: Area,
        weatherInfo: WeatherInfo?
    ) {
        self.view = view
        self.weatherInfoRepository = weatherInfoRepository
        self.area = area
        if let weatherInfo {
            self.view.showWeatherInfo(weatherInfo: weatherInfo)
        }
    }
}

// MARK: - WeatherPresenterInput

extension WeatherPresenter: WeatherPresenterInput {
    var title: String {
        area.description
    }
    
    func willEnterForeground() {
        guard !view.isAlertShowing else { return }
        loadWeather()
    }
    
    func didTapCloseButton() {
        view.closeView()
    }
    
    func didTapReloadButton() {
        loadWeather()
    }
    
    func didTapRetry() {
        loadWeather()
    }
    
    func didTapCancel() {}
}

// MARK: - Private

private extension WeatherPresenter {
    /// 天気を読み込む
    func loadWeather() {
        view.startLoading()
        Task {
            defer {
                view.finishLoading()
            }
            do {
                let weatherInfo = try await self.weatherInfoRepository.fetch(at: [area], date: Date())[area]!
                view.showWeatherInfo(weatherInfo: weatherInfo)
            } catch {
                view.showFetchErrorAlert()
            }
        }
    }
}
