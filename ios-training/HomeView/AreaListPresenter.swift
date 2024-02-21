//
//  AreaListPresenter.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/21.
//

import Foundation

@MainActor
final class AreaListPresenter {
    // MARK: Properties - Dependencies
    
    private weak var view: AreaListPresetnerOutput!
    private var weatherInfoRepository: WeatherInfoRepositoryProtocol
    
    // MARK: Lifecycle
    
    init(view: AreaListPresetnerOutput, weatherInfoRepository: WeatherInfoRepositoryProtocol) {
        self.view = view
        self.weatherInfoRepository = weatherInfoRepository
    }
}

extension AreaListPresenter: AreaListPresenterInput {
    var areas: [Area] {
        Area.allCases
    }
    
    func didSelectRowAt(_ index: Int) {
        view.transitToWeatherView()
    }
}
