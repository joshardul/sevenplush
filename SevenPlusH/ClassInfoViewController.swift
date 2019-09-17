//
//  ClassInfoViewController.swift
//  SevenPlusH
//
//  Created by Shardul Joshi on 8/1/18.
//  Copyright © 2018 N/A. All rights reserved.
//

import UIKit

class ClassInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Variables to store inforation necessary for the view
    var blockTitle: String!
    var teacherName: String!
    var roomNumber: String!
    var blockColor: UIColor!
    
    // Labels from view controller
    @IBOutlet weak var blockTitleLabel: UILabel!
    @IBOutlet weak var teacherNameLabel: UILabel!
    @IBOutlet weak var roomNumberLabel: UILabel!
    
    // Loads info received from previous view controller
    override func viewWillAppear(_ animated: Bool) {
        blockTitleLabel.backgroundColor = blockColor
        blockTitleLabel.text = blockTitle
        teacherNameLabel.text = teacherName
        roomNumberLabel.text = roomNumber
    }
}
