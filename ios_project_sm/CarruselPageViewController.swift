//
//  CarruselPageViewController.swift
//  ios_project_sm
//
//  Created by soporte on 10/02/25.
//

import UIKit

class CarruselPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    let slides: [(title: String, subtitle: String)] = [
        ("Bienvenido", "Esta es la primera vista"),
        ("Explora", "Descubre nuevas funciones"),
        ("Disfruta", "Aprovecha al máximo la app")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        if let firstVC = getViewController(at: 0) {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // MARK: - Crear ViewController para cada slide
    func getViewController(at index: Int) -> UIViewController? {
        guard index >= 0, index < slides.count else { return nil }
        
        let slideVC = SlideViewController()
        slideVC.slideData = slides[index]
        slideVC.index = index
        return slideVC
    }
    
    // MARK: - UIPageViewControllerDataSource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let slideVC = viewController as? SlideViewController else { return nil }
        return  getViewController(at: slideVC.index - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let slideVC = viewController as? SlideViewController else { return nil }
        return getViewController(at: slideVC.index + 1)
    }
    
    // Indicadores de página (puntos abajo)
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return slides.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
