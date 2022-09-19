//
//  ViewController.swift
//  food price in Singapore at cafes n restaurants
//
//  Created by Ryan Lin on 2022/9/19.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var timeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var menuPriceTextField: UITextField!
    @IBOutlet weak var serviceFeeLabel: UILabel!
    @IBOutlet weak var gstLabel: UILabel!
    @IBOutlet weak var twdTotal: UILabel!
    @IBOutlet weak var paxTextField: UITextField!
    @IBOutlet weak var realPriceLabel: UILabel!
    @IBOutlet weak var pricePerPersonLabel: UILabel!
    @IBOutlet weak var twdPerPersonTextField: UILabel!
    @IBOutlet weak var totalLabelTitle: UILabel!
    @IBOutlet weak var paxLabelTitle: UILabel!
    
    var gst = 0.07
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //讓 實付總金額 變圓角
        totalLabelTitle.layer.cornerRadius = 20
        //讓 分攤金額 變圓角
        paxLabelTitle.layer.cornerRadius = 20
    }

    fileprivate func erase() {
        menuPriceTextField.text = ""
        paxTextField.text = ""
        serviceFeeLabel.text = "10% Service Fee(服務費)"
        realPriceLabel.text = "新幣"
        twdTotal.text = "台幣"
        pricePerPersonLabel.text = "新幣"
        twdPerPersonTextField.text = "台幣"
    }
    //清空所有欄位
    @IBAction func eraseAllButton(_ sender: Any) {
        if timeSegmentedControl.selectedSegmentIndex == 0{
            gstLabel.text = "7% GST(消費稅)"
            erase()
        }
        if timeSegmentedControl.selectedSegmentIndex == 1{
            gstLabel.text = "10% GST(消費稅)"
            erase()
        }
    }
    
    @IBAction func changeSegmentedControl(_ sender: Any) {
        if timeSegmentedControl.selectedSegmentIndex == 0{
            gstLabel.text = "7% GST(消費稅)"
        }
        if timeSegmentedControl.selectedSegmentIndex == 1{
            gstLabel.text = "10% GST(消費稅)"
        }
    }
    
    @IBAction func calculateButton(_ sender: Any) {
        //把輸入價格的數字取出，存在manuPrice
        let manuPrice = menuPriceTextField.text
        //把數字變成浮點數，存進price
        let price = Double(manuPrice!)
        //把輸入人數的數字取出，存在paxNumber
        let paxNumber = paxTextField.text
        //把數字變成浮點數，存進pax
        let pax = Double(paxNumber!)
        
        if timeSegmentedControl.selectedSegmentIndex == 0{
            gst = 0.07
            if price != nil{
                if pax != nil{
                    let serviceFee = Double(price!/10)
                    //顯示serviece fee
                    serviceFeeLabel.text = "服務費 \(serviceFee) 元"
                    let currentGstPrice = Double((Double(menuPriceTextField.text!)!+serviceFee)*gst)
                    //顯示GST
                    let formatGSTL = String(format: "%.2f", currentGstPrice)
                    gstLabel.text = "消費稅 \(formatGSTL) 元"
                    let currentRealPrice = Double(Double(menuPriceTextField.text!)!+serviceFee+currentGstPrice)
                    let formarCRL = String(format:"%.2f", currentRealPrice)
                    //顯示實際付款金額
                    realPriceLabel.text = "新幣 \(formarCRL) 元"
                    let perPersonPrice = Double(currentRealPrice/pax!)
                    let formarPPP = String(format: "%.2f", perPersonPrice)
                    //顯示個人費用
                    pricePerPersonLabel.text = "新幣 \(formarPPP) 元"
                    let twdTotalPrice = Int(currentRealPrice*22.27)
                    //顯示總金額台幣
                    twdTotal.text = "台幣 \(twdTotalPrice) 元"
                    let ntperPerson = Int(twdTotalPrice/Int(pax!))
                    //顯示個人台幣
                    twdPerPersonTextField.text = "台幣 \(ntperPerson) 元"
                    //按下Calculate Button自動收鍵盤
                    view.endEditing(true)
                }
                else{
                    gstLabel.text = "請輸入 分攤人數"
                }
            }
            else{
                serviceFeeLabel.text = "請輸入 Item's Price"
            }
        }
        if timeSegmentedControl.selectedSegmentIndex == 1{
            
     
            if price != nil{
                if pax != nil{
                    let serviceFee = price!/10
                    //顯示serviece fee
                    serviceFeeLabel.text = "服務費 \(serviceFee) 元"
                    gst = 0.1
                    let currentGstPrice = Double((price!+serviceFee)*gst)
                    //顯示GST
                    let formatGSTL = String(format: "%.2f", currentGstPrice)
                    gstLabel.text = "消費稅 \(formatGSTL) 元"
                    let currentRealPrice = Double(price!+serviceFee+currentGstPrice)
                    let formarCRL = String(format:"%.2f", currentRealPrice)
                    //顯示實際付款金額
                    realPriceLabel.text = "新幣 \(formarCRL) 元"
                    let perPersonPrice = Double(currentRealPrice/Double(pax!))
                    let formarPPP = String(format: "%.2f", perPersonPrice)
                    //顯示個人費用
                    pricePerPersonLabel.text = "新幣 \(formarPPP) 元"
                    let twdTotalPrice = Int(currentRealPrice*22.27)
                    //顯示總金額台幣
                    twdTotal.text = "台幣 \(twdTotalPrice) 元"
                    let ntperPerson = Int(twdTotalPrice/Int(pax!))
                    //顯示個人台幣
                    twdPerPersonTextField.text = "台幣 \(ntperPerson) 元"
                    //按下Calculate Button自動收鍵盤
                    view.endEditing(true)
                }
                else{
                    gstLabel.text = "請輸入 分攤人數"
                }
            }
            else{
                serviceFeeLabel.text = "請輸入 Item's Price"
            }
            }
        }
       
    }
