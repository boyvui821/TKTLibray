//
//  UserSkinModel.swift
//  TKTLibrary
//
//  Created by Nguyen Hieu Trung on 9/9/20.
//  Copyright © 2020 NHTSOFT. All rights reserved.
//

import Foundation
import ObjectMapper

class UserSkinModel: Mappable{
    var email: String?
    var faceData: FaceData?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.email           <- map["data.email"]
        self.faceData        <- map["data.facedata"]
    }
}

class FaceData: Mappable{
    
    var general:Result?
    var special:Result?
    var generalConclution: GeneralConclution?
    var specialConclution: SpecialConclution?
    var imageInfo: ImageInfo?
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        self.general            <- map["generalResult"]
        self.special            <- map["specialResult"]
        self.imageInfo          <- map["image_info"]
        self.generalConclution  <- map["generalConclusion"]
        self.specialConclution  <- map["specialConclusion"]
    }
}

class ImageInfo: Mappable{
    var url: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        self.url        <- map["url"]
    }
}

class Result: Mappable{
    var title: ResultTitle?
    var data: [ResultData]?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.title        <- map["title"]
        self.data        <- map["data"]
    }
}

class ResultTitle: Mappable{
    var en: String?
    var vi: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.en        <- map["en"]
        self.vi        <- map["vi"]
    }
}

class ResultData: Mappable{
    var title: ResultTitle?
    var description: ResultDescription?
    var data: [EndData]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.title              <- map["title"]
        self.description        <- map["descript"]
        self.data               <- map["data"]
    }
}

class EndData: Mappable{
    var valueEN: String?
    var valueVI: String?
    var key: String?
    var value: String?
    var drawArr: [DrawRect]?
    
    required init?(map: Map) {
        
    }
    
    init(valueEN:String?, valueVI:String?, key:String?, value:String?, drawArr: [DrawRect]?) {
        self.valueEN = valueEN
        self.valueVI = valueVI
        self.key = key
        self.value = value
        self.drawArr = drawArr
    }
    
    func mapping(map: Map) {
        self.valueEN        <- map["valueEN"]
        self.valueVI        <- map["valueVI"]
        self.key            <- map["key"]
        self.value          <- map["value"]
        self.drawArr        <- map["drawArr"]
    }
}

class DrawRect: Mappable{
    var height: CGFloat?
    var left: CGFloat?
    var top: CGFloat?
    var width: CGFloat?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.height     <- map["height"]
        self.left       <- map["left"]
        self.top        <- map["top"]
        self.width      <- map["width"]
    }
}

class ResultDescription: Mappable{
    var en: String?
    var vi: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.en     <- map["en"]
        self.vi       <- map["vi"]
    }
}

class GeneralConclution: Mappable{
    var title: ResultTitle?
    var data: [EndData]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.title     <- map["title"]
        self.data       <- map["data"]
    }
}

class SpecialConclution: Mappable {
    var title: ResultTitle?
//    var data: Array<Array<Conclution>>?
    var data: [[Conclution]] = []
    
    required init?(map: Map) {
//        mapping(map: map)
    }
    
    func mapping(map: Map) {
        self.title     <- map["title"]
        self.data       <- map["data"]
    }
}

class Conclution: Mappable{
    var title: ResultTitle?
    var data: ConclutionData?
    var isEndGroup: Bool = false
    required init?(map: Map) {
//         mapping(map: map)
    }
    
    func mapping(map: Map) {
        self.title     <- map["title"]
        self.data       <- map["data"]
    }
    
}

class ConclutionData: Mappable {
    var en:[String]?
    var vi: [String]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.en     <- map["en"]
        self.vi       <- map["vi"]
    }
}


