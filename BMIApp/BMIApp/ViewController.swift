//
//  ViewController.swift
//  BMIApp
//
//  Created by english on 2023-09-22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtHeightInCm: UITextField!
    
    @IBOutlet weak var txtWeightInKg: UITextField!
    
    @IBOutlet weak var lblBMIClassification: UILabel!
    
    @IBOutlet weak var btnCalculate: UIButton!
    
    @IBAction func btnCalculateTouchUpInside(_ sender: Any) {
        
        guard let heightInCm = Double(txtHeightInCm.text!), (80...250).contains(heightInCm) else {
            Toast.ok(view: self, title: "Review the height", message: "Enter a height between 80 cm and 250 cm.")
            txtHeightInCm.text = ""
            return
        }
        
        guard let weightInKg = Double(txtWeightInKg.text!), (30...300).contains(weightInKg) else {
            Toast.ok(view: self, title: "Review the weight", message: "Enter a weight between 30 kg and 300 kg.")
            txtWeightInKg.text = ""
            return
        }
        
        let bmi = bmiCalculation(heightInCm: heightInCm, weightInKg: weightInKg)
        let bmiClassification = bmiClassification(bmi: bmi)
        
        lblBMIClassification.text = "BMI Classification = \(bmiClassification)"
        lblBMIClassification.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblBMIClassification.isHidden = true
        btnCalculate.layer.cornerRadius = 10
    }

    @IBAction func inputsChanged(_ sender: Any) {
        lblBMIClassification.isHidden = true
    }
    
    func bmiCalculation(heightInCm : Double, weightInKg : Double) -> Double {
        let heightInMeters = heightInCm / 100
        let bmi = weightInKg / (heightInMeters * heightInMeters)
        let roundBmi = round(bmi * 10) / 10
        return roundBmi
    }
    
    func bmiClassification(bmi : Double) -> String {
        var classification : String

        switch bmi {
        case 0...18.5:
            classification = "Underweight"
            lblBMIClassification.backgroundColor = .blue
        case 18.6...24.9:
            classification = "Normal Weight"
            lblBMIClassification.backgroundColor = .green
        case 25...29.9:
            classification = "Overweight"
            lblBMIClassification.backgroundColor = .yellow
        case 30...100:
            classification = "Obesity"
            lblBMIClassification.backgroundColor = .orange
        default:
            classification = "Undefined"
            lblBMIClassification.backgroundColor = .red
        }
        
        return classification
    }
    
}

