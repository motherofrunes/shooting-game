//
//  GameScene.swift
//  shooting-game
//
//  Created by Yasui Yuito on 2019/08/18.
//  Copyright © 2019 Yasui Yuito. All rights reserved.
//

import GameplayKit
import SpriteKit

class GameScene: SKScene {
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
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
}
