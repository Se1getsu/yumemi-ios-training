//
//  WeatherPresenter.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/13.
//

import Foundation

final class WeatherPresenter: WeatherPresenterInput {
    // MARK: Properties - Dependencies
    
    private weak var view: WeatherPresenterOutput!
    private var weatherInfoRepository: WeatherInfoRepositoryProtocol
    
    // MARK: Lifecycle
    
    init(view: WeatherPresenterOutput, weatherInfoRepository: WeatherInfoRepositoryProtocol) {
        self.view = view
        self.weatherInfoRepository = weatherInfoRepository
    }
    
    func willEnterForeground() {
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
}

// MARK: - Private

private extension WeatherPresenter {
    /// 天気を読み込む
    func loadWeather() {
        view.startLoading()
        DispatchQueue.global().async {
            defer {
                DispatchQueue.main.async {
                    self.view.finishLoading()
                }
            }
            do {
                let weatherInfo = try self.weatherInfoRepository.fetch(at: "tokyo", date: Date())
                // 読み込み成功
                DispatchQueue.main.async {
                    self.view.showWeatherInfo(weatherInfo: weatherInfo)
                }
            } catch {
                // 読み込み失敗
                DispatchQueue.main.async {
                    self.view.showFetchErrorAlert()
                }
            }
        }
    }
}
