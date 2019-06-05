//
//  ContainerViewController.swift
//  20190603-OleksandrSytnyk-NYCSchools
//
//  Created by Oleksandr Sytnyk on 2/10/19.
//  Copyright © 2019 Oleksandr Sytnyk. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
  private var schools = [School]()
  private var schoolsViewController: SchoolsViewController?
  private var mapViewController: MapViewController?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    getSchools()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let schoolsViewController = segue.destination as? SchoolsViewController {
      self.schoolsViewController = schoolsViewController
      schoolsViewController.mapSchoolHandler = { [weak self] selectedSchoolIndex in
        guard let strongSelf = self else {return }
        strongSelf.mapViewController?.selectedSchoolIndex = selectedSchoolIndex
        strongSelf.mapViewController?.setRegion()
      }
    } else if let mapViewController = segue.destination as? MapViewController {
      self.mapViewController = mapViewController
      
      self.mapViewController?.tappedPinHandler = {[weak self] selectedSchoolIndex in
        if let dbn = self?.schools[selectedSchoolIndex].dbn {
          self?.schoolsViewController?.schoolDetailsHandler?(dbn)
        }
      }
    }
    self.schoolsViewController?.schoolDetailsHandler = {[weak self] schoolDBN in
      self?.getSchoolDetails(dbn: schoolDBN)
    }
  }
  
  //Mark: - Loading
  
  func getSchools() {
    UIViewController.showHUD()
    DataManager.shared.getSchools(successHandler: {[weak self] (schools) in
      UIViewController.stopHUD()
      guard let strongSelf = self else { return }
      strongSelf.schools = schools
      
      if let schoolsViewController = strongSelf.schoolsViewController {
        schoolsViewController.schools = schools
        schoolsViewController.tableView.reloadData()
      }
      
      if let mapViewController = strongSelf.mapViewController {
        mapViewController.schools = schools
        mapViewController.setRegion()
      }
      
      }, errorHandler: { [weak self] (errorMessage) in
        UIViewController.stopHUD()
        guard let strongSelf = self else { return }
        let error = errorMessage ?? ""
        strongSelf.showErrorMessage(title: "Error".localized,
                                    subTitle: error)
    })
  }
  
  func getSchoolDetails(dbn: String) -> Void {
    UIViewController.showHUD()
    DataManager.shared.getSchoolDetails(dbn: dbn, successHandler: {[weak self]  school in
      UIViewController.stopHUD()
      self?.schoolsViewController?.selectedSchoolDetails = school
      self?.schoolsViewController?.performSegue(withIdentifier: SchoolsViewController.showDetails, sender: self)
      
      self?.mapViewController?.schoolDetailsHandler?(school.dbn)
      }, errorHandler: { [weak self] (errorMessage) in
        UIViewController.stopHUD()
        guard let strongSelf = self else { return }
        let error = errorMessage ?? ""
        strongSelf.showErrorMessage(title: "Error".localized, subTitle: error)
    })
  }
}
