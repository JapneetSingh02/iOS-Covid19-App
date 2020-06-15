//
//  ViewController.swift
//  Covid19App
//
//  Created by Student on 2020-04-15.
//  Copyright © 2020 Japneet&co. All rights reserved.
//

import UIKit
import CoreLocation
import Charts


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    static var nearestCountryData : CovidData?
    static var myCountryData : CovidData?
    @IBOutlet weak var imageViewMain: UIImageView!
    @IBOutlet weak var labelTotalCount: UILabel!
    @IBOutlet weak var labelTotalRecovered: UILabel!
    @IBOutlet weak var labelTotalDeath: UILabel!
    @IBOutlet weak var totalCasesView: UIView!
    @IBOutlet weak var totalRecoveredView: UIView!
    @IBOutlet weak var totalDeathView: UIView!
    @IBOutlet weak var labelDeathPercentage: UILabel!
    @IBOutlet weak var labelRecoveredPercentage: UILabel!
    @IBOutlet weak var deathPercentageView: UIView!
    @IBOutlet weak var recoveredPercentageView: UIView!
    @IBOutlet weak var chartView: BarChartView!
    @IBOutlet weak var buttonPrecautions: UIButton!
    @IBOutlet weak var buttonSelfAssessment: UIButton!
    @IBOutlet weak var nearestCountryView: UIView!
    @IBOutlet weak var labelNearestCountryUpdate: UILabel!
    let locationManager = CLLocationManager()
    var latitude : Double = 0.00
    var longitude : Double = 0.00
    var myCountryName : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManagerConfigurations()
        uiConfigurations()
    }
    
    fileprivate func locationManagerConfigurations() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    fileprivate func uiConfigurations() {
        imageViewMain.layer.cornerRadius = 5.0
        UiConfigurations.updateUiElements(totalCasesView,totalDeathView,totalRecoveredView,deathPercentageView,recoveredPercentageView,buttonSelfAssessment,buttonPrecautions,nearestCountryView)
        buttonSelfAssessment.layer.cornerRadius = 8.0
        buttonPrecautions.layer.cornerRadius = 8.0
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Idea of reverseGeocodeLocation from stackoverflow.com
        if let location = locations.last{
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
            let location = CLLocation(latitude: latitude, longitude: longitude)
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                if error != nil {
                    return
                }else if let country = placemarks?.first?.country{
                    self.myCountryName = country
                }
            })
            getCovid19DataFromApi()
        }
    }
    
    fileprivate func getCovid19DataFromApi() {
        let endpoint = Constants.endpoint
        let urlSession = URLSession(configuration: .default)
        let url = URL(string: endpoint)
        if let url = url{
            let dataTask = urlSession.dataTask(with:url){(data,response,error) in
                if let data = data{
                    let jsonDecoder = JSONDecoder()
                    do{
                        let decodedCovidData = try jsonDecoder.decode(CovidData.self, from: data)
                        self.updateUIElements(decodedCovidData)
                    }
                    catch{
                        print(Constants.errorInApiDecoding)
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    fileprivate func updateUIElements(_ decodedCovidData: CovidData) {
        DispatchQueue.main.async{
            self.labelTotalCount.text = CovidUtil.numberFormatter().string(from: NSNumber(value:decodedCovidData.totalConfirmed))
            self.labelTotalDeath.text = CovidUtil.numberFormatter().string(from: NSNumber(value:decodedCovidData.getTotalDeaths()))
            self.labelTotalRecovered.text = CovidUtil.numberFormatter().string(from: NSNumber(value:decodedCovidData.getTotalRecovered()))
            
            let totalDeath = decodedCovidData.getTotalDeaths()
            let totalRecovered = decodedCovidData.getTotalRecovered()
            let closedCases = (totalDeath) + (totalRecovered)
            let deathRate = (Double(totalDeath *  100)) / Double(closedCases)
            let recoveryRate = (Double(totalRecovered *  100)) / Double(closedCases)
            self.labelDeathPercentage.text = String(format: "%.2f", deathRate) + "%"
            self.labelRecoveredPercentage.text = String(format: "%.2f", recoveryRate) + "%"
            ChartView.drawChart(decodedCovidData, self.chartView, true)
            self.setupNearestCountryData(decodedCovidData: decodedCovidData)
            self.setupMyCountryData(decodedCovidData: decodedCovidData)
        }
    }
    
    fileprivate func setupNearestCountryData(decodedCovidData : CovidData) {
        let currentLocation = CLLocation(latitude: self.latitude, longitude: self.longitude)
        let nearestCounturyData = decodedCovidData.areas.min { (firstArea, secondArea) -> Bool in
            firstArea.getCLLocation().distance(from: currentLocation) < secondArea.getCLLocation().distance(from: currentLocation)
        }
        populateNearestCountryData(nearestCounturyData)
    }
    
    fileprivate func populateNearestCountryData(_ nearestCounturyData: CovidData?) {
        if let nearestCounturyData = nearestCounturyData
        {
            ViewController.nearestCountryData = nearestCounturyData
            let totalConfirmed = CovidUtil.numberFormatter().string(from: NSNumber(value:nearestCounturyData.totalConfirmed))
            self.labelNearestCountryUpdate.text = "\(Constants.countryName) \(String(nearestCounturyData.displayName)) \n\(Constants.totalCases) \(String(totalConfirmed!))\n\(Constants.totalDeaths) \(String(CovidUtil.numberFormatter().string(from: NSNumber(value:nearestCounturyData.getTotalDeaths()))!))\n\(Constants.totalRecovered) \(String(CovidUtil.numberFormatter().string(from: NSNumber(value:nearestCounturyData.getTotalRecovered()))!))"
        }
    }
    
    fileprivate func setupMyCountryData(decodedCovidData : CovidData) {
        var currentCountryData : CovidData?
        for covidData in decodedCovidData.areas {
            if(covidData.displayName == myCountryName){
                currentCountryData = covidData
                break
            }
        }
        if let currentCountryData = currentCountryData{
            ViewController.myCountryData = currentCountryData
        }
    }
}
