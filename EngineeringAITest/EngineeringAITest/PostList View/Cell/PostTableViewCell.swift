//
//  PostTableViewCell.swift
//  EngineeringAITest
//
//  Created by PCQ188 on 26/02/20.
//  Copyright © 2020 PCQ188. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var labelDate: UILabel!
    @IBOutlet weak var switchToggle: UISwitch!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
