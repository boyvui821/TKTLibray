//
//  ResultImageTableViewCell.swift
//  TKTLibrary
//
//  Created by Nguyen Hieu Trung on 9/10/20.
//  Copyright © 2020 NHTSOFT. All rights reserved.
//

import UIKit
protocol ResultImageTableViewCellDelegate {
    func reloadCell()
}

class ResultImageTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var moleSwitch: UISwitch!
    @IBOutlet weak var spotSwitch: UISwitch!
    @IBOutlet weak var acneSwitch: UISwitch!
    @IBOutlet weak var pimpleSwitch: UISwitch!
    @IBOutlet weak var blackHeadSwitch: UISwitch!
    
    var arrEndData: [EndData] = []{
        didSet{
            self.drawAcne(enabled: true)
            self.drawSpot(enabled: true)
            self.drawPimple(enabled: true)
            self.drawBlackHead(enabled: true)
            self.drawMole(enabled: true)
        }
    }
    
    let windowWidth = UIScreen.main.bounds.width
    let zoomSize: CGFloat = 1.2
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        switch sender {
        case moleSwitch:
            self.drawMole(enabled: sender.isOn)
            break
        case spotSwitch:
            self.drawSpot(enabled: sender.isOn)
            break;
        case acneSwitch:
            self.drawAcne(enabled: sender.isOn)
            break;
        case pimpleSwitch:
            self.drawPimple(enabled: sender.isOn)
            break;
        case blackHeadSwitch:
            self.drawBlackHead(enabled: sender.isOn)
            break;
        default:
            return
        }
    }
    
    
    func setupData(imageUrl: String,data: [EndData]){
        guard let url = URL(string: imageUrl) else {return}
        self.photoImageView?.load(url: url)
        
        self.arrEndData = data
    }
    
    func drawMole(enabled: Bool){
        if (enabled){
            self.drawByKey(key: SKIN_KEY.MOLE, color: UIColor.mole, tag: TKT_TAG.MOLE)
        }else{
            self.removeViewsByTag(tag: TKT_TAG.MOLE)
        }
    }
    
    func drawSpot(enabled: Bool){
        if (enabled){
            self.drawByKey(key: SKIN_KEY.SPOT, color: UIColor.spot, tag: TKT_TAG.SPOT)
        }else{
            self.removeViewsByTag(tag: TKT_TAG.SPOT)
        }
    }
    func drawAcne(enabled: Bool){
        if (enabled){
            drawByKey(key: SKIN_KEY.ACNE, color: UIColor.acne, tag: TKT_TAG.ACNE)
        }else{
            self.removeViewsByTag(tag: TKT_TAG.ACNE)
        }
        
    }
    func drawPimple(enabled: Bool){
        if (enabled){
            drawByKey(key: SKIN_KEY.PIMPLE, color: UIColor.pimple, tag: TKT_TAG.PIMPLE)
        }else{
            self.removeViewsByTag(tag: TKT_TAG.PIMPLE)
        }
        
    }
    func drawBlackHead(enabled: Bool){
        if (enabled){
            drawByKey(key: SKIN_KEY.BLACK_HEAD, color: UIColor.blackHead, tag: TKT_TAG.BLACK_HEAD)
        }else{
            self.removeViewsByTag(tag: TKT_TAG.BLACK_HEAD)
        }
    }
    
    func drawByKey(key: SKIN_KEY, color: UIColor, tag: TKT_TAG){
        let filter = arrEndData.first { (item) -> Bool in
            item.key == key.rawValue
        }
        
        guard let arr = filter?.drawArr else {return}
        for item in arr{
            self.drawRect(item: item, color: color, tag: tag)
        }
    }
    
    func drawRect(item: DrawRect, color: UIColor, tag: TKT_TAG){
        guard let left = item.left else {return}
        guard let top = item.top else {return}
        guard let width = item.width else {return}
        guard let height = item.height else {return}
        
        let v = UIView(frame: CGRect(x: left * windowWidth / DEFAULT_IMAGE_SIZE,
                                     y: top * windowWidth / DEFAULT_IMAGE_SIZE,
                                     width: width * windowWidth / DEFAULT_IMAGE_SIZE * zoomSize,
                                     height: height * windowWidth / DEFAULT_IMAGE_SIZE * zoomSize))
        
        v.layer.backgroundColor = color.cgColor
        v.layer.borderWidth = 5
        v.layer.borderColor = color.cgColor
        v.tag = tag.rawValue
        containerView.addSubview(v)
    }
    
    func removeViewsByTag(tag: TKT_TAG){
        for sub in containerView.subviews{
            let v = sub.viewWithTag(tag.rawValue)
            v?.removeFromSuperview()
        }
    }
}
