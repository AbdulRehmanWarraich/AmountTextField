//  Created on 28/09/2021.

import UIKit

class AmountTextField: UITextField {
    
    //MARK:- Properties
    
    //MARK:- Border properties
    
    //MARK:- inits
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    
    //MARK:- Helper Functions
    func setup() {
        self.delegate = self
        self.addTarget(self, action: #selector(self.textFiledEditingDidBegin), for: .editingDidBegin)
        self.addTarget(self, action: #selector(self.textFieldEditingDidEnd), for: .editingDidEnd)
        self.addTarget(self, action: #selector(self.textFieldEditingChanged(_:)), for: .editingChanged)
        
    }
    
    
    //MARK: First responder handling
    @objc private func textFiledEditingDidBegin() {
        
    }
    
    @objc private func textFieldEditingDidEnd() {
   
    }
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        
        guard var text = textField.text,
              text.count > 1 else { return}
        
        text.removeFirst()
        
        let amount = Double(text) ?? 0.0
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        let result = formatter.string(from: NSNumber(value: amount)) ?? ""
        print(result)
//        textField.text = result
    }
}

extension AmountTextField: UITextFieldDelegate {
    //Set max Limit for textfields
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        /* Check that if text is nil then return false */
        guard let text = textField.text,
              let textRange = Range(range, in: text) else { return false }
        
        /* Length of text in UITextField */
        let newLength = text.count + string.count - range.length
        
        let updatedText = text.replacingCharacters(in: textRange, with: string)
            
        
        /* Check prefix limit and disabling editing in prefix */
        let protectedRange = NSMakeRange(0, 1)
        let intersection = NSIntersectionRange(protectedRange, range)
        
        if intersection.length > 0 ||
            range.location < (protectedRange.location + protectedRange.length) {
            
            return false
        }
        
        /* Restricting user to enter only number */
        let allowedCharactors = text.contains(".") ? "0123456789" : "0123456789."
        let allowedCharacters = CharacterSet(charactersIn: allowedCharactors)
        let characterSet = CharacterSet(charactersIn: string)
        
        if allowedCharacters.isSuperset(of: characterSet) != true {
            
            return false
        }
        
        return true
    }
}


/*
class CurrencyField: UITextField {
    var decimal: Decimal {
        return string.decimal / pow(10, Formatter.currency.maximumFractionDigits)
    }
    
    var maximum: Decimal = 999_999_999
    private var lastValue: String?
    
    var locale: Locale = .current {
        didSet {
            Formatter.currency.locale = locale
            sendActions(for: .editingChanged)
        }
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        // you can make it a fixed locale currency if needed
        // self.locale = Locale(identifier: "pt_BR") // or "en_US", "fr_FR", etc
        Formatter.currency.locale = locale
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        keyboardType = .decimalPad
        textAlignment = .center
        sendActions(for: .editingChanged)
    }
    
    override func deleteBackward() {
        text = string.digits.dropLast().string
        // manually send the editingChanged event
        sendActions(for: .editingChanged)
    }
    
    @objc func editingChanged() {
        guard decimal <= maximum else {
            text = lastValue
            return
        }
        text = decimal.currency
        lastValue = text
    }
}

extension CurrencyField {
    var doubleValue: Double {
        (decimal as NSDecimalNumber).doubleValue
    }
}

extension UITextField {
     var string: String {
        text ?? ""
     }
}
extension NumberFormatter {
    convenience init(numberStyle: Style) {
        self.init()
        self.numberStyle = numberStyle
    }
}

private extension Formatter {
    static let currency: NumberFormatter = .init(numberStyle: .currency)
}

extension StringProtocol where Self: RangeReplaceableCollection {
    var digits: Self {
        print("self: \(self)")
        return filter (\.isWholeNumber)
    }
}

extension String {
    var decimal: Decimal {
        Decimal(string: digits) ?? 0
    }
}

extension Decimal {
    var currency: String {
        Formatter.currency.string(for: self) ?? ""
    }
}
extension LosslessStringConvertible {
    var string: String { .init(self) }
}

*/




/*
class CurrencyTextField: UITextField {

    /// The numbers that have been entered in the text field
    private var enteredNumbers = ""

    private var didBackspace = false

    var locale: Locale = Locale(identifier: "en_US")//.current

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }

    override func deleteBackward() {
        enteredNumbers = String(enteredNumbers.dropLast())
        text = enteredNumbers.asCurrency(locale: locale)
        // Call super so that the .editingChanged event gets fired, but we need to handle it differently, so we set the `didBackspace` flag first
        didBackspace = true
        super.deleteBackward()
    }

    @objc func editingChanged() {
        defer {
            didBackspace = false
            text = enteredNumbers.asCurrency(locale: locale)
        }

        guard didBackspace == false else { return }

        if let lastEnteredCharacter = text?.last, lastEnteredCharacter.isNumber {
            enteredNumbers.append(lastEnteredCharacter)
        }
    }
}

private extension Formatter {
    static let currency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
}

private extension String {
    func asCurrency(locale: Locale) -> String? {
        Formatter.currency.locale = locale
        if self.isEmpty {
            return Formatter.currency.string(from: NSNumber(value: 0))
        } else {
            return Formatter.currency.string(from: NSNumber(value: (Double(self) ?? 0) / 100))
        }
    }
}
*/
