//SceneController.swift
//Project Tesla
//
//Created by Carlo Carpio
import UIKit
import SpriteKit
import PlaygroundSupport

public class SceneController: UIViewController, PlaygroundLiveViewSafeAreaContainer {
    
    var scene: SKScene!
    var sceneTitle: String!
    var skView: SKView!
    
    //--MARK: Init
    public init(sceneTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.sceneTitle = sceneTitle
    }
    
    //--MARK: Override
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        skView = SKView(frame: self.view.frame)
        view.addSubview(skView)
        skView.backgroundColor = .clear
        skView.ignoresSiblingOrder = true
        skView.showsFPS = false
        
        switch self.sceneTitle {
        case "TorchGameScene":
            scene = TorchGame(size: view.frame.size)
        case "OhmScene":
            scene = OhmPage(size: view.frame.size)
        default:
            break
        }
        
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
        
        NSLayoutConstraint.activate([
            skView.topAnchor.constraint(equalTo: liveViewSafeAreaGuide.topAnchor),
            skView.bottomAnchor.constraint(equalTo: liveViewSafeAreaGuide.bottomAnchor)
            ])
    }
    
    override public func viewDidLayoutSubviews () {
        self.skView.center = self.view.center
        self.skView.frame = self.view.frame
    }
    
    //--MARK: Required Init
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//--MARK: PlaygroundLiveViewMessageHandler extension
extension SceneController: PlaygroundLiveViewMessageHandler {
    public func receive(_ message: PlaygroundValue) {
        switch message {
        case let .string(text):
            switch text {
            case "electricity_enabled":
                    (scene as! OhmPage).electricityEnabled = true
            case "electricity_not_enabled":
                    (scene as! OhmPage).electricityEnabled = false
            case "correct-intensity-value":
                (scene as! OhmPage).correctIntensityValue = true
            case "not-correct-intensity-value":
                (scene as! OhmPage).correctIntensityValue = false
            default:
                break
            }
        default:
            break
        }
    }
}

