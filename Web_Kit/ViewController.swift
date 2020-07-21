//
//  ViewController.swift
//  Web_Kit
//
//  Created by Дмитрий Данилин on 21.07.2020.
//  Copyright © 2020 Дмитрий Данилин. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forvardButton: UIButton!
    @IBOutlet weak var urlTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlTextField.delegate = self
        webView.navigationDelegate = self
        
        let homePage = "https://zyfunphoto.ru"
        let url = URL(string: homePage)
        let request = URLRequest(url: url!)
        
        urlTextField.text = homePage
        
        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
        
    }
    @IBAction func backButtonAction(_ sender: Any) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    @IBAction func forwardButtonAction(_ sender: Any) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    

}

extension ViewController: UITextFieldDelegate, WKNavigationDelegate  {
    // Метод позволяет вернуть данные из текстовой строки
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Присваиваем константе значение, которое пользователь вводит в текстовую строку
        let urlString = urlTextField.text!
        // Переводим это значение в URL
        let url = URL(string: urlString)!
        // Передаём значение в request
        let request = URLRequest(url: url)
        
        // Загружаем переданные данные
        webView.load(request)
        
        // Скрываем клавиатуру
        textField.resignFirstResponder()
        
        return true
        
    }
    
    // Метод позволяет перенести адрес текущей страницы в TextField
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Присваиваем значение текущей страницы полу ввода текста
        urlTextField.text = webView.url?.absoluteString
        
        // Делаем доступной кнопку назад и вперед, если был переход на странице
        backButton.isEnabled = webView.canGoBack
        forvardButton.isEnabled = webView.canGoForward
    }
}
