//
//  Utils.swift
//  On the Map
//
//  Created by Marcos Mejias on 12/2/22.
//

import Foundation
import UIKit


class Utils {

    class func refactoringDataJson(data: Data?) -> Data {
        var newData = data
        let typeData: String = String(data: data!, encoding: .utf8)!

        if typeData.hasPrefix(")]}") {
            let range: Range = 5..<data!.count
            newData = data?.subdata(in: range)
        }

        return newData!
    }
    
    class func showLoginFailure(title: String, message: String, view: UIViewController) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        view.show(alertVC, sender: nil)
    }

}
