//
//  Constants.swift
//  Covid19App
//
//  Created by Student on 2020-04-19.
//  Copyright © 2020 Japneet&co. All rights reserved.
//

import Foundation

class Constants{
    static let virusName : String = "Covid-19:"
    static let virusTitle : String = "Corona-Virus:"
    static let confirmedCases : String = "Confirmed Cases"
    static let closedCases : String = "Closed Cases"
    static let activeCases : String = "Active Cases"
    static let precautions : String = "Precautions"
    
    static let global : String = "Global"
    static let endpoint : String = "https://www.bing.com/covid/data"
    static let errorInApiDecoding : String = "Error occurred while decoding json response for covid-19!"
    static let countryName : String = "Country Name:"
    static let totalCases : String = "Total Cases:"
    static let totalDeaths : String = "Total Deaths:"
    static let totalRecovered : String = "Total Recovered:"
    
    //Assessment Constants
    static let emergency : String = "Emergency"
    static let question1AlertMessage : String = "Directly call/go to your nearest emergency department."
    static let question2OR3AlertMessage : String = "You may be eligible for a COVID-19 test.\n\nContact a doctor immediatly. \n Do not leave your home.\n Do not go into a hospital or clinic."
    static let information : String = "Infomation"
    static let informationAlertMessage : String = "Stay at home as much as possible. \n You do not need to contact doctor for an assessment. \n1. Avoid going out in public. \n2. Monitor your health."
    static let actionOk : String = "Ok"
}
