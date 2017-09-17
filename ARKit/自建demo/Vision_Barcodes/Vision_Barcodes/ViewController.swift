//
//  ViewController.swift
//  Vision_Barcodes
//
//  Created by 张云龙 on 2017/9/17.
//  Copyright © 2017年 张云龙. All rights reserved.
//

import UIKit
import Vision
import CoreML
import ARKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //加载图片
        let image = UIImage.init(named: "IMG_0122")
        
        let ciImage = CIImage.init(image: image!)
        
        let imageView = UIImageView.init(image: image)
        
        imageView.frame = CGRect.init(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width * ((image?.size.height)! / (image?.size.width)!))
        view.addSubview(imageView)
        
        //创建显示label
        let showLabel = UILabel.init(frame: CGRect.init(x: 0, y: view.frame.size.height - 80, width: view.frame.size.width, height: 80))
        showLabel.backgroundColor = UIColor.black
        showLabel.textColor = UIColor.white
        showLabel.font = UIFont.systemFont(ofSize: 17)
        showLabel.numberOfLines = 0
        showLabel.textAlignment = .center
        
        view.addSubview(showLabel)
        
        //创建条形码请求
        let barcodesRequest = VNDetectBarcodesRequest.init { (request, error) in
            
        }
        
        //处理图像
        let barcodesHandler = VNImageRequestHandler.init(ciImage: ciImage!, options: [VNImageOption.init(rawValue: "") : ""])
        
        //开启请求
        try! barcodesHandler.perform([barcodesRequest])
        
        //获取条形码识别信息
        for observation in barcodesRequest.results as! [VNBarcodeObservation] {
            print(observation.payloadStringValue ?? "")
            showLabel.text = observation.payloadStringValue
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

