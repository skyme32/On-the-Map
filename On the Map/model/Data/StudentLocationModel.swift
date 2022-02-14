//
//  StudentLocationModel.swift
//  On the Map
//
//  Created by Marcos Mejias on 13/2/22.
//

import Foundation


class StudentLocationModel {
    static let shared = StudentLocationModel()
    private init() {}
    var studentlist = [StudentLocation]()
}
