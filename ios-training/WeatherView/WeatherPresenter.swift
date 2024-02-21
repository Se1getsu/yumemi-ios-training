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
        self.weatherInfoRepository.delegate = self
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

// MARK: WeatherInfoRepositoryDelegate

extension WeatherPresenter: WeatherInfoRepositoryDelegate {
    func didFetch(result: Result<WeatherInfo, Error>) {
        switch result {
        case .success(let weatherInfo):
            DispatchQueue.main.async {
                self.view.showWeatherInfo(weatherInfo: weatherInfo)
            }
        case .failure:
            DispatchQueue.main.async {
                self.view.showFetchErrorAlert()
            }
        }
        DispatchQueue.main.async {
            self.view.finishLoading()
        }
    }
}

// MARK: - Private

private extension WeatherPresenter {
    /// 天気を読み込む
    func loadWeather() {
        view.startLoading()
        weatherInfoRepository.requestFetch(at: "tokyo", date: Date())
    }
}
