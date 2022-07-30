//
//  MyDetailVC.swift
//  TodoList
//
//  Created by 강인혜 on 2022/07/29.
//

import UIKit
import Alamofire

class MyDetailVC: UIViewController {
    @IBOutlet weak var lbMyPostTitle: UILabel!
    @IBOutlet weak var txtViewMyPostContent: UITextView!
    @IBOutlet weak var lbMyPostDate: UILabel!
    @IBOutlet weak var btnMyTodoState: UIButton!
    @IBOutlet weak var lbMyLikesCount: UILabel!
    @IBOutlet weak var myLikeBtn: UIButton!
    
    var likeResult = LikeModel()
    
    var myTitle: String = ""
    var myContent: String = ""
    var myID: Int = 0
    var date: String = ""
    var state: Bool = false
    var myLikesCount: Int = 0
    var liked: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(likeResult)
        
        if (likeResult.liked == true) {
            let likeState = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .default)
            let likedImage = UIImage(systemName: "heart.fill", withConfiguration: likeState)
            myLikeBtn.setImage(likedImage, for: .normal)
        }
        
        else if (likeResult.liked == false) {
            let notLiked = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .default)
            let notLikedImage = UIImage(systemName: "heart", withConfiguration: notLiked)
            myLikeBtn.setImage(notLikedImage, for: .normal)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lbMyPostTitle.text = "\(myTitle)"
        lbMyPostDate.text = "\(date)"
        txtViewMyPostContent.text = "\(myContent)"
        lbMyLikesCount.text = "\(myLikesCount)"
        
        btnMyTodoState.titleLabel?.textColor = UIColor(named: "MainColor")
        
        if (state == true) {
            let todoState = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .default)
            let successImage = UIImage(systemName: "checkmark.square.fill", withConfiguration: todoState)
            
            btnMyTodoState.setImage(successImage, for: .normal)
        }
    }
    
    private func getHeartsInfo() {
//        let url = "http://10.156.147.206:8080/post/main/like/\(id)" //학교
        let url = "http://13.125.180.241:8080/post/main/like/\(myID)"
        var request = URLRequest(url: URL(string: url)!)
        request.method = .get
        request.setValue( "\(KeyChain.read(key: "token") ?? "")", forHTTPHeaderField: "AccessToken")


        AF.request(request).response { (response) in switch response.result {
            case .success:
                debugPrint(response)
                if let data = try? JSONDecoder().decode(LikeModel.self, from: response.data!){
                    DispatchQueue.main.async {
                        self.likeResult = data
                        
                        self.myLikesCount = self.likeResult.like_count
                        self.lbMyLikesCount.text = "\(self.likeResult.like_count)"
                        self.liked = self.likeResult.liked
                        
                        print(self.likeResult)
                    }
                }


            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    
    @IBAction func btnToRevise(_ sender: UIButton) {
        guard let toRevise = self.storyboard?.instantiateViewController(withIdentifier: "ReviseVC") as? ReviseVC else { return }
        
        toRevise.reviseTitle = "\(lbMyPostTitle.text!)"
        toRevise.reviseContent = "\(txtViewMyPostContent.text!)"
        toRevise.reviseState = state
        toRevise.reviseID = myID
        
        
        navigationController?.pushViewController(toRevise, animated: true)
    }
    
    @IBAction func btnMyPostLike(_ sender: UIButton) {
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
