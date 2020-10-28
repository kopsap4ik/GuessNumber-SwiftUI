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
        //будет менять прозрачность всего слайдера
//        slider.thumbTintColor = UIColor(red: 1, green: 0, blue: 0, alpha: CGFloat(alpha))
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.valueChanged ),
            for: .valueChanged
        )
        return slider
    }
    
    // читает значение слайдера из SwiftUI
//    Метод updateUIView работает так же, как viewDidLoad для вью контроллера. Т.е. пользователь в конечном счете увидит слайдер с теми значениями, которые ты определил именно в этом методе. Не важно, какие параметры ты задаешь в момент инициализации объекта, если ты эти же параметры переопределяешь в методе updateUIView, то в конечном счете элемент интерфейса будет выглядеть именно так, как ты его определил именно в этом методе.

//    В методе updateUIView ты задаешь значение для alpha, а надо сразу задавать значение для прозрачности бегунка:
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(value)
//        uiView.alpha = CGFloat(alpha) //будет менять прозрачность всего слайдера
        
        // чтобы менять только прозрачность бегунка (кружок)
        uiView.thumbTintColor = UIColor.red.withAlphaComponent(CGFloat(alpha))
    }
    
    func makeCoordinator() -> SliderUI.Coordinator {
            Coordinator(value: $value)
    }
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
        SliderUI(value: .constant(50), alpha: 1.0)
    }
}
