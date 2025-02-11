//
//  ViewController.swift
//  ios_project_sm
//
//  Created by soporte on 9/02/25.
//

import UIKit

class InicioCarruselViewController: UIViewController {

    @IBOutlet weak var carruselView: UIView!
    
    private var pageViewController: CarruselPageViewController?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupPageViewController()
        }
        
        private func setupPageViewController() {
            let pageVC = CarruselPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
            
            addChild(pageVC)
            pageVC.view.frame = carruselView.bounds
            carruselView.addSubview(pageVC.view)
            pageVC.didMove(toParent: self)
            
            self.pageViewController = pageVC
        }

}

