import UIKit

func getTextField(plaseholder: String) -> UITextField {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.attributedPlaceholder = NSAttributedString(
        string: plaseholder,
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont(name: "Arial", size: 18)!])
    textField.autocorrectionType = .no
    
    let line = UIView()
    line.translatesAutoresizingMaskIntoConstraints = false
    line.layer.borderColor = UIColor.gray.cgColor
    line.layer.borderWidth = 1
    
    textField.addSubview(line)
    
    line.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 15).isActive = true
    line.leadingAnchor.constraint(equalTo: textField.leadingAnchor).isActive = true
    line.trailingAnchor.constraint(equalTo: textField.trailingAnchor).isActive = true
    line.centerXAnchor.constraint(equalTo: textField.centerXAnchor).isActive = true
    line.heightAnchor.constraint(equalToConstant: 2).isActive = true
    
    return textField
}
