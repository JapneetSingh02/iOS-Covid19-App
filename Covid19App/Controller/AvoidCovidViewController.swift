//
//  AvoidCovidViewController.swift
//  Covid19App
//
//  Created by Student on 2020-04-18.
//  Copyright © 2020 Japneet&co. All rights reserved.
//

import UIKit

class AvoidCovidViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.items?.first?.title = "\(Constants.virusTitle) \(Constants.precautions)"
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
