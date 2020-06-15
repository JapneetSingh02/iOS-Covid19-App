//
//  NearestCountryInfoViewController.swift
//  Covid19App
//
//  Created by Student on 2020-04-18.
//  Copyright © 2020 Japneet&co. All rights reserved.
//

import UIKit
import Charts

class NearestCountryInfoViewController: UIViewController {
    
    @IBOutlet weak var deathUiView: UIView!
    @IBOutlet weak var recoveredUiView: UIView!
    @IBOutlet weak var totalUiView: UIView!
    @IBOutlet weak var deathRateUiView: UIView!
    @IBOutlet weak var recoveryRateUiView: UIView!
    @IBOutlet weak var navigatonBar: UINavigationBar!
    @IBOutlet weak var labelTotalDeath: UILabel!
    @IBOutlet weak var labelTotalRecovered: UILabel!
    @IBOutlet weak var labelTotalConfirmed: UILabel!
    @IBOutlet weak var labelRecoveryRate: UILabel!
    @IBOutlet weak var labelDeathRate: UILabel!
    @IBOutlet weak var chartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let nearestCountryData = ViewController.nearestCountryData{
            navigatonBar.items?.first?.title = "\(Constants.virusTitle) \(nearestCountryData.displayName)"
            updateUIData(nearestCountryData)
        }
        uiConfigurations()
    }
    
    fileprivate func uiConfigurations() {        UiConfigurations.updateUiElements(deathUiView,recoveredUiView,totalUiView,deathRateUiView,recoveryRateUiView )
    }
    
    fileprivate func updateUIData(_ covidData: CovidData) {
        self.labelTotalConfirmed.text = CovidUtil.numberFormatter().string(from: NSNumber(value:covidData.totalConfirmed))
        self.labelTotalDeath.text = CovidUtil.numberFormatter().string(from: NSNumber(value:covidData.getTotalDeaths()))
        self.labelTotalRecovered.text = CovidUtil.numberFormatter().string(from: NSNumber(value:covidData.getTotalRecovered()))
        let totalDeath = covidData.getTotalDeaths()
        let totalRecovered = covidData.getTotalRecovered()
        let closedCases = (totalDeath) + (totalRecovered)
        let deathRate = (Double(totalDeath *  100)) / Double(closedCases)
        let recoveryRate = (Double(totalRecovered *  100)) / Double(closedCases)
        self.labelDeathRate.text = String(format: "%.2f", deathRate) + "%"
        self.labelRecoveryRate.text = String(format: "%.2f", recoveryRate) + "%"
        ChartView.drawChart(covidData, chartView, false)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
