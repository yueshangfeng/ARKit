//
//  ViewController.swift
//  Vision_1
//
//  Created by 张云龙 on 2017/9/15.
//  Copyright © 2017年 张云龙. All rights reserved.
//

import UIKit
import Vision
import CoreML
import ARKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //添加图片
        let zylImage = UIImage.init(named: "zllt.png")
        let imgSize = zylImage?.size
        let zylImageView = UIImageView.init(image: zylImage)
        
        zylImageView.frame.origin = CGPoint.init(x: 0, y: 0)
        zylImageView.frame.size = CGSize.init(width: view.frame.width, height: view.frame.size.width * (imgSize?.height)! / (imgSize?.width)!)
        
        view.addSubview(zylImageView)
        
        let zylImgaeViewSize = zylImageView.frame.size
        
        
        //面部识别
        //创建面部识别请求
        let faceDetectionRequest = VNDetectFaceRectanglesRequest.init()
        //创建面部识别处理者
        let image = CIImage.init(image: zylImage!)
        let myRequestHandler = VNImageRequestHandler.init(ciImage: image!, options: [:])
        try! myRequestHandler.perform([faceDetectionRequest])
        
        //获取脸部识别回调
        for observation in faceDetectionRequest.results as! [VNFaceObservation] {
            print(observation)
            let bounRect = observation.boundingBox
            
            //将矩形标记在脸上
            let rectView = UIView.init()
            rectView.backgroundColor = .clear
            rectView.layer.borderColor = UIColor.red.cgColor
            rectView.layer.borderWidth = 1.0
            rectView.frame = CGRect.init(x: zylImgaeViewSize.width * bounRect.origin.x, y: zylImgaeViewSize.height * (1.0 - bounRect.origin.y - bounRect.size.height), width: zylImgaeViewSize.width * bounRect.size.width, height: zylImgaeViewSize.height * bounRect.size.height)
            zylImageView.addSubview(rectView)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

