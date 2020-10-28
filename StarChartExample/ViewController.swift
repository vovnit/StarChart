//
//  ViewController.swift
//  StarChartExample
//
//  Created by Vladimir Nitochkin on 27.10.2020.
//

import UIKit
import StarChart

class ViewController: UIViewController {

    @IBOutlet weak var chart: Chart!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func firstSliderValueChanged(_ sender: UISlider) {
        chart.verticesCount = Int(sender.value)
    }
    
    @IBAction func secondSliderValueChanged(_ sender: UISlider) {
        chart.centerOffset = CGFloat(sender.value)
    }
}

