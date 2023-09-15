import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) private var dismiss
    
    let city: String
    let cityImage:String
    let cityDesc:String
    @ObservedObject  var cModel : CityModel
   
    
    var body: some View {
        ZStack {
            Image(cityImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .clipped()
            
            GeometryReader { geo in
                VStack {
                    HStack {
                        VStack(alignment: .center, spacing: 10) {
                            Text(city)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                        }
                        //.frame(maxWidth: geo.size.width * 0.85) // set maximum width to 90% of screen width
                        .padding(.horizontal)
                        //.padding(.top, 20) // center the HStack vertically
                        .background(Color.black.opacity(0.3))
                        .cornerRadius(20) // make the background rounded
                    }
                    .padding(.top, geo.size.height * 0.1)
                    
                    Spacer()
                    HStack {
                        VStack(alignment: .center, spacing: 10) {
                            
                            Text(cityDesc)
                                .font(.system(size: 20))
                                .foregroundColor(Color.white)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .frame(maxWidth: geo.size.width * 0.85) // set maximum width to 90% of screen width
                        .padding(.horizontal)
                        .padding(.top, 20) // center the HStack vertically
                        .background(Color.black.opacity(0.3))
                        .cornerRadius(20) // make the background rounded
                    }
                    .padding(.bottom, geo.size.height * 0.05) // position the HStack above the bottom of the screen
                    .frame(width: geo.size.width) // set the width of the HStack to match the screen width
                }
                .frame(maxHeight: geo.size.height) // set the maxHeight of the VStack to match the screen height
            }
        }
        .ignoresSafeArea()

        
            .navigationTitle(city)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(role: .destructive) {
                        let x = cModel.findCity(city: city)
                        print(x)
                        cModel.removeCity(at: x)
                        dismiss()
                    } label: {
                        Image(systemName: "trash")
                    }

                }
            }
    }
}


