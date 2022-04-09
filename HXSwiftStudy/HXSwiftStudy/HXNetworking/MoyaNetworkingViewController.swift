//
//  MoyaNetworkingViewController.swift
//  HXSwiftStudy
//
//  Created by HuXin on 2021/8/4.
//

import UIKit
import SnapKit
import Moya

class MoyaNetworkingViewController: UIViewController {
    let provider = MoyaProvider<netwokingAPI>()
    var progressView = UIProgressView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Moya"
        tabBarItem = UITabBarItem(title: "Moya", image: UIImage(named: "networking"), tag: 102)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        loadUI()
        
        provider.request(.jsonDataOnly) { result in
            switch result {
             case let .success(moyaResponse):
                let jsonData = try? moyaResponse.mapJSON()
                print(jsonData as Any)
             case .failure(_): break
             }
        }
    }
    
    @objc
    func startDownload() {
        let saveName = "video.mp4"
        provider.request(.downTask(saveName: saveName)) { progress in
            print(progress.progress)
            self.progressView.progress = Float(progress.progress)
        } completion: { result in
            switch result {
              case .success:
                  let localLocation: URL = DefaultDownloadDir.appendingPathComponent(saveName)
                  print("下载完毕！保存地址：\(localLocation)")
              case let .failure(error):
                   print(error)
            }
        }
    }
    
    @objc
    func resumeDownload() {
        progressView.progress = 0
    }
    
    func loadUI() {
        let startButton = UIButton()
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        startButton.layer.borderWidth = 2.0
        startButton.layer.cornerRadius = 8.0
        startButton.layer.borderColor = UIColor.black.cgColor
        startButton.addTarget(self, action: #selector(startDownload), for: .touchUpInside)
        
        view.addSubview(startButton)
        
        let resumeButton = UIButton()
        resumeButton.setTitle("Resume", for: .normal)
        resumeButton.setTitleColor(.black, for: .normal)
        resumeButton.layer.borderWidth = 2.0
        resumeButton.layer.cornerRadius = 8.0
        resumeButton.layer.borderColor = UIColor.black.cgColor
        resumeButton.addTarget(self, action: #selector(resumeDownload), for: .touchUpInside)
        
        view.addSubview(resumeButton)
        
        progressView.progressViewStyle = .default
        progressView.tintColor = .red
        progressView.trackTintColor = .black
        
        view.addSubview(progressView)
        
        startButton.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.left.equalTo(80)
            make.height.equalTo(60)
            make.width.equalTo(80)
        }
        
        resumeButton.snp.makeConstraints { (make) in
            make.top.equalTo(startButton)
            make.right.equalTo(-80)
            make.width.equalTo(startButton)
            make.height.equalTo(startButton)
        }
        
        progressView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.view).offset(60)
            make.centerX.equalTo(self.view)
            make.height.equalTo(4)
            make.width.equalTo(300)
        }
    }
}

enum netwokingAPI {
    case jsonDataOnly
    case downTask(saveName: String)
}

extension netwokingAPI:TargetType {
    var baseURL: URL {
        switch self {
        case .jsonDataOnly:
            return URL(string: "http://yapi.baijiashilian.com")!
        case .downTask(_):
            return URL(string: "http://vfx.mtime.cn")!
        }
    }
    
    var path: String {
        switch self {
        case .jsonDataOnly:
            return "/mock/11/orgapp/weclass/playbackList"
        case .downTask(_):
            return "/Video/2015/07/04/mp4/150704102229172451_480.mp4"
        }
    }
    
        var method: Moya.Method {
        switch self {
        case .jsonDataOnly:
            return .get
        case .downTask(_):
            return .get
        }
    }
    
    public var validate: Bool {
          return false
      }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .jsonDataOnly:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        case .downTask(_):
            return .downloadDestination(DefaultDownloadDestination)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

//定义下载的DownloadDestination（不改变文件名，同名文件不会覆盖）
let DefaultDownloadDestination: DownloadDestination = { temporaryURL, response in
    return (DefaultDownloadDir.appendingPathComponent(response.suggestedFilename!),[.removePreviousFile])
}
 
//默认下载保存地址（用户文档目录）
let DefaultDownloadDir: URL = {
    let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
    
    return URL(fileURLWithPath: path!)
}()

