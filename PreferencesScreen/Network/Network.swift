//
//  Network.swift
//  PreferencesScreen
//
//  Created by Shibili Areekara on 24/05/21.
//

import Foundation

public enum RequestMethod : String {
    case GET = "GET"
    case POST = "POST"
}

public enum BaseUrl : String {
    case baseUrl = "http://213.136.192.12"
}

public enum RelativeUrl : String {
    case countryList = "/api/utilities/getCountryList"
    case teamsList = "/api/football/sports/getTeams"
    case liveNotifPref = "/api/NotifLive/getLiveNotifPref"
}

public enum ServiceStatus : String {
    case SUCCESS = "success"
    case FAILED = "failed"
    case SERVICE_ERROR = "Service Error"
    case ERROR = "Error"
}

private enum DataParameters : String {
    case CountryID = "CountryID"
    case TeamID = "TeamID"
}

private var _url : String = ""
private var _statusCode : Int = 0
private var _httpStatusCode:Int?
private var _timeOutInterval: Int = 15
private var _allowCelllarAccess:Bool = true
var _requestMethod:String = RequestMethod.POST.rawValue


//MARK:- Network Class to Handle API calls
open class Network :NSObject  {
    
    
    open class var timeOutInterval : Int {
        get {return _timeOutInterval}
        set {_timeOutInterval = newValue}
    }
    
    
    open class var allowCellularAccess : Bool {
        get {return _allowCelllarAccess}
        set {_allowCelllarAccess = newValue}
    }
    
    open func setConfigUrl(_ value:String) {
        _url = value;
    }

    open func requestMethod(_ value:String) {
        _requestMethod = value
    }
    
    
    func getCountries(_ completion:@escaping (_ data:Data?,_ action:String,_ serviceStatus:String) -> Void) {
        let url = BaseUrl.baseUrl.rawValue + RelativeUrl.countryList.rawValue
        guard let myUrl:URL = URL(string: url) else { return }
        
        let request = NSMutableURLRequest(url: myUrl)
        request.httpMethod = _requestMethod
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
                
        self.execute(request: request as URLRequest, { (data, response, error) in
            completion(data, response, error)
        })
    }
    
    func getTeams(countryID:Int, _ completion:@escaping (_ data:Data?,_ action:String,_ serviceStatus:String) -> Void) {
        let url = BaseUrl.baseUrl.rawValue + RelativeUrl.teamsList.rawValue
        guard let myUrl:URL = URL(string: url) else { return }
        
        let request = NSMutableURLRequest(url: myUrl)
        request.httpMethod = _requestMethod
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let parameters: [String: Any] = [
            DataParameters.CountryID.rawValue: ""//countryID
        ]
        request.httpBody = parameters.percentEscaped().data(using: .utf8)
        
        self.execute(request: request as URLRequest, { (data, response, error) in
            completion(data, response, error)
        })
    }
    
    func getLiveNotifPref(countryID:Int, teamID:String,_ completion:@escaping (_ data:Data?,_ action:String,_ serviceStatus:String) -> Void) {
        let url = BaseUrl.baseUrl.rawValue + RelativeUrl.liveNotifPref.rawValue
        guard let myUrl:URL = URL(string: url) else { return }
        
        let request = NSMutableURLRequest(url: myUrl)
        request.httpMethod = _requestMethod
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let parameters: [String: Any] = [
            DataParameters.CountryID.rawValue: countryID,
            DataParameters.TeamID.rawValue: teamID
        ]
        request.httpBody = parameters.percentEscaped().data(using: .utf8)
        
        self.execute(request: request as URLRequest, { (data, response, error) in
            completion(data, response, error)
        })
    }
    
    
    func execute(request: URLRequest, _ completion:@escaping (_ data:Data?,_ action:String,_ serviceStatus:String) -> Void) {
        
        let session = URLSession(configuration : sessionConfiguration())
        
        let task = session.dataTask(with: request as URLRequest){
        (data, response, error) in
            if  error != nil {
                print("error ==\(String(describing:  error?.localizedDescription))")
                completion(data, (error?.localizedDescription)!,ServiceStatus.FAILED.rawValue)
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                _httpStatusCode = httpResponse.statusCode
                print("http status code \(_httpStatusCode!)")
                if (_httpStatusCode == 200) {
                    completion(data, "",ServiceStatus.SUCCESS.rawValue)
                }
                else  if (_httpStatusCode == 500 )
                {
                    completion(data, ServiceStatus.SERVICE_ERROR.rawValue, ServiceStatus.FAILED.rawValue)
                }
                else  {
                    completion(data, ServiceStatus.ERROR.rawValue, ServiceStatus.FAILED.rawValue)
                }

            }
        }
        task.resume()
    }


    fileprivate func sessionConfiguration() -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = _allowCelllarAccess
        configuration.timeoutIntervalForRequest = TimeInterval(_timeOutInterval)
        configuration.timeoutIntervalForResource = 15
        return configuration
    }
    
}


private extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
            }
            .joined(separator: "&")
    }
}

private extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@"
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}


