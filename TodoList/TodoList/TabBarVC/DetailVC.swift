//
//  DetailVC.swift
//  TodoList
//
//  Created by 강인혜 on 2022/07/18.
//

import UIKit
import Alamofire

class DetailVC: UIViewController {

    @IBOutlet weak var lbPostTitle: UILabel!
    @IBOutlet weak var lbPostWriter: UILabel!
    @IBOutlet weak var txtViewContent: UITextView!
    @IBOutlet weak var lbLikes: UILabel!
    @IBOutlet weak var lbWrittenDate: UILabel!
    @IBOutlet weak var btnSuccess: UIButton!
    
    var result: [LikeModel] = []
    var refreshControl = UIRefreshControl()
    
    var id: Int = 0
    var postTitle: String = ""
    var postWriter: String = ""
    var txt: String = ""
    var likeCount: Int = 0
    var indexList = [MainPostModel]()
    var successResult: Bool? = false
    var createdDate: String = ""
    var likes: Bool = false


    override func viewDidLoad() {
        super.viewDidLoad()
        lbPostTitle.text = "\(postTitle)"
        lbPostWriter.text = "\(postWriter)"
        txtViewContent.text = "\(txt)"
        lbWrittenDate.text = "\(createdDate)"
        lbLikes.text = "\(likeCount)"
        
        
        btnSuccess.titleLabel?.textColor = UIColor(named: "MainColor")
        if (successResult == true) {
//            btnSuccess.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            
            let todoState = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .default)
            let successImage = UIImage(systemName: "checkmark.square.fill", withConfiguration: todoState)
            
            btnSuccess.setImage(successImage, for: .normal)
        }
        
        
        
        getHeartsInfo()
    }
    
    private func getHeartsInfo() {
        //        let url = "http://10.156.147.206:8080/post/main/like/\(id)" //학교
        let url = "http://13.125.180.241:8080/post/main/like/\(id)"
        var request = URLRequest(url: URL(string: url)!)
        request.method = .get
        request.setValue( "\(KeyChain.read(key: "token") ?? "")", forHTTPHeaderField: "AccessToken")

        
        AF.request(request).response { (response) in switch response.result {
            case .success:
                debugPrint(response)
                if let data = try? JSONDecoder().decode([LikeModel].self, from: response.data!){
                    DispatchQueue.main.async {
                        self.result = data

                        self.refreshControl = UIRefreshControl()
                        self.refreshControl.addTarget(self, action: #selector(self.pullToRefresh(_:)), for: .valueChanged)
                        self.refreshControl.endRefreshing() // 초기화 - refresh 종료
                        
                        
                    }
                }


            case .failure(let error):
                print(error)
                self.refreshControl = UIRefreshControl()
                self.refreshControl.addTarget(self, action: #selector(self.pullToRefresh(_:)), for: .valueChanged)
                self.refreshControl.endRefreshing() // 초기화 - refresh 종료
            

            }
        }
    }
    
    
    @objc func pullToRefresh(_ sender: Any) {
        getHeartsInfo()
        
        refreshControl.endRefreshing() // 초기화 - refresh 종료
    }
    
    
    @IBAction func btnLikes(_ sender: UIButton) {
        
////        if (self.already == true) {
////            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//            sender.titleLabel?.textColor = UIColor(named: "MainColor")
//            let config = UIImage.SymbolConfiguration(
//                pointSize: 20, weight: .regular, scale: .default)
//            let image = UIImage(systemName: "heart.fill", withConfiguration: config)
//            sender.setImage(image, for: .normal)
//
//            getReloadPost()
//        }
//
//        else {
//            //        sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//            sender.titleLabel?.textColor = UIColor(named: "MainColor")
//            let config = UIImage.SymbolConfiguration(
//                pointSize: 20, weight: .regular, scale: .default)
//            let image = UIImage(systemName: "heart", withConfiguration: config)
//            sender.setImage(image, for: .normal)
//
//            getReloadPost()
//        }
    }
}
