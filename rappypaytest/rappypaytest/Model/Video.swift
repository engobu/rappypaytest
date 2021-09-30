//
//  Video.swift
//  rappypaytest
//
//  Created by Enar GoMez on 29/09/21.
//

import Foundation

class Video: NSObject {

    var id: String = ""
    var iso_31661: String = ""
    var iso_6391: String = ""
    var key: String = ""
    var name: String = ""
    var official: Int = 0
    var publishedAt: String = ""
    var site: String = ""
    var size: Int = 0
    var type: String = ""
    
    
    override init() {
        
    }
    
    init( id: String, iso_31661: String, iso_6391: String,key: String, name: String,official: Int , publishedAt: String,site: String,size: Int,type: String ){
        super.init()
        self.id = id
        self.iso_31661 = iso_31661
        self.iso_6391 = iso_6391
        self.key = key
        self.name = name
        self.official = official
        self.publishedAt = publishedAt
        self.site = site
        self.size = size
        self.type = type
    }
    
    convenience init(dicVideo: NSDictionary) {
        
        let id = dicVideo["id"] as? String ?? ""
        let iso_31661 = dicVideo["iso_3166_1"] as? String ?? ""
        let iso_6391 = dicVideo["iso_639_1"] as? String ?? ""
        let key = dicVideo["key"] as? String ?? ""
        let name = dicVideo["name"] as? String ?? ""
        
        let official = dicVideo["official"] as? Int ?? 0
        let publishedAt = dicVideo["published_at"] as? String ?? ""
        let site = dicVideo["site"] as? String ?? ""
        let size = dicVideo["size"] as? Int ?? 0
        let type = dicVideo["type"] as? String ?? ""
    
        self.init(id: id, iso_31661: iso_31661, iso_6391: iso_6391, key: key, name: name, official: official ,publishedAt: publishedAt, site: site, size: size, type: type )
        
    }
    
    var youtubeURL: URL? {
        guard site == "YouTube" else {
            return nil
        }
        return URL(string: "https://youtube.com/watch?v=\(key)")
    }
    
    var hasYouTuve: Bool {
        return key != "" && site == "YouTube"
    }

}

