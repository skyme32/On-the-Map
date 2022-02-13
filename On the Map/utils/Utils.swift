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
        view.present(alertVC, animated: true, completion: nil)
    }
    
    class func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    class func openURL(urlString: String?, view: UIViewController) {
        let urlRefactor = refactoringURL(urlString: urlString)
        if verifyUrl(urlString: urlRefactor) {
            UIApplication.shared.open(URL(string: urlRefactor)!, options: [:], completionHandler: nil)
        } else {
            showLoginFailure(title: "Error URL Web", message: "Unable to open web link.", view: view)
        }
    }
    
    class func refactoringURL(urlString: String?) -> String {
        var urlRefactor = urlString
        if !urlString!.contains("http") {
            urlRefactor = "http://\(urlString!)"
        }
        return urlRefactor!
    }

}
