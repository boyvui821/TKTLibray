//
//  GeneralItemTableViewCell.swift
//  TKTLibrary
//
//  Created by Nguyen Hieu Trung on 9/11/20.
//  Copyright © 2020 NHTSOFT. All rights reserved.
//

import UIKit

class GeneralItemTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupData(data: EndData){
        if appLanguage == .VI{
            titleLabel.text = data.valueVI
        }else{
            titleLabel.text = data.valueEN
        }
    }
}
