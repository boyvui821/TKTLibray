//
//  SelectionView.swift
//  TKTLibrary
//
//  Created by Nguyen Hieu Trung on 9/9/20.
//  Copyright © 2020 NHTSOFT. All rights reserved.
//

import UIKit

public protocol SelectionViewDelegate {
    func onSelect(index: Int)
}

public class SelectionView: BaseView {

    @IBOutlet weak var cameraLabel: UILabel!
    @IBOutlet weak var takeLabel: UILabel!
    @IBOutlet weak var filesLabel: UILabel!
    @IBOutlet weak var uploadLabel: UILabel!
    
    var delegate: SelectionViewDelegate?
    
    @IBAction func onTakePhoto(_ sender: UIButton) {
        delegate?.onSelect(index: 0)
    }
    
    @IBAction func onUploadFace(_ sender: UIButton) {
        delegate?.onSelect(index: 1)
    }
}
