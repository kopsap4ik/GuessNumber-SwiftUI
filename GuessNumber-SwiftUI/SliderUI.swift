//
//  UISlider.swift
//  GuessNumber-SwiftUI
//
//  Created by Василий Петухов on 27.10.2020.
//

import SwiftUI

// MARK:  - UISlider from UIKit
struct SliderUI: UIViewRepresentable {
    
    @Binding var value: Double
    var alpha: Double
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider(frame: .zero)
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.tintColor = .gray
        slider.value = Float(value)
        slider.thumbTintColor = .init(red: 1, green: 0, blue: 0, alpha: CGFloat(alpha))
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.valueChanged ),
            for: .valueChanged
        )
        return slider
    }
    
    // читает значение слайдера из SwiftUI
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(value)
        uiView.alpha = CGFloat(alpha)
    }
    
    func makeCoordinator() -> SliderUI.Coordinator {
            Coordinator(value: $value)
    }
    
//    typealias UIViewType = UISlider
}

// MARK:  - координатор для обратной передачи данных в SwiftUI
extension SliderUI{
    
    class Coordinator: NSObject {
        @Binding var value: Double
        
        init(value: Binding<Double>){
            self._value = value
        }
        
        // метод передает значения UISlider и приводит к Double для SwiftUI
        @objc func valueChanged(_ sender: UISlider){
            value = Double(sender.value)
        }
    }
}

// MARK:  - PreviewProvider
struct SliderUI_Previews: PreviewProvider {
    static var previews: some View {
        SliderUI(value: .constant(50), alpha: 0.3)
    }
}
