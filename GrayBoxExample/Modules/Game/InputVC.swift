//
//  InputVC.swift
//  GrayBoxExample
//
//  Created by Dipesh on 05/07/23.
//

import UIKit

class InputVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var txtInput: UITextField!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Custom func
    
    private func checkValidation() {
        guard self.txtInput.text?.isEmpty == false else {
            self.showAlert(title: "Info", message: "Number can't be empty")
            return
        }
        
        guard let txtInput = self.txtInput.text, let intValue = Int(txtInput), intValue >= 10 else {
            self.showAlert(title: "Info", message: "Number should be >= 10")
            return
        }
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "GameVC") as? GameVC {
            vc.enteredInput = intValue
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: - Action
    
    @IBAction func btnStart(_ sender: UIButton) {
        self.checkValidation()
    }
    
}
