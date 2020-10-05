//
//  ConclutionSpecialItemView.swift
//  TKTLibrary
//
//  Created by Nguyen Hieu Trung on 9/30/20.
//  Copyright © 2020 NHTSOFT. All rights reserved.
//

import UIKit

class ConclutionSpecialItemView: BaseView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    
    func setupData(data: Conclution){
        
        if appLanguage == .VI{
            titleLabel.text = data.title?.vi
            guard let info = data.data?.vi else {return}
            self.settupInfo(info: info)
        }else{
            titleLabel.text = data.title?.en
            guard let info = data.data?.en else {return}
            self.settupInfo(info: info)
        }
        lineView.isHidden = !data.isEndGroup
    }
    
    private func settupInfo(info: [String]){
        if info.count > 0{
            var str = ""
            for item in info{
                var value = ""
                if appLanguage == .VI{
                    value = item
                }else{
                    value = item
                }
                str += "\n" + " - " + value
            }
            infoLabel.text = str
        }
    }
}


