//
//  GameScene.swift
//  shooting-game
//
//  Created by Yasui Yuito on 2019/08/18.
//  Copyright © 2019 Yasui Yuito. All rights reserved.
//

import CoreMotion
import GameplayKit
import SpriteKit

class GameScene: SKScene {
    let motionManager = CMMotionManager()
    var accelaration: CGFloat = 0.0

    var timer: Timer?
    var earth: SKSpriteNode!
    var spaceShip: SKSpriteNode!

    override func didMove(to view: SKView) {
        self.earth = SKSpriteNode(imageNamed: "earth")
        self.earth.xScale = 1.5
        self.earth.yScale = 0.3
        self.earth.position = CGPoint(x: 0, y: -frame.height / 2)
        self.earth.zPosition = -1.0
        addChild(self.earth)

        self.spaceShip = SKSpriteNode(imageNamed: "spaceship")
        self.spaceShip.scale(to: CGSize(width: frame.width / 5, height: frame.width / 5))
        self.spaceShip.position = CGPoint(x: 0, y: self.earth.frame.maxY + 50)
        addChild(self.spaceShip)

        self.motionManager.accelerometerUpdateInterval = 0.2
        self.motionManager.startAccelerometerUpdates(to: OperationQueue.current!, withHandler: { data, _ in
            guard let data = data else { return }
            let a = data.acceleration
            self.accelaration = CGFloat(a.x) * 0.75 + self.accelaration * 0.25
        })

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            self.addAsteroid()})
    }

    override func didSimulatePhysics() {
        let nextPosition = self.spaceShip.position.x * self.accelaration * 50
        if frame.width / 2 - 30 < nextPosition {
            return
        }

        if nextPosition < -frame.width / 2 + 30 {
            return
        }

        self.spaceShip.position.x = nextPosition
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let missile: SKSpriteNode = SKSpriteNode(imageNamed: "missile")
        missile.position = CGPoint(x: self.spaceShip.position.x, y: self.spaceShip.position.y + 50)
        NSLog("self.spaceShip.position.x=\(self.spaceShip.position.x), self.spaceShip.position.y=\(self.spaceShip.position.y)")
        addChild(missile)

        let moveToTop = SKAction.moveTo(y: frame.height, duration: 0.3)
        NSLog("frame.height=\(frame.height), self.frame.heigh=\(self.frame.height)")
        let remove = SKAction.removeFromParent()
        missile.run(SKAction.sequence([moveToTop, remove]))
    }

    func addAsteroid() {
        let names = ["asteroid1", "asteroid2", "asteroid3"]
        let name = names.randomElement()!
        let asteroid = SKSpriteNode(imageNamed: name)
        let random = CGFloat.random(in: -0.5...0.5)
        let positionX = frame.width * random
        NSLog("乱数は%f.positionXは%f.", random, positionX)
        asteroid.position = CGPoint(x: positionX, y: frame.height / 2 + asteroid.frame.height)
        asteroid.scale(to: CGSize(width: 70, height: 70))
        addChild(asteroid)

        let move = SKAction.moveTo(y: -frame.height / 2 - asteroid.frame.height, duration: 6.0)
        let remove = SKAction.removeFromParent()
        asteroid.run(SKAction.sequence([move, remove]))
    }
}
