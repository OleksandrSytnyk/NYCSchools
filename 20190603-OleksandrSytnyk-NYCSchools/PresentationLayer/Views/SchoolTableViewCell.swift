//
//  SchoolTableViewCell.swift
//  20190603-OleksandrSytnyk-NYCSchools
//
//  Created by Oleksandr Sytnyk on 6/3/19.
//  Copyright © 2019 Oleksandr Sytnyk. All rights reserved.
//

import UIKit

class SchoolTableViewCell: UITableViewCell {
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var studentsNumberLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var mapButton: UIButton!
  
  var schoolTableViewCellViewModel: SchoolTableViewCellPresentable?
  var tappedMapButtonHandler: (() -> Void)?
  var tappedCellHandler: (() -> Void)?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setGestureRecognizer()
    
    // OS: TODO - setup centralized font management so that fonts can be reused throughtout the app
    nameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18.0)
  }
  
  func configure(schoolTableViewCellViewModel: SchoolTableViewCellPresentable) {
    self.schoolTableViewCellViewModel = schoolTableViewCellViewModel
    nameLabel.text = schoolTableViewCellViewModel.name
    addressLabel.text = schoolTableViewCellViewModel.address
    studentsNumberLabel.text = schoolTableViewCellViewModel.studentsNumber
  }
  
  @IBAction func mapButtonTapped(_ sender: Any) {
    tappedMapButtonHandler?()
  }
  
  func setGestureRecognizer() {
    let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
    singleTap.delegate = self
    contentView.isUserInteractionEnabled = true
    contentView.addGestureRecognizer(singleTap)
  }
  
  @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer?) {
    tappedCellHandler?()
  }
}
