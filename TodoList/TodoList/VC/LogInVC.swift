//
//  LogInVC.swift
//  TodoList
//
//  Created by 강인혜 on 2022/07/02.
//

import UIKit
import Alamofire


class LogInVC: UIViewController {
    @IBOutlet weak var txtFieldUserID: UITextField!
    @IBOutlet weak var txtFieldPW: UITextField!
    @IBAction func btnLogIn(_ sender: UIButton) {
        signIn()
    }
    
    @IBOutlet weak var passwordEyeButton: UIButton!
    @IBOutlet weak var autoSignInBtn: UIButton!
    
    var autoState: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        txtFieldPW.isSecureTextEntry = true
        manualSignIn()
    }
    
    
    @IBAction func passwordEyeButtonDidTap(_ sender: UIButton) {
        // 보안 설정 반전
        txtFieldPW.isSecureTextEntry.toggle()
        // 버튼 선택 상태 반전
        passwordEyeButton.isSelected.toggle()
        // 버튼 선택 상태에 따른 눈 모양 이미지 변경
        let eyeImage = passwordEyeButton.isSelected ? "password shown eye icon" : "password hidden eye icon"
        passwordEyeButton.setImage(UIImage(named: eyeImage), for: .normal)
        // 버튼 선택된 경우 자동으로 들어가는 틴트 컬러를 투명으로 변경해줌
        passwordEyeButton.tintColor = .clear
    }
    
    
    @IBAction func btnAutoSignIn(_ sender: UIButton) {
        if(autoState == false) {
            autoSignIn()
        }
        
        else if (autoState == true) {
            manualSignIn()
        }
    }
    
    
    func autoSignIn() {
        autoSignInBtn.titleLabel?.textColor = UIColor(named: "ThemeColor")
        let state = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .default)
        let successImage = UIImage(systemName: "checkmark.square.fill", withConfiguration: state)
        autoSignInBtn.setImage(successImage, for: .normal)
        
        autoState = true
        
        let userID = self.txtFieldUserID.text!
        let userPW = self.txtFieldPW.text!
        
        let dataSave = UserDefaults.standard
        dataSave.setValue(userID, forKey: "saveID")
        dataSave.setValue(userPW, forKey: "savePW")
        UserDefaults.standard.synchronize()
    }
    
    func manualSignIn() {
        autoSignInBtn.titleLabel?.textColor = UIColor(named: "ThemeColor")
        let state = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .default)
        let successImage = UIImage(systemName: "square", withConfiguration: state)
        autoSignInBtn.setImage(successImage, for: .normal)
        
        autoState = false
    }
    
    
    
    
    private func signIn() {
//        let url = "http://10.156.147.206:8080/users/signin" //학교
        let url = "http://54.180.97.242:8080/users/signin"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // POST 로 보낼 정보
        let params: Parameters = [
            "userId": "\(txtFieldUserID.text!)",
            "userPw": "\(txtFieldPW.text!)"
        ]

        // httpBody 에 parameters 추가
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
        
        
        AF.request(request).responseString { (response) in
            switch response.result {
            case .success:
                debugPrint(response)
                if let data = try? JSONDecoder().decode(TokenModel.self, from: response.data!) {
                    KeyChain.create(key: "token", token: data.token)
//                    KeyChain.create(key: "refreshToken", token: data.refreshToken)
                }
                
                guard let logInVC = self.storyboard?.instantiateViewController(identifier: "TabBarVC") else { return }

                logInVC.modalPresentationStyle = .fullScreen
                self.present(logInVC, animated: true, completion: nil)
                
            case .failure(let error):
                print(error)
                let failOnAlert = UIAlertController(title: "안내", message: "로그인 실패", preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "입력을 다시 확인해주세요.", style: UIAlertAction.Style.default, handler: nil)
                
                failOnAlert.addAction(onAction)
                self.present(failOnAlert, animated: true, completion: nil)
            }
        }
    }

    
}
