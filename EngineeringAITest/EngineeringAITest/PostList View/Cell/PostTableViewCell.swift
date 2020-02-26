//
//  PostTableViewCell.swift
//  EngineeringAITest
//
//  Created by PCQ188 on 26/02/20.
//  Copyright © 2020 PCQ188. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var switchToggle: UISwitch!
 
    var hit: Hits? {
        didSet {
            if let hit = hit {
                self.labelTitle.text = hit.title ?? ""
                self.labelDate.text = Utility.formatedDate(date: hit.created_at ?? "")
                self.switchToggle.isOn = hit.isSelected
            }
        }
    }

}
