//
//  ContentView.swift
//  PlacesApiTutorial
//
//  Created by Lucas Daniel Costa da Silva on 08/07/24.
//

import SwiftUI

struct ContentView: View {
  @State var place : Place?
  
  var body: some View {
    VStack{
      if let place = place {
        VStack(alignment: .center){
          AsyncImage(url: URL(string: "https://places.googleapis.com/v1/\(place.photo)/media?maxHeightPx=220&maxWidthPx=360&key=\(APIKey)")){ image in
            image
              .resizable()
              .scaledToFill()
              .frame(width: 360, height: 220)
              .cornerRadius(20)
          } placeholder: {
            ProgressView()
          }
          VStack(alignment: .leading, spacing: 6) {
            HStack{
              Text(place.name)
                .font(.title.weight(.semibold))
              Spacer()
              Text(place.openNow ? "Aberto" : "Fechado")
                .foregroundStyle(place.openNow ? .green : .red)
                .font(.title3.weight(.medium))
            }.frame(width: 360)
            
            Text(place.address)
              .font(.title2.weight(.medium))
            Text(place.overview)
              .font(.title3)
              .padding([.bottom, .top], 0.5)
              .lineLimit(6)
              .multilineTextAlignment(.leading)
            Text(place.wheelchairAccessibleEntrance ? "Possui acessibilidade na entrada" : "Não possui acessibilidade na entrada")
              .font(.title3)
              .fontWeight(.semibold)
            Text("Contato: \(place.phoneNumber)")
              .font(.headline)
              .padding([.bottom], 0.5)
            Text("Nota no Google Maps: \(String(format: "%.1f", place.rating))/5.0")
              .font(.headline)
              .fontWeight(.semibold)
            
            HStack{
              Text("Horários")
                .font(.title3)
                .fontWeight(.semibold)
              Spacer()
            }
            
            VStack(alignment: .leading, spacing: 4){
              ForEach(place.schedule, id: \.self){ schedule in
                Text(schedule)
                  .font(.headline)
              }
            }
          }.padding()
        }
        .padding()
      } else {
        Button(action: {
          Task {
            await fetchData()
          }
        }, label: {
          Text("Fazer a requisição")
            .font(.title2)
            .padding()
            .background(Color.blue)
            .foregroundStyle(Color.white)
            .clipShape(RoundedRectangle(cornerRadius:14))
        })
      }
    }
  }
  
  func fetchData() async {
    let url = URL (string: "https://places.googleapis.com/v1/places/\(placeID)?fields=displayName,shortFormattedAddress,currentOpeningHours,rating,nationalPhoneNumber,accessibilityOptions,photos,editorialSummary&key=\(APIKey)")!
    
    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
      guard let data = data else { return }
      guard let welcome = try? JSONDecoder().decode(Welcome.self, from: data)
      else { return }
      place = Place(name: welcome.displayName.text, rating: welcome.rating, address: welcome.shortFormattedAddress, openNow: welcome.currentOpeningHours.openNow, schedule: welcome.currentOpeningHours.weekdayDescriptions, phoneNumber: welcome.nationalPhoneNumber, overview: welcome.editorialSummary.text, photo: welcome.photos.first?.name ?? "", wheelchairAccessibleEntrance: welcome.accessibilityOptions.wheelchairAccessibleEntrance)
      guard let url = URL(string: "https://places.googleapis.com/v1/\(welcome.photos.first?.name ?? "")/media?maxHeightPx=220&maxWidthPx=360&key=\(APIKey)")
      else {
        return
      }
    }
    task.resume()
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
