import UIKit

func getTextField(plaseholder: String) -> UITextField {
    let tf = UITextField()
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.attributedPlaceholder = NSAttributedString(
        string: plaseholder,
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont(name: "Arial", size: 18)!])
    tf.autocorrectionType = .no
    
    let line = UIView()
    line.translatesAutoresizingMaskIntoConstraints = false
    line.layer.borderColor = UIColor.gray.cgColor
    line.layer.borderWidth = 1
    
    tf.addSubview(line)
    
    line.topAnchor.constraint(equalTo: tf.bottomAnchor, constant: 15).isActive = true
    line.leadingAnchor.constraint(equalTo: tf.leadingAnchor).isActive = true
    line.trailingAnchor.constraint(equalTo: tf.trailingAnchor).isActive = true
    line.centerXAnchor.constraint(equalTo: tf.centerXAnchor).isActive = true
    line.heightAnchor.constraint(equalToConstant: 2).isActive = true
    
    return tf
}
