//
//  ApiService.swift
//  rappypaytest
//
//  Created by Enar GoMez on 26/09/21.
//

import Foundation
import UIKit


enum Method: Int{
    case get = 0
    case post = 1
    case put = 2
    case delete = 3
}

enum ResponseCodeEnum: Int{
    case invalidHeader = 400
    case unauthorized = 401
    case notFound = 404
    case serviceUnavailable = 503
    case internalServerError = 500
    case ok = 200
    
}

class ApiService: NSObject, URLSessionDelegate {
    
    private let apiKey = "6e0c54baadc1babba00582d82b81b039"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private var currentTask: URLSessionTask!
    private let timeOut = 60
    private let responseEmpty = [[String:AnyObject]]() as AnyObject
    var responseIsDictionary = true
    
    func get(_  endPoint:String, postCompleted : @escaping (_ succeeded: Bool, _ msg: String, _ data: AnyObject) -> ()) {
        self.connectionToServer(endPoint: endPoint, postCompleted: postCompleted)
    }
    
    
    /**
     * Métodos basicos para el consumo de servicios web (REST)
     */
    func connectionToServer(endPoint:String, postCompleted : @escaping (_ succeeded: Bool, _ msg: String, _ data: AnyObject) -> ()) {
        
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.url = URL(string: "\(baseAPIURL)/\(endPoint)")
        let interval:TimeInterval = TimeInterval.init(timeOut)
        
        let urlconfig = URLSessionConfiguration.ephemeral
        urlconfig.timeoutIntervalForRequest = interval
        urlconfig.timeoutIntervalForResource = interval
        let session = Foundation.URLSession(configuration: urlconfig, delegate: self, delegateQueue: nil)
        request.timeoutInterval = interval
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        self.currentTask = session.dataTask(with: request as URLRequest) {
            (data, response, error)  in
            self.handleResponse(response, dataResponse: data, error: error as NSError?, postCompleted: postCompleted)
        }
        self.currentTask!.resume()
        
    }
    
    
    
    /**
     * Permite manejar la respuesta, y realizando un casteo en caso de que existan errores.
     */
    func handleResponse(_ response:URLResponse?, dataResponse: Data?, error: NSError?, postCompleted : @escaping (_ succeeded: Bool, _ msg: String, _ data: AnyObject) -> ()){
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            if error == nil {
                if(dataResponse != nil){
                    
                    var jsonResult:NSMutableCopying?
                    var hasResult = 0
                    do {
                        
                        if(self.responseIsDictionary){
                            jsonResult = try(JSONSerialization.jsonObject(with: dataResponse!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary)!
                            hasResult = ((jsonResult as? NSDictionary)?.count)!
                        }
                        else{
                            do {
                                if let json = try JSONSerialization.jsonObject(with: dataResponse!, options: []) as? [String: Any] {
                                    hasResult = 1
                                    jsonResult = json as NSMutableCopying
                                    
                                }
                            } catch let error as NSError {
                                print("Failed to load: \(error.localizedDescription)")
                            }
                        }
                        
                        if (hasResult > 0) {
                            //Se encontraron datos
                            postCompleted(true, "", jsonResult!)
                        } else {
                            //Respuesta sin datos
                            postCompleted(true, "", self.responseEmpty)
                        }
                    } catch _ as NSError {
                        postCompleted(false, "", self.responseEmpty)
                    }
                    
                }else{
                    postCompleted(false, "", self.responseEmpty)
                }
            }
            else{
                postCompleted(false, "", self.responseEmpty)
            }
            
        })
    }
}
