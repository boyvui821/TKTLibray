//
//  ResultViewController.swift
//  TKTLibrary
//
//  Created by Nguyen Hieu Trung on 9/10/20.
//  Copyright © 2020 NHTSOFT. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var firstHeader: BaseHeaderView!
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var resultTableView: UITableView!
    var strImageUrl: String?
    var imgPhoto: UIImage?
    
    var userSkinModel: UserSkinModel?{
        didSet{
            self.generalResult = userSkinModel?.faceData?.general
            self.specialResult = userSkinModel?.faceData?.special
            self.generalConclution = userSkinModel?.faceData?.generalConclution
            self.specialConclution = userSkinModel?.faceData?.specialConclution
            self.getAllEndData(model: userSkinModel)
        }
    }
    
    //GENERAL RESULT
    var generalResultData: [ResultData] = []
    //SPECIAL RESULT
    var specialResultData: [ResultData] = []
    //GENERAL CONCLUTION
    var generalConclutionData: [EndData] = []
    //SPECIAL CONCLUTION
    var arrSpecialConclution: [Conclution] = []
    
    var generalResult: Result?{
        didSet{
            var arrEndData:[EndData] = []
            guard let resultsData = generalResult?.data else {return}
            self.generalResultData = resultsData
            
            if resultsData.count > 0 {
                for item in resultsData{
                    if let arrData = item.data {
                        for endData in arrData{
                            arrEndData.append(endData)
                        }
                    }
                }
                self.arrGeneralData = arrEndData
            }
            
            DispatchQueue.main.async {
                let indexPath = IndexPath.init(row: 1, section: 0)
                self.resultTableView.reloadRows(at: [indexPath],
                                                with: .automatic)
            }
        }
    }
    
    var specialResult: Result?{
        didSet{
            var arrEndData:[EndData] = []
            guard let resultsData = specialResult?.data else {return}
            self.specialResultData = resultsData
            
            if resultsData.count > 0 {
                for item in resultsData{
                    if let arrData = item.data {
                        for endData in arrData{
                            arrEndData.append(endData)
                        }
                    }
                }
                self.arrSpecialData = arrEndData
            }
            
            DispatchQueue.main.async {
                let indexPath = IndexPath.init(row: 2, section: 0)
                self.resultTableView.reloadRows(at: [indexPath],
                                                with: .automatic)
            }
        }
    }
    
    var generalConclution: GeneralConclution?{
        didSet{
            guard let conclutions = generalConclution?.data else {return}
            self.generalConclutionData = conclutions
            
            DispatchQueue.main.async {
                let indexPath = IndexPath.init(row: 3, section: 0)
                self.resultTableView.reloadRows(at: [indexPath],
                                                with: .automatic)
            }
        }
    }
    
    var specialConclution: SpecialConclution? {
        didSet{
            guard let data = specialConclution?.data else {return}
            
            //            var arr:[Conclution] = []
            //            if data.count > 0 {
            //                for arrConclution in data{
            //                   arr += arrConclution
            //                }
            //            }
            //
            //            self.arrSpecialConclution = arr
            
            var arr:[Conclution] = []
            if data.count > 0 {
                for arrConclution in data{
                    for i in 0..<arrConclution.count{
                        if (i == (arrConclution.count - 1)){
                                                        arrConclution[i].isEndGroup = true
                        }
                        arr.append(arrConclution[i])
                    }
                }
            }
            
            self.arrSpecialConclution = arr
            
            
            DispatchQueue.main.async {
                let indexPath = IndexPath.init(row: 4, section: 0)
                self.resultTableView.reloadRows(at: [indexPath],
                                                with: .automatic)
            }
        }
    }
    
    //Result data cấp trong cùng
    var arrGeneralData:[EndData] = []
    var arrSpecialData: [EndData] = []
    var arrAllEndData: [EndData] = []{
        didSet{
            print("arrAllEndData: \(arrAllEndData.count)")
            DispatchQueue.main.async {
                let indexPath = IndexPath.init(row: 1, section: 0)
                self.resultTableView.reloadRows(at: [indexPath],
                                                with: .automatic)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFirstHeader()
        setupFirstHeaderAction()
        setupTableView()
        //        testAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hidenDefaultNavigation()
    }
    
    func setupFirstHeader(){
        firstHeader.setupHeader(title: "A.I Skin Analysis",
                                rightIcon: nil,
                                backgroundColor: UIColor.applicationColor,
                                heightConstraint: headerViewHeightConstraint)
        firstHeader.setIconTintColor(color: UIColor.white)
    }
    
    func setupFirstHeaderAction(){
        firstHeader.onHandleLeft {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func hidenDefaultNavigation(){
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setupTableView(){
        self.registerCell(name: "ResultImageTableViewCell")
        self.registerCell(name: "ResultGeneralTableViewCell")
        self.registerCell(name: "ResultSpecialTableViewCell")
        self.registerCell(name: "ConclutionGeneralTableViewCell")
        self.registerCell(name: "ConclutionSpecialTableViewCell")
        resultTableView.delegate = self
        resultTableView.dataSource = self
    }
    
    func registerCell(name: String){
        let bundle = Bundle(for: ResultViewController.self)
        resultTableView.register(UINib.init(nibName: name, bundle: bundle), forCellReuseIdentifier: name)
    }
    
    func getAllEndData (model: UserSkinModel?) {
        var arrEndData:[EndData] = []
        if let model = model{
            guard let general = model.faceData?.general else {return}
            guard let special = model.faceData?.special else {return}
            
            let generalEndData = self.getEndData(result: general)
            let specialEndData = self.getEndData(result: special)
            arrEndData = generalEndData + specialEndData
        }
        self.arrAllEndData = arrEndData
    }
    
    func getEndData(result: Result) ->[EndData]{
        var arrEndData:[EndData] = []
        guard let resultsData = result.data else {return arrEndData}
        if resultsData.count > 0 {
            for item in resultsData{
                if let arrData = item.data {
                    for endData in arrData{
                        arrEndData.append(endData)
                    }
                }
            }
            self.arrGeneralData = arrEndData
        }
        return arrEndData
    }
}

extension ResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ResultImageTableViewCell", for: indexPath) as? ResultImageTableViewCell{
                cell.setupData(imageUrl: self.strImageUrl ?? "",
                               data: self.arrAllEndData)
                return cell
            }
        }else if indexPath.row == 1{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ResultGeneralTableViewCell", for: indexPath) as? ResultGeneralTableViewCell{
                let title = self.generalResult?.title?.en ?? ""
                cell.setupTitle(title: title)
                cell.setupData(resultData: self.generalResultData)
                return cell
            }
        } else if indexPath.row == 2{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ResultSpecialTableViewCell", for: indexPath) as? ResultSpecialTableViewCell{
                let title = self.specialResult?.title?.en ?? ""
                
                cell.setupTitle(title: title)
                cell.setupData(resultData: self.specialResultData)
                return cell
            }
        } else if indexPath.row == 3 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ConclutionGeneralTableViewCell", for: indexPath) as? ConclutionGeneralTableViewCell{
                let title = self.generalConclution?.title?.en ?? ""
                
                cell.setupTitle(title: title)
                cell.setupData(data: self.generalConclutionData)
                return cell
            }
        }else if indexPath.row == 4 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ConclutionSpecialTableViewCell", for: indexPath) as? ConclutionSpecialTableViewCell{
                let title = self.specialConclution?.title?.en ?? ""
                
                cell.setupTitle(title: title)
                cell.setupData(data: self.arrSpecialConclution)
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
