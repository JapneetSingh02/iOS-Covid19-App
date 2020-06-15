//
//  AssessmentViewController.swift
//  Covid19App
//
//  Created by Student on 2020-04-18.
//  Copyright © 2020 Japneet&co. All rights reserved.
//

import UIKit

class AssessmentViewController: UIViewController {
    
    @IBOutlet weak var assessmentImage: UIImageView!
    @IBOutlet weak var switchQuestion1: UISwitch!
    @IBOutlet weak var switchQuestion2: UISwitch!
    @IBOutlet weak var switchQuestion3: UISwitch!
    @IBOutlet weak var uiViewQuestion1: UIView!
    @IBOutlet weak var uiViewQuestion2: UIView!
    @IBOutlet weak var uiViewQuestion3: UIView!
    @IBOutlet weak var buttonSubmit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UiConfigurations.updateUiElements(uiViewQuestion1,uiViewQuestion2,uiViewQuestion3)
        buttonSubmit.layer.cornerRadius = 8.0
    }
    
    @IBAction func submitAssessment(_ sender: Any) {
        var alertMessage : String = ""
        var alertTitle : String = Constants.emergency
        if(switchQuestion1.isOn){
            alertMessage = Constants.question1AlertMessage
        }
        if((switchQuestion2.isOn || switchQuestion3.isOn) && !switchQuestion1.isOn){
            alertMessage = Constants.question2OR3AlertMessage
        }
        if(!switchQuestion1.isOn && !switchQuestion2.isOn && !switchQuestion3.isOn){
            alertTitle = Constants.information
            alertMessage = Constants.informationAlertMessage
        }
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: Constants.actionOk, style: .default){ (action) in
            self.switchQuestion1.isOn = false
            self.switchQuestion2.isOn = false
            self.switchQuestion3.isOn = false
        }
        alert.addAction(actionOk)
        present(alert, animated: true, completion: nil)
    }
    
}
