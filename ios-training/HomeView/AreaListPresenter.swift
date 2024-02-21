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
        view.transitToWeatherView()
    }
    
    func weatherInfoAt(_ area: Area) -> WeatherInfo? {
        weatherInfos[area]
    }
    
    func viewDidAppear() {
        loadWeatherInfo()
    }
    
    func didTapRetry() {
        loadWeatherInfo()
    }
}

// MARK: - Private

private extension AreaListPresenter {
    func loadWeatherInfo() {
        view.startLoading()
        Task {
            defer {
                view.finishLoading()
            }
            do {
                weatherInfos = try await self.weatherInfoRepository.fetch(at: areas, date: Date())
                view.reloadData()
            } catch {
                view.showFetchErrorAlert()
            }
        }
    }
}
