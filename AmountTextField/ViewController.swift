//  Created on 28/09/2021.

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currencyField: AmountTextField!
     override func viewDidLoad() {
         super.viewDidLoad()
//         currencyField.addTarget(self, action: #selector(currencyFieldChanged), for: .editingChanged)
//         currencyField.locale = Locale(identifier: "en_US") // or "en_US", "fr_FR", etc
     }
    
     @objc func currencyFieldChanged() {
//         print("currencyField:",currencyField.text!)
//         print("decimal:", currencyField.decimal)
//         print("doubleValue:",(currencyField.decimal as NSDecimalNumber).doubleValue, terminator: "\n\n")
     }
}

