//
//  MyCountryViewController.swift
//  Covid19App
//
//  Created by Student on 2020-04-21.
//  Copyright © 2020 Japneet&co. All rights reserved.
//

import UIKit
import Charts

class MyCountryViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var totalCasesUiView: UIView!
    @IBOutlet weak var labelTotalCases: UILabel!
    @IBOutlet weak var recoveredCasesUiView: UIView!
    @IBOutlet weak var labelRecoveredCases: UILabel!
    @IBOutlet weak var deathCasesUiView: UIView!
    @IBOutlet weak var deathRateUiView: UIView!
    @IBOutlet weak var labelDeathCases: UILabel!
    @IBOutlet weak var labelDeathRate: UILabel!
    @IBOutlet weak var recoveryRateUiView: UIView!
    @IBOutlet weak var labelRecoveryRate: UILabel!
    @IBOutlet weak var chartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let mycountryData = ViewController.myCountryData{
            navigationBar.items?.first?.title = "\(Constants.virusTitle) \(mycountryData.displayName)"
            updateUIData(mycountryData)
        }
        uiConfigurations()
    }
    
    fileprivate func uiConfigurations() {        UiConfigurations.updateUiElements(deathCasesUiView,recoveredCasesUiView,totalCasesUiView,deathRateUiView,recoveryRateUiView)
    }
    
    fileprivate func updateUIData(_ covidData: CovidData) {
        self.labelTotalCases.text = CovidUtil.numberFormatter().string(from: NSNumber(value:covidData.totalConfirmed))
        self.labelDeathCases.text = CovidUtil.numberFormatter().string(from: NSNumber(value:covidData.getTotalDeaths()))
        self.labelRecoveredCases.text = CovidUtil.numberFormatter().string(from: NSNumber(value:covidData.getTotalRecovered()))
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
