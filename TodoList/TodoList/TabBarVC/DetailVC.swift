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
    @IBOutlet weak var btnSuccess: UIButton!
    
    var id: Int = 0
    var postTitle: String = ""
    var postWriter: String = ""
    var txt: String = ""
    var likeCount: Int = 0
    var indexList = [MainPostModel]()
    var successResult: Bool = false
    var indexValue = 0
    var likes: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        lbPostTitle.text = "\(postTitle)"
        lbPostWriter.text = "\(postWriter)"
        txtViewContent.text = "\(txt)"
//        getPostDetail()
        lbLikes.text = "\(likeCount)"
        
        if (successResult == true) {
            btnSuccess.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        }
    }
    
    
    
    @IBAction func btnLikes(_ sender: UIButton) {
//        sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        sender.titleLabel?.textColor = UIColor(named: "MainColor")
        let config = UIImage.SymbolConfiguration(
                    pointSize: 20, weight: .regular, scale: .default)
        let image = UIImage(systemName: "heart.fill", withConfiguration: config)
        sender.setImage(image, for: .normal)
        
        
//        let url = "http://10.156.147.206:8080/post/main/like/\(id)" //학교
////        let url = "http://13.125.180.241:8080/post"
//        var request = URLRequest(url: URL(string: url)!)
//        request.method = .get
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.timeoutInterval = 10
//
//
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        request.setValue( "\(KeyChain.read(key: "accessToken") ?? "")", forHTTPHeaderField: "Authorization")
//
//        AF.request("http://10.156.147.206:9090/post/main/like/\(id)", method: .get)
//                    .validate(statusCode: 200..<500)
//                    .responseData {
//                        response in switch response.result {
//                        case.success:
//                            print(response.result)
//                            debugPrint(response)
//                            if let data = try? JSONDecoder().decode([MainPostModel].self, from: response.data!){
//                                print(data)
//                                DispatchQueue.main.async {
//                                    self.result = data
//                                }
//                            }
//                        case .failure(let error):
//                            print(error)
//                        }
//                    }
            }
}
