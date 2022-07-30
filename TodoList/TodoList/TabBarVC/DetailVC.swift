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
    
    var likeResult = LikeModel()
    
    var id: Int = 0
    var postTitle: String = ""
    var postWriter: String = ""
    var txt: String = ""
    var likeCount: Int = 1
    var successResult: Bool? = false
    var createdDate: String = ""
    var liked: Bool? = true


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        
        
        print(likeResult)
        
        if (likeResult.liked == true) {
            let likeState = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .default)
            let likedImage = UIImage(systemName: "heart.fill", withConfiguration: likeState)
            likeBtn.setImage(likedImage, for: .normal)
        }
        
        else if (likeResult.liked == false) {
            let notLiked = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .default)
            let notLikedImage = UIImage(systemName: "heart", withConfiguration: notLiked)
            likeBtn.setImage(notLikedImage, for: .normal)
        }
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
                if let data = try? JSONDecoder().decode(LikeModel.self, from: response.data!){
                    DispatchQueue.main.async {
                        self.likeResult = data
                        
                        self.likeCount = self.likeResult.like_count
                        self.lbLikes.text = "\(self.likeResult.like_count)"
                        self.liked = self.likeResult.liked
                        
                        print(self.likeResult)
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
        
        if (likeResult.liked == true) {
            sender.titleLabel?.textColor = UIColor(named: "MainColor")
            let config = UIImage.SymbolConfiguration(
                pointSize: 20, weight: .regular, scale: .default)
            let image = UIImage(systemName: "heart", withConfiguration: config)
            sender.setImage(image, for: .normal)
        }
        
        else if (likeResult.liked == false) {
            sender.titleLabel?.textColor = UIColor(named: "MainColor")
            let config = UIImage.SymbolConfiguration(
                pointSize: 20, weight: .regular, scale: .default)
            let image = UIImage(systemName: "heart.fill", withConfiguration: config)
            sender.setImage(image, for: .normal)
        }
    }
}
