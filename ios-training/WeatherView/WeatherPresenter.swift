//
//  WeatherPresenter.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/13.
//

import Foundation

@MainActor
final class WeatherPresenter {
    // MARK: Properties - Dependencies
    
    private weak var view: WeatherPresenterOutput!
    private var weatherInfoRepository: WeatherInfoRepositoryProtocol
    
    // MARK: Lifecycle
    
    init(view: WeatherPresenterOutput, weatherInfoRepository: WeatherInfoRepositoryProtocol) {
        self.view = view
        self.weatherInfoRepository = weatherInfoRepository
    }
}

// MARK: - WeatherPresenterInput

extension WeatherPresenter: WeatherPresenterInput {
    func willEnterForeground() {
        guard !view.isAlertShowing else { return }
        loadWeather()
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
                let weatherInfo = try await self.weatherInfoRepository.fetch(at: "tokyo", date: Date())
                view.showWeatherInfo(weatherInfo: weatherInfo)
            } catch {
                view.showFetchErrorAlert()
            }
        }
    }
}
