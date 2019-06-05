//
//  HighSchoolsViewController.swift
//  20190603-OleksandrSytnyk-NYCSchools
//
//  Created by Oleksandr Sytnyk on 6/3/19.
//  Copyright © 2019 Oleksandr Sytnyk. All rights reserved.
//

import UIKit
import SVProgressHUD

class SchoolsViewController: UITableViewController {
  var schools = [School]()
  private static let schoolsTableEstimatedRowHeight = CGFloat(70)
  static var showDetails = "ShowDetails"
  var selectedSchoolDetails: School?
  var mapSchoolHandler: ((Int) -> Void)?
  var schoolDetailsHandler: ((String) -> Void)?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureTableView()
  }
  
  
  func configureTableView() {
    tableView.register(UINib(nibName: SchoolTableViewCell.defaultReuseIdentifier, bundle: nil), forCellReuseIdentifier: SchoolTableViewCell.defaultReuseIdentifier)
    
    //This hides empty cells separators
    tableView.tableFooterView = UIView(frame: CGRect.zero)
    
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = SchoolsViewController.schoolsTableEstimatedRowHeight
  }
  
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return schools.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: SchoolTableViewCell.defaultReuseIdentifier, for: indexPath) as? SchoolTableViewCell else {
      return UITableViewCell()
    }
    let schoolTableViewCellViewModel = SchoolTableViewCellViewModel(school: schools[indexPath.row])
    cell.configure(schoolTableViewCellViewModel: schoolTableViewCellViewModel)
    
    cell.tappedCellHandler = {[weak self] in
      guard let strongSelf = self else { return }
      tableView.deselectRow(at: indexPath, animated: false)
      
      strongSelf.schoolDetailsHandler?(strongSelf.schools[indexPath.row].dbn)
    }
    
    cell.tappedMapButtonHandler = {[weak self] in
      guard let strongSelf = self else { return }
      strongSelf.mapSchoolHandler?(indexPath.row)
    }
    return cell
  }
  
  //Mark: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == SchoolsViewController.showDetails, let schoolDetailsViewController = segue.destination as? SchoolDetailsViewController else { return }
    schoolDetailsViewController.school = selectedSchoolDetails
  }
}
