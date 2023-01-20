//
//  TableViewCell.swift
//  JsonApiDemo4
//
//  Created by Rachana Pandit on 22/11/22.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lblId:UILabel!
    @IBOutlet weak var lblPrice:UILabel!
    @IBOutlet weak var imgProduct:UIImageView!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblDescription:UILabel!
//  @IBOutlet weak var lblCategory:UILabel!
    @IBOutlet weak var lblRate:UILabel!
    @IBOutlet weak var lblCount:UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        lblDescription.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
