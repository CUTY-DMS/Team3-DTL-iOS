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
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var btnSuccess: UIButton!
    
    var postDetail = DetailModel()
    var likeResult = LikeModel()
    
    var id: Int = 0
    var postTitle: String = ""
    var postWriter: String = ""
    var txt: String = ""
    var likeCount: Int = 0
    var successResult: Bool = false
    var createdDate: String = ""


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getPostDetail()

        lbPostTitle.text = "\(postTitle)"
        lbPostWriter.text = "\(postWriter)"
        txtViewContent.text = "\(txt)"
        lbWrittenDate.text = "\(createdDate)"
        lbLikes.text = "\(likeCount)"
        
        if (successResult == true) {
            successState()
        }
        
    }
    
    
    private func getPostDetail() {
//        let url = "http://10.156.147.206:8080/post/\(id)" //학교
        let url = "http://13.209.66.51:8080/post/\(id)"
        var request = URLRequest(url: URL(string: url)!)
        request.method = .get
        request.setValue( "\(KeyChain.read(key: "token") ?? "")", forHTTPHeaderField: "AccessToken")

        AF.request(request).response { (response) in switch response.result {
            case .success:
                debugPrint(response)
                if let data = try? JSONDecoder().decode(DetailModel.self, from: response.data!){
                    DispatchQueue.main.async {
                        self.postDetail = data
                        
                        if (self.postDetail.liked == true) {
                            self.likedTrue()
                        }
                        else if (self.postDetail.liked == false) {
                            self.likedFalse()
                        }
                    }
                }
            
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getHeartsInfo() {
//        let url = "http://10.156.147.206:8080/post/main/like/\(id)" //학교
        let url = "http://13.209.66.51:8080/post/main/like/\(id)"
        var request = URLRequest(url: URL(string: url)!)
        request.method = .get
        request.setValue( "\(KeyChain.read(key: "token") ?? "")", forHTTPHeaderField: "AccessToken")

        AF.request(request).response { (response) in switch response.result {
            case .success:
                debugPrint(response)
                if let data = try? JSONDecoder().decode(LikeModel.self, from: response.data!){
                    DispatchQueue.main.async {
                        self.likeResult = data
                        
                        self.likeCount = self.likeResult.like_count
                        self.lbLikes.text = "\(self.likeResult.like_count)"
                        
                        if (self.likeResult.liked == true) {
                            self.likedTrue()
                        }
                        else if (self.likeResult.liked == false) {
                            self.likedFalse()
                        }
                    }
                }
            
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    @IBAction func btnLikes(_ sender: UIButton) {
        getHeartsInfo()
        
        print(likeResult)
        
    }
    
    
    
    func successState() {
        btnSuccess.titleLabel?.textColor = UIColor(named: "MainColor")
        
        let todoState = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .default)
        let successImage = UIImage(systemName: "checkmark.square.fill", withConfiguration: todoState)
        btnSuccess.setImage(successImage, for: .normal)
    }
    
    func likedTrue() {
        likeBtn.titleLabel?.textColor = UIColor(named: "MainColor")
        let config = UIImage.SymbolConfiguration(
            pointSize: 20, weight: .regular, scale: .default)
        let image = UIImage(systemName: "heart.fill", withConfiguration: config)
        likeBtn.setImage(image, for: .normal)

    }
    
    func likedFalse() {
        likeBtn.titleLabel?.textColor = UIColor(named: "MainColor")
        let config = UIImage.SymbolConfiguration(
            pointSize: 20, weight: .regular, scale: .default)
        let image = UIImage(systemName: "heart", withConfiguration: config)
        likeBtn.setImage(image, for: .normal)
    }
}
