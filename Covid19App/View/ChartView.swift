//
//  ChartView.swift
//  Covid19App
//
//  Created by Student on 2020-04-19.
//  Copyright © 2020 Japneet&co. All rights reserved.
//

import UIKit
import Charts

class ChartView{
    
    static func drawChart(_ countryCovidData: CovidData, _ chartView : BarChartView, _ isMainScreen : Bool)
    {
        let confirmedCases = countryCovidData.totalConfirmed
        let closedCases = countryCovidData.getTotalDeaths() + countryCovidData.getTotalRecovered()
        let activeCases = confirmedCases - closedCases
        let firstElement = BarChartDataEntry(x: 0, y: Double(confirmedCases))
        let secondElement = BarChartDataEntry(x: 1, y: Double(closedCases))
        let thirdElement = BarChartDataEntry(x: 2, y: Double(activeCases))
        let labels = [Constants.confirmedCases,Constants.closedCases, Constants.activeCases]
        let countryDisplayName = isMainScreen ? Constants.global : countryCovidData.displayName
        let dataSet = BarChartDataSet(entries: [firstElement,secondElement,thirdElement], label: "\(Constants.virusName) \(countryDisplayName)")
        dataSet.colors = [#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1),#colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1),#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)]
        let chartData = BarChartData(dataSet: dataSet)
        chartView.animate(xAxisDuration: 1, yAxisDuration: 1)
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: labels)
        chartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        chartView.data = chartData
    }
}
