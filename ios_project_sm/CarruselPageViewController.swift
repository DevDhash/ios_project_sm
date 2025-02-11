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
    
    var currentIndex = 0
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        if let firstVC = getViewController(at: 0) {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        startAutoScroll()
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
        return getViewController(at: slideVC.index - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let slideVC = viewController as? SlideViewController else { return nil }
        return getViewController(at: slideVC.index + 1)
    }
    
    // MARK: - Indicadores de página (puntos abajo)
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return slides.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }
    
    // MARK: - Auto Scroll
    private func startAutoScroll() {
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToNextSlide), userInfo: nil, repeats: true)
    }
    
    @objc private func moveToNextSlide() {
        guard let currentVC = viewControllers?.first as? SlideViewController else { return }
        let nextIndex = currentVC.index + 1
        
        if let nextVC = getViewController(at: nextIndex) {
            setViewControllers([nextVC], direction: .forward, animated: true, completion: nil)
            currentIndex = nextIndex
        } else {
            // Reiniciar al primer slide cuando llegue al final
            if let firstVC = getViewController(at: 0) {
                setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
                currentIndex = 0
            }
        }
    }
}
