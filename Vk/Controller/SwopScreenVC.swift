//
//  SwopScreenVC.swift
//  Vk
//
//  Created by Евгений Дербенев on 1/14/21.
//

//import UIKit
//
//class InteractiveTransition: UIPercentDrivenInteractiveTransition {
//
//    var animatedViewController: UIViewController? {
//        didSet {
//            let recognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleScreenEdgeGesture(_:)))
//            recognizer.edges = [.left]
//            animatedViewController?.view.addGestureRecognizer(recognizer)
//        }
//    }
//
//    var recognizerViewController: UIViewController?
//    var hasStarted: Bool = false
//    var shouldFinish: Bool = false
//
//    @objc func handleScreenEdgeGesture(_ recognizer: UIScreenEdgePanGestureRecognizer) {
//        switch recognizer.state {
//        case .began:
//            self.hasStarted = true
//            self.animatedViewController?.navigationController?.popViewController(animated: true)
//        case .changed:
//            let translation = recognizer.translation(in: recognizerViewController!.view)
//            let relativeTranslation = translation.x / (recognizerViewController!.view.bounds.width )
//            let progress = max(0, min(1, relativeTranslation))
//
//            self.shouldFinish = progress > 0.30
//
//            self.update(progress)
//        case .ended:
//            self.hasStarted = false
//            self.shouldFinish ? self.finish() : self.cancel()
//        case .cancelled:
//            self.hasStarted = false
//            self.cancel()
//        default: return
//        }
//    }
//
//}
//
//// Вперед
//class PushNavigationControllerTransition: NSObject, UIViewControllerAnimatedTransitioning {
//
//    private let duration: TimeInterval = 0.5
//
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        duration
//    }
//
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        //начальный конроллер
//        let source = transitionContext.viewController(forKey: .from)!
//        //конечный конроллер
//        let destination = transitionContext.viewController(forKey: .to)!
//        //добавляем конечное вью в containerView
//        transitionContext.containerView.addSubview(destination.view)
//        //назначаем фреймы
//        source.view.frame = transitionContext.containerView.frame
//        destination.view.layer.anchorPoint = CGPoint(x: 1.0, y: 0.0)
//        destination.view.frame = transitionContext.containerView.frame
//        //задаем начальное положение
//        destination.view.transform = CGAffineTransform(rotationAngle: -.pi / 2)
//
//        destination.view.layer.shadowColor = UIColor.black.cgColor
//        destination.view.layer.shadowOpacity = 1
//        destination.view.layer.shadowOffset = .zero
//        destination.view.layer.shadowRadius = 10
//        destination.view.clipsToBounds = false
//
//        //анимация
//        UIView.animate(withDuration: self.transitionDuration(using: transitionContext)) {
//                destination.view.transform = .identity
//
//        } completion:  {  finished in
//            if finished && !transitionContext.transitionWasCancelled {
//                source.view.transform = .identity
//            }
//            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
//        }
//    }
//
//
//}
//
////назад
//class PopNavigationControllerTransition: NSObject, UIViewControllerAnimatedTransitioning {
//
//    private let duration: TimeInterval = 0.5
//
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return duration
//    }
//
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        //начальный конроллер
//        let source = transitionContext.viewController(forKey: .from)!
//        //конечный конроллер
//        let destination = transitionContext.viewController(forKey: .to)!
//
//        transitionContext.containerView.addSubview(destination.view)
//        transitionContext.containerView.sendSubviewToBack(destination.view)
//
//        //назначаем фреймы
//        source.view.layer.anchorPoint = CGPoint(x: 1.0, y: 0.0)
//        source.view.frame = transitionContext.containerView.frame
//        destination.view.frame = source.view.frame
//
//        source.view.layer.shadowColor = UIColor.black.cgColor
//        source.view.layer.shadowOpacity = 1
//        source.view.layer.shadowOffset = .zero
//        source.view.layer.shadowRadius = 10
//        source.view.clipsToBounds = false
//
//
//
//        //анимация
//        UIView.animate(withDuration: self.transitionDuration(using: transitionContext)) {
//            source.view.transform = CGAffineTransform(rotationAngle: -.pi / 2)
//
//        } completion:  {  finished in
//            if finished && !transitionContext.transitionWasCancelled {
//                source.removeFromParent()
//            }
//            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
//        }
//    }
//}
//
//class CustomNavigationController: UINavigationController {
//
//    let interactiveTransition = InteractiveTransition()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.delegate = self
//
//    }
//
//}
//
//extension CustomNavigationController: UINavigationControllerDelegate {
//    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//
//        switch operation {
//        case .push:
//            self.interactiveTransition.animatedViewController = toVC
//            self.interactiveTransition.recognizerViewController = fromVC
//            return PushNavigationControllerTransition()
//        case .pop:
//            if navigationController.viewControllers.first != toVC {
//                self.interactiveTransition.recognizerViewController = fromVC
//                self.interactiveTransition.animatedViewController = toVC
//            }
//            return PopNavigationControllerTransition()
//        default:
//            return nil
//        }
//    }
//
//
//    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        return interactiveTransition.hasStarted ? interactiveTransition : nil
//
//    }
//}



