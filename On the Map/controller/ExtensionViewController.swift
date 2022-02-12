//
//  ExtensionViewController.swift
//  On the Map
//
//  Created by Marcos Mejias on 12/2/22.
//

import UIKit

extension UIViewController {
    
    @IBAction func logoutTapped(_ sender: UIBarButtonItem) {
        UdacityClient.logout {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
