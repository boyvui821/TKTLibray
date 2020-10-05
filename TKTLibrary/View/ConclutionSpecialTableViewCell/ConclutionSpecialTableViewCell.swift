//
//  ConclutionSpecialTableViewCell.swift
//  TKTLibrary
//
//  Created by Nguyen Hieu Trung on 9/11/20.
//  Copyright © 2020 NHTSOFT. All rights reserved.
//

import UIKit

class ConclutionSpecialTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var headerView: GradientView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContentView: UIView!
    
    @IBOutlet weak var scrollConstraintHeight: NSLayoutConstraint!
    
    @IBOutlet weak var scrollContentConstraintHeight: NSLayoutConstraint!
    var items: [Conclution] = []{
        didSet{
            var height:CGFloat = 0
            self.removeExistItems()
            if items.count > 0 {
                self.addItems()
                for item in arrItemView {
                    height = height + item.bounds.height
                }
                height = height + 20 + 20
            }
            scrollView.contentSize = CGSize(width: scrollContentView.bounds.width,
                                            height: height)
            scrollContentConstraintHeight.constant = height
            scrollConstraintHeight.constant = height
        }
    }
    
    var arrItemView: [ConclutionSpecialItemView] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setupScroll()
    }
    
    func setupUI() {
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.formBorder.cgColor
        containerView.layer.cornerRadius = 12
        headerView.layer.cornerRadius = 15
        headerView.setGradientColor(colors:[
            UIColor(hexString: "#fc8dac") ?? UIColor.white,
            UIColor(hexString: "#e7d9ef") ?? UIColor.white,
        ])
        
    }
    
    func setupScroll(){
        scrollView.isScrollEnabled = false
        scrollView.contentInset = UIEdgeInsets(top: 20,
                                               left: 0,
                                               bottom: 20,
                                               right: 0)
    }
    
    func setupTitle(title: String){
        self.headerLabel.text = title
    }
    
    func setupData(data: [Conclution]){
        self.items = data
    }
    
    func addItems () {
        for i in 0..<items.count{
            let itemView = ConclutionSpecialItemView()
            itemView.setupData(data: items[i])
            self.scrollContentView.addSubview(itemView)
            
            itemView.translatesAutoresizingMaskIntoConstraints = false
            itemView.leftAnchor.constraint(equalTo: scrollContentView.leftAnchor).isActive = true
            itemView.rightAnchor.constraint(equalTo: scrollContentView.rightAnchor).isActive = true
            if i == 0 {
                scrollContentView.addConstraint(NSLayoutConstraint(item: itemView, attribute: .top, relatedBy: .equal, toItem: self.scrollContentView, attribute: .top, multiplier: 1, constant: 0))
            }else if i == items.count - 1 {
                scrollContentView.addConstraint(NSLayoutConstraint(item: itemView, attribute: .top, relatedBy: .equal, toItem: self.arrItemView[i-1], attribute: .bottom, multiplier: 1, constant: 0))
            }else{
                scrollContentView.addConstraint(NSLayoutConstraint(item: itemView, attribute: .top, relatedBy: .equal, toItem: self.arrItemView[i-1], attribute: .bottom, multiplier: 1, constant: 0))
            }
            
            itemView.layoutSubviews()
            itemView.layoutIfNeeded()
            self.layoutIfNeeded()
            self.arrItemView.append(itemView)
        }
    }
    
    func removeExistItems(){
        arrItemView = []
        for sub in scrollContentView.subviews {
            sub.removeFromSuperview()
        }
    }
}