import UIKit
////////////////////////////
class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    let interactiveTransition = InteractiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            self.interactiveTransition.animatedViewController = toVC
            self.interactiveTransition.recognizerViewController = fromVC
            return PushTransition()
        case .pop:
            if navigationController.viewControllers.first != toVC {
                self.interactiveTransition.recognizerViewController = fromVC
                self.interactiveTransition.animatedViewController = toVC
            }
            return PopTransition()
        default:
            return nil
        }
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactiveTransition.hasStarted ? self.interactiveTransition : nil
    }
}



class PushTransition: NSObject, UIViewControllerAnimatedTransitioning {
    private let duration = 0.5
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
        else { return }
        
        transitionContext.containerView.addSubview(destination.view)

        source.view.frame = transitionContext.containerView.frame
        destination.view.layer.anchorPoint = CGPoint(x: 1.0, y: 0.0)
        destination.view.frame = transitionContext.containerView.frame
        destination.view.transform = CGAffineTransform(rotationAngle: -.pi / 2)

        UIView.animate(withDuration: self.duration) {
            destination.view.transform = .identity
        } completion: { completed in
            transitionContext.completeTransition(completed && !transitionContext.transitionWasCancelled)
        }

    }
}

class PopTransition: NSObject, UIViewControllerAnimatedTransitioning {
    private let duration = 0.5
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
        else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.sendSubviewToBack(destination.view)
        
        source.view.layer.anchorPoint = CGPoint(x: 1.0, y: 0.0)
        source.view.frame = transitionContext.containerView.frame
        destination.view.frame = transitionContext.containerView.frame
        
        UIView.animate(withDuration: self.duration) {
            source.view.transform = CGAffineTransform(rotationAngle: -.pi / 2)
        } completion: { completed in
            transitionContext.completeTransition(completed && !transitionContext.transitionWasCancelled)
        }

    }
}

class InteractiveTransition: UIPercentDrivenInteractiveTransition {
    var animatedViewController: UIViewController? {
        didSet {
            let recognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleScreenEdgeGesture(_:)))
            recognizer.edges = [.left]
            animatedViewController?.view.addGestureRecognizer(recognizer)
        }
    }
    
    var recognizerViewController: UIViewController?
    
    var hasStarted: Bool = false
    var shouldFinish: Bool = false

    @objc func handleScreenEdgeGesture(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            self.hasStarted = true
            self.animatedViewController?.navigationController?.popViewController(animated: true)
        case .changed:
            let translation = recognizer.translation(in: recognizerViewController!.view)
            let relativeTranslation = translation.x / (recognizerViewController!.view.bounds.width )
            let progress = max(0, min(1, relativeTranslation))
            
            self.shouldFinish = progress > 0.3

            self.update(progress)
        case .ended:
            self.hasStarted = false
            self.shouldFinish ? self.finish() : self.cancel()
        case .cancelled:
            self.hasStarted = false
            self.cancel()
        default: return
        }
    }
}
