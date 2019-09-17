//
//  AspenViewController.swift
//  SevenPlusH
//
//  Created by Shardul Joshi on 8/24/18.
//  Copyright © 2018 N/A. All rights reserved.
//

import UIKit
import WebKit
class AspenViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        view = webView
    }
    
    // Checks for internet connection. If none, loads basic HTML asking user to connect to internet before trying to access Aspen login page
    override func viewDidLoad() {
        if Reachability.isConnectedToNetwork() {
            super.viewDidLoad()
            let myURL = URL(string: "https://ma-andover.myfollett.com/aspen/logon.do")!
            let myRequest = URLRequest(url: myURL)
            webView.load(myRequest)
        }
        else {
            webView.loadHTMLString("<h1 style='text-align: center; position: relative; top: 46%'>No internet connection - <br>please connect to a network and try again</h1>", baseURL: nil)
        }
    }
    
    // Opens webview to Aspen login page. User logs in and then the app gathers the data necessary
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
        if webView.url == URL(string: "https://ma-andover.myfollett.com/aspen/mobile/2d2a199/#/") {
            let myURL = URL(string: "https://ma-andover.myfollett.com/aspen/studentScheduleContextList.do?navkey=myInfo.sch.list")
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
        }
        if let url = webView.url {
            if url.absoluteString.range(of: "studentScheduleMatrix") != nil {
                webView.evaluateJavaScript("doParamSubmit(360,document.forms['scheduleMatrixForm'],'')", completionHandler: nil)
            }
        }
        if let url = webView.url {
            if url.absoluteString.range(of: "studentScheduleContext") != nil {
                var username = ""
                webView.evaluateJavaScript("document.getElementById('userPreferenceMenu').innerText.toString()", completionHandler: { (html: Any?, error: Error?) in username = html as! String
                    if let dir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
                        let fileURL = dir.appendingPathComponent("username.txt")
                        do {
                            try username.write(to: fileURL, atomically: false, encoding: .utf8)
                        }
                        catch {print("Error")}
                    }
                })
                var htmlString = ""
                var i = 0
                webView.evaluateJavaScript("document.getElementById('dataGrid').innerHTML.toString()", completionHandler: { (html: Any?, error: Error?) in htmlString = html as! String
                    let tok =  htmlString.components(separatedBy:"listCell")
                    i = tok.count-2
                    var block = ""
                    for number in 0...i {
                        webView.evaluateJavaScript("document.getElementById('dataGrid').getElementsByClassName('listCell')[" + String(number) + "].getElementsByTagName('td')[4].innerText.toString()", completionHandler: { (html: Any?, error: Error?) in block = html as! String
                            let file = block + "Block1.txt"
                            var semester = ""
                            webView.evaluateJavaScript("document.getElementById('dataGrid').getElementsByClassName('listCell')[" + String(number) + "].getElementsByTagName('td')[5].innerText.toString()", completionHandler: { (html: Any?, error: Error?) in semester = html as! String
                                if semester != "2" {
                                    var text = "Error"
                                    var classname = ""
                                    var teacher = ""
                                    var room = ""
                                    var lunch = ""
                                    webView.evaluateJavaScript("document.getElementById('dataGrid').getElementsByClassName('listCell')[" + String(number) + "].getElementsByTagName('td')[2].innerText.toString()", completionHandler: { (html: Any?, error: Error?) in classname = html as! String
                                    })
                                    webView.evaluateJavaScript("document.getElementById('dataGrid').getElementsByClassName('listCell')[" + String(number) + "].getElementsByTagName('td')[8].innerText.toString()", completionHandler: { (html: Any?, error: Error?) in teacher = html as! String
                                    })
                                    webView.evaluateJavaScript("document.getElementById('dataGrid').getElementsByClassName('listCell')[" + String(number) + "].getElementsByTagName('td')[7].innerText.toString()", completionHandler: { (html: Any?, error: Error?) in room = html as! String
                                    })
                                    webView.evaluateJavaScript("document.getElementById('dataGrid').getElementsByClassName('listCell')[" + String(number) + "].getElementsByTagName('td')[3].innerText.toString()", completionHandler: { (html: Any?, error: Error?) in lunch = html as! String
                                        text = classname + "\n" + teacher + "\n" + room + "\n" + lunch + "\n"
                                        if let dir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
                                            let fileURL = dir.appendingPathComponent(file)
                                            do {
                                                try text.write(to: fileURL, atomically: false, encoding: .utf8)
                                            }
                                            catch {print("Error")}
                                        }
                                    })
                                }
                            })
                        })
                    }
                    for number in 0...i {
                        webView.evaluateJavaScript("document.getElementById('dataGrid').getElementsByClassName('listCell')[" + String(number) + "].getElementsByTagName('td')[4].innerText.toString()", completionHandler: { (html: Any?, error: Error?) in block = html as! String
                            let file = block + "Block2.txt"
                            var semester = ""
                            webView.evaluateJavaScript("document.getElementById('dataGrid').getElementsByClassName('listCell')[" + String(number) + "].getElementsByTagName('td')[5].innerText.toString()", completionHandler: { (html: Any?, error: Error?) in semester = html as! String
                                if semester != "1" {
                                    var text = "Error"
                                    var classname = ""
                                    var teacher = ""
                                    var room = ""
                                    var lunch = ""
                                    webView.evaluateJavaScript("document.getElementById('dataGrid').getElementsByClassName('listCell')[" + String(number) + "].getElementsByTagName('td')[2].innerText.toString()", completionHandler: { (html: Any?, error: Error?) in classname = html as! String
                                    })
                                    webView.evaluateJavaScript("document.getElementById('dataGrid').getElementsByClassName('listCell')[" + String(number) + "].getElementsByTagName('td')[8].innerText.toString()", completionHandler: { (html: Any?, error: Error?) in teacher = html as! String
                                    })
                                    webView.evaluateJavaScript("document.getElementById('dataGrid').getElementsByClassName('listCell')[" + String(number) + "].getElementsByTagName('td')[7].innerText.toString()", completionHandler: { (html: Any?, error: Error?) in room = html as! String
                                    })
                                    webView.evaluateJavaScript("document.getElementById('dataGrid').getElementsByClassName('listCell')[" + String(number) + "].getElementsByTagName('td')[3].innerText.toString()", completionHandler: { (html: Any?, error: Error?) in lunch = html as! String
                                        text = classname + "\n" + teacher + "\n" + room + "\n" + lunch + "\n"
                                        if let dir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
                                            let fileURL = dir.appendingPathComponent(file)
                                            do {
                                                try text.write(to: fileURL, atomically: false, encoding: .utf8)
                                            }
                                            catch {print("Error")}
                                        }
                                    })
                                }
                            })
                        })
                    }
                })
                _ = navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    // After gathering schedule info, app saves it to a file
    override func viewDidDisappear(_ animated: Bool) {
        var file: String!
        var text: String!
        for i in 1...2 {
            file = "semester" + String(i) + ".txt"
            text = ""
            for c in UnicodeScalar("A").value...UnicodeScalar("H").value {
                if let dir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
                    let fileURL = dir.appendingPathComponent(String(UnicodeScalar(c)!) + "Block" + String(i) + ".txt")
                    do {
                        text += try String(contentsOf: fileURL, encoding: .utf8)
                    }
                    catch {print("Error")}
                }
            }
            if let dir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
                let fileURL = dir.appendingPathComponent(file)
                do {
                    try text.write(to: fileURL, atomically: false, encoding: .utf8)
                }
                catch {print("Error")}
            }
        }
    }
}
