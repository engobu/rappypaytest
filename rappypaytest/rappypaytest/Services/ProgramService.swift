//
//  ProgramService.swift
//  rappypaytest
//
//  Created by Enar GoMez on 26/09/21.
//

import Foundation

class ProgramService
{
    let apiService: ApiService = ApiService()
    let apiKey:String = "?api_key=6e0c54baadc1babba00582d82b81b039&language=en-ES"
    
    
    func getPopular(_ type: ProgramTypeEnum, _ onCompleted: @escaping(_ succeded:Bool, _ msg: String, _ data:[Program])->()){
        getPrograms(type, EndPointsEnum.Popular) { (success, msg, data) in
            onCompleted(success,msg, data)
        }
    }
    func getTopRated(_ type: ProgramTypeEnum, _ onCompleted: @escaping(_ succeded:Bool, _ msg: String, _ data:[Program])->()){
        getPrograms(type, EndPointsEnum.TopRated) { (success, msg, data) in
            onCompleted(success,msg, data)
        }
    }
    func getUpcoming(_ type: ProgramTypeEnum, _ onCompleted: @escaping(_ succeded:Bool, _ msg: String, _ data:[Program])->()){
        let endPoint: EndPointsEnum!
        if type == .Movie {
            endPoint = EndPointsEnum.Upcoming
        }else{
            endPoint = EndPointsEnum.OnTheAir
        }
        getPrograms(type, endPoint) { (success, msg, data) in
            onCompleted(success,msg, data)
        }
    }
    
    private func getPrograms(_ type: ProgramTypeEnum, _ endpoint: EndPointsEnum ,_ onCompleted: @escaping(_ succeded:Bool, _ msg: String, _ data:[Program])->()){
        let endPoint = "\(type.rawValue)/\(endpoint.rawValue)\(apiKey)&page=1"
        apiService.responseIsDictionary = true
        apiService.connectionToServer(endPoint: endPoint) { (success, msg, data) in
            if(success){
                let dic = data as! NSDictionary
                let arrData: NSArray = dic["results"] as? NSArray ?? []
                var arrDataEntity: [Program] = []
                for element in arrData{
                    arrDataEntity.append(Program(dicProgram: element as! NSDictionary))
                }
                onCompleted(true, msg, arrDataEntity)
            }else{
                onCompleted(false, msg, [])
            }
        }
    }
    
    func getProgramDetail(_ type: ProgramTypeEnum, _ id: Int ,_ onCompleted: @escaping(_ succeded:Bool, _ msg: String, _ data:[Video])->()){
        let endPoint = "\(type.rawValue)/\(id)\(apiKey)&append_to_response=videos"
        apiService.responseIsDictionary = false
        apiService.connectionToServer(endPoint: endPoint) { (success, msg, data) in
            if(success){
                let dicVideo =  data["videos"] as? NSDictionary ?? [:]
                let arrData: NSArray = dicVideo["results"] as? NSArray ?? []
                var arrVideo: [Video] = []
                for element in arrData{
                    arrVideo.append(Video(dicVideo: element as! NSDictionary))
                }
                onCompleted(true, msg, arrVideo)
            }else{
                onCompleted(false, msg,  [])
            }
        }
    }
    
}
