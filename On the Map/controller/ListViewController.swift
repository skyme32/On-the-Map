//
//  ListViewController.swift
//  On the Map
//
//  Created by Marcos Mejias on 13/2/22.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedIndex = 0
    let limit: Int = FilterByStudent.MEDIUM
    let order: String = OrderByStudent.updatedAt

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getStudentList()
    }
    
    // MARK: Actions on ViewController
    
    @IBAction func refreshStudents(_ sender: Any) {
        getStudentList()
    }
    
    @IBAction func newStudent(_ sender: Any) {
    }
    
    // MARK: Private methods
    
    private func getStudentList() {
        UdacityClient.getStudentLocationList(limit: limit, order: order) { studentLocations, error in
            StudentLocationModel.studentlist = studentLocations
            self.tableView.reloadData()
        }
    }
}

// MARK: Table Delegate

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentLocationModel.studentlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let student = StudentLocationModel.studentlist[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! StudentLocationCell
        cell.nameLabel?.text = "\(student.firstName) \(student.lastName)"
        cell.urlLabel?.text = student.mediaURL
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urlExtern = StudentLocationModel.studentlist[indexPath.row].mediaURL
        Utils.openURL(urlString: urlExtern, view: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
