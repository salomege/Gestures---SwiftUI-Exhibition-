//
//  ContentView.swvarift
//  Exibition
//
//  Created by salome on 23.12.23.
//



import SwiftUI

struct ContentView: View {
    @State private var currentValue = CGFloat.zero
    @State private var value = Angle(degrees: 0)
    @State private var offsetSize = CGSize.zero
    @State private  var isOn = false
    @State private var longPressing = false
    @State private var scale:CGFloat = 1.0
    @State private var isZoomed: Bool = false
    
    var body: some View {
        NavigationView{
        ScrollView {
            VStack {
                SelfPortrait
                StarryNight
                almond
                landScape
                rocks
                
            }
        }
        .navigationTitle("Vincent Van Gogh")
        .font(.headline)
        .padding()
    }
}
    var SelfPortrait: some View {
        VStack {
            SwiftUI.Image("Self-Portrait")
                .resizable()
                .frame(width:250, height: 350)
                .scaleEffect(1 + currentValue)
                .gesture(
                    MagnificationGesture()
                        .onChanged { number in
                            currentValue = number - 1
                        })
            Text("Self portrait, 1889")
        }
    }
    
    var StarryNight: some View {
        VStack {
            SwiftUI.Image("Starry-Night")
                .resizable()
                .frame(width:350, height: 250)
                .rotationEffect(value)
                .gesture(
                    RotationGesture()
                        .onChanged { value = $0 }
                        .onEnded { _ in value = .zero })
            Text("Starry night, 1889")
        }
    }
    var almond: some View {
        VStack {
            SwiftUI.Image("Almond-Blossom")
                .resizable()
                .frame(width:350, height: 250)
                .offset(offsetSize)
                .gesture(
                    DragGesture()
                        .onChanged { offsetSize = $0.translation }
                )
            
            Text("Almond blossom,1890")
                .background(isOn ? .green : .white)
                .onTapGesture {
                    isOn.toggle()
                }
        }
        
    }
    
    var landScape: some View {
        VStack {
            SwiftUI.Image("Landscape")
                .resizable()
                .frame(width: 350, height: 250)
                .scaleEffect(isZoomed ? 2.0 : 1.0)
                .gesture(TapGesture(count: 2)
                    .onEnded {
                        withAnimation {
                            self.isZoomed.toggle()
                        }
                    }
                )
            
            Text("Mountain landscape, 1889")
        }
    }
    var rocks: some View {
        VStack {
            SwiftUI.Image("The-Rocks")
                .resizable()
                .frame(width:350, height: 250)
                .scaleEffect(scale)
            
                .onLongPressGesture(minimumDuration: 0.9) {_ in
                    withAnimation { self.scale += 0.3 }
                } perform: { withAnimation {
                    self.scale = 1.0
                }
                }
            Text("The Rocks, 1888")
        }
    }
    
}


#Preview {
    ContentView()
}
