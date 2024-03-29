//
//  AreaListPresenter.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/21.
//

import Foundation

@MainActor
final class AreaListPresenter {
    // MARK: Properties
    
    let areas: [Area] = Area.allCases
    var weatherInfos: [Area: WeatherInfo] = [:]
    
    // MARK: Properties - Dependencies
    
    private weak var view: AreaListPresetnerOutput!
    private var weatherInfoRepository: WeatherInfoRepositoryProtocol
    
    // MARK: Lifecycle
    
    init(view: AreaListPresetnerOutput, weatherInfoRepository: WeatherInfoRepositoryProtocol) {
        self.view = view
        self.weatherInfoRepository = weatherInfoRepository
    }
}

// MARK: - AreaListPresenterInput

extension AreaListPresenter: AreaListPresenterInput {
    func didSelectRowAt(_ index: Int) {
        let area = areas[index]
        let weatherInfo = weatherInfos[area]
        view.transitToWeatherView(area: area, weatherInfo: weatherInfo)
    }
    
    func weatherInfoAt(_ area: Area) -> WeatherInfo? {
        weatherInfos[area]
    }
    
    func viewIsAppearing() {
        view.deselectRow()
        view.startLoading()
        Task {
            await loadWeatherInfo()
            view.finishLoading()
        }
    }
    
    func didTapRetry() {
        view.startLoading()
        Task {
            await loadWeatherInfo()
            view.finishLoading()
        }
    }
    
    func onRefresh() {
        Task {
            await loadWeatherInfo()
            view.finishRefreshing()
        }
    }
}

// MARK: - Private

private extension AreaListPresenter {
    func loadWeatherInfo() async {
        do {
            weatherInfos = try await self.weatherInfoRepository.fetch(at: areas, date: Date())
            view.reloadData()
        } catch {
            view.showFetchErrorAlert()
        }
    }
}
