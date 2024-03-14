//
//  ModelView.swift
//  wompDemo
//
//  Created by Konrad Gnat on 3/14/24.
//
import SwiftUI
import RealityKit

struct ModelView: View {
    let modelName: String // Name of the USDZ file without the extension
    var modelEntity: Entity
    
    init(modelName: String, x: Float, y: Float, z: Float) {
        self.modelName = modelName
        
        // Attempt to load the model entity from the USDZ file
        self.modelEntity = try! ModelEntity.loadModel(named: "\(modelName)")
        
        // Setup the model's position and other properties
        setupModel(x: x, y: y, z: z)
    }
    
    func setupModel(x: Float, y: Float, z: Float) {
        // Set the position of the model in the world
        modelEntity.position.x = x
        modelEntity.position.y = y
        modelEntity.position.z = z
        
        // Make the model selectable, if desired
        modelEntity.components.set(InputTargetComponent())
        modelEntity.components.set(CollisionComponent(shapes: [.generateSphere(radius: 0.15)]))
        
        // Enable the model to cast a shadow, if desired
        modelEntity.components.set(GroundingShadowComponent(castsShadow: true))
    }
    
    var body: some View {
        RealityView { content in
            content.add(modelEntity)
        }
        .gesture(DragGesture()
            .targetedToAnyEntity()
            .onChanged { value in
                // The value is in SwiftUI's coordinate space, so we have to convert it to RealityKit's coordinate space.
                modelEntity.position = value.convert(value.location3D, from: .local, to: modelEntity.parent!)
            })
    }
}
