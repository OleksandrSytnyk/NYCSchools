//
//  SchoolDetailsViewController.swift
//  20190603-OleksandrSytnyk-NYCSchools
//
//  Created by Oleksandr Sytnyk on 2/9/19.
//  Copyright © 2019 Oleksandr Sytnyk. All rights reserved.
//

import UIKit

class SchoolDetailsViewController: UIViewController {
  @IBOutlet weak var dbnLabel: UILabel!
  @IBOutlet weak var schoolNameLabel: UILabel!
  @IBOutlet weak var satReadingLabel: UILabel!
  @IBOutlet weak var satMathLabel: UILabel!
  @IBOutlet weak var satWritingLabel: UILabel!
  @IBOutlet weak var satTakersNumber: UILabel!
  
  var schoolDetailsViewModel: SchoolDetailsViewModel?
  var school: School?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let school = school {
      schoolDetailsViewModel = SchoolDetailsViewModel(school: school)
      configureViews()
    }
  }
  
  func configureViews() {
    guard let schoolDetailsViewModel = schoolDetailsViewModel else { return }
    dbnLabel.text = schoolDetailsViewModel.dbn
    schoolNameLabel.text = schoolDetailsViewModel.name
    satReadingLabel.text = schoolDetailsViewModel.satReading
    satMathLabel.text = schoolDetailsViewModel.satMath
    satWritingLabel.text = schoolDetailsViewModel.satWriting
    satTakersNumber.text = schoolDetailsViewModel.numberOfSATTestTakers
  }
}
