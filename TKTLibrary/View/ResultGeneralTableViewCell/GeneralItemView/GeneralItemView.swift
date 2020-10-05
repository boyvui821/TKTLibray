//
//  GeneralItemView.swift
//  TKTLibrary
//
//  Created by Nguyen Hieu Trung on 9/30/20.
//  Copyright © 2020 NHTSOFT. All rights reserved.
//

import UIKit

class GeneralItemView: BaseView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    func setupData(data: ResultData){
        if appLanguage == .VI{
            titleLabel.text = data.title?.vi
        }else{
            titleLabel.text = data.title?.en
        }
        
        guard let endData = data.data else {return}
        var str = ""
        for item in endData{
            var value = ""
            if appLanguage == .VI{
                value = item.valueVI!
            }else{
                value = item.valueEN!
            }
             str += "\n" + " - " + value
        }
        infoLabel.text = str
    }
}
