import Foundation
import UIKit

func getAllert(message: String) -> UIAlertController{
    let allert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    allert.addAction(UIAlertAction(title: "OK", style: .default))
    return allert
}

func convertMTH(min: Int) -> String{
    var min = min
    var hours = 0
    
    repeat {
        hours += 1
        min = min - 60
    } while (min > 60);
    
    return String(hours) + "h" + String(min) + "m"
}
