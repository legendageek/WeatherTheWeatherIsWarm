//
//  WeatherViewController.swift
//  WeatherTheWeatherIsWarm
//
//  Created by Kirill Fukalov on 28.03.23.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    // MARK: - Private let
    
    private var weatherView = WeatherView()
    private let locationService = LocationService()
    private let networkService: NetworkServiceProtocol
    
    //MARK: - Init
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override methods
    
    override func loadView() {
        view = weatherView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationRequest()
    }
    
    // MARK: - Private methods
    
    private func locationRequest() {
        locationService.requestLocationUpdates()
        locationService.delegate = self
    }
    
    private func initialRequest(lat: CGFloat, lon: CGFloat) {
        Task {
            do {
                let weatherModel = try await networkService.load(lat: lat, lon: lon)
                weatherView.configure(weatherModel: weatherModel)
             
            } catch {
              print(error.localizedDescription)
            }
        }
    }
}

extension WeatherViewController: LocationServiceDelegate {
    func didUpdateLocations(lat: CGFloat, lon: CGFloat) {
        initialRequest(lat: lat, lon: lon)
      locationService.stopLocationUpdates()
    }
    
    func didFailWithError(error: Error) {
    }
}
